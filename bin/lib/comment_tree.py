import shutil
import textwrap
import hashlib
import sys
import io

try:
    from rich.console import Console
    from rich.markdown import Markdown
    from rich.text import Text
    from rich.color import Color
    HAS_RICH = True
except ImportError:
    HAS_RICH = False


def get_author_color(author):
    """Get a consistent background color with high contrast for white text"""
    # Return empty string if not outputting to terminal
    if not sys.stdout.isatty():
        return ""

    # Dark saturated colors that provide good contrast with white text
    colors = [
        Color.from_rgb(139, 0, 0),    # Dark red
        Color.from_rgb(0, 100, 0),    # Dark green
        Color.from_rgb(0, 0, 139),    # Dark blue
        Color.from_rgb(128, 0, 128),  # Purple
        Color.from_rgb(255, 140, 0),  # Dark orange
        Color.from_rgb(220, 20, 60),  # Crimson
        Color.from_rgb(25, 25, 112),  # Midnight blue
        Color.from_rgb(128, 128, 0),  # Olive
        Color.from_rgb(75, 0, 130),   # Indigo
        Color.from_rgb(0, 128, 128),  # Teal
        Color.from_rgb(165, 42, 42),  # Brown
        Color.from_rgb(72, 61, 139),  # Dark slate blue
    ]
    # Use hash of author name to get consistent color
    author_hash = int(hashlib.md5(author.encode()).hexdigest(), 16)
    color = colors[author_hash % len(colors)]
    rgb = color.get_truecolor()
    return f"\033[48;2;{rgb.red};{rgb.green};{rgb.blue}m"

def render_markdown(text, width):
    """Render markdown using rich and return plain text with ANSI codes"""
    # Disable colors if not outputting to terminal
    force_terminal = sys.stdout.isatty()
    console = Console(width=width, file=io.StringIO(), force_terminal=force_terminal)
    md = Markdown(text)
    console.print(md, end="")
    return console.file.getvalue()

def print_comment_tree(comments):
    """Print a tree structure of nested comments with proper indentation and spacing.

    Args:
        comments: List of comment dictionaries with keys: 'id', 'author', 'time', 'text', 'children'
    """

    # Render the tree
    def print_comment(comment, prefix="", is_last=True, is_root=False):
        # Check if this starts a back-and-forth conversation to flatten
        conversation = []
        current = comment
        remaining_children = []

        # Collect linear conversation chain
        while current:
            conversation.append({
                'author': current['author'],
                'time': current['time'],
                'text': current['text']
            })

            if not current['children']:
                break
            elif len(current['children']) == 1:
                child = current['children'][0]
                # Continue if different author for back-and-forth
                if child['author'] != current['author']:
                    current = child
                else:
                    # Same author child - stop conversation here
                    remaining_children = current['children']
                    break
            else:
                # Multiple children - check if they're all from same author
                authors = set(child['author'] for child in current['children'])
                if len(authors) == 1:
                    # All children same author
                    next_author = list(authors)[0]
                    if next_author != current['author']:
                        # Different author, merge all children into one and continue
                        merged_child = current['children'][0].copy()
                        texts = []
                        all_grandchildren = []
                        for child in current['children']:
                            if child['text']:
                                texts.append(child['text'])
                            all_grandchildren.extend(child['children'])
                        merged_child['text'] = '\n\n'.join(texts)
                        merged_child['children'] = all_grandchildren
                        current = merged_child
                    else:
                        # Same author children - stop conversation
                        remaining_children = current['children']
                        break
                else:
                    # Multiple different authors - stop conversation here
                    remaining_children = current['children']
                    break

        # Check if this is actually a back-and-forth conversation (alternating authors)
        is_alternating = True
        if len(conversation) >= 3:
            for i in range(1, len(conversation)):
                if conversation[i]['author'] == conversation[i-1]['author']:
                    is_alternating = False
                    break

        # If we have a meaningful alternating conversation (3+ exchanges), flatten it
        if len(conversation) >= 3 and is_alternating:
            # Print the first author's info with bright background
            author_color = get_author_color(comment['author'])
            reset = "\033[0m" if sys.stdout.isatty() else ""
            name = f"{author_color}{comment['author']}{reset} ({comment['time']})"
            if is_root:
                print(f"{name}")
            else:
                symbol = "└── " if is_last else "├── "
                print(f"{prefix}{symbol}{name}")

            # Print the flattened conversation
            terminal_width = shutil.get_terminal_size().columns
            if is_root:
                text_prefix = ""
            else:
                text_prefix = prefix + ("    " if is_last else "│   ")
            available_width = max(40, terminal_width - len(text_prefix))

            for i, msg in enumerate(conversation):
                if msg['text']:
                    # Add author label with bright background
                    if i > 0:
                        print(f"{text_prefix}")
                        author_color = get_author_color(msg['author'])
                        reset = "\033[0m" if sys.stdout.isatty() else ""
                        print(f"{text_prefix}{author_color}{msg['author']}{reset} ({msg['time']})")

                    rendered_text = render_markdown(msg['text'], available_width)

                    for line in rendered_text.split('\n'):
                        if line.strip():
                            print(f"{text_prefix}{line}")

            # Use the remaining children we collected
        else:
            # Normal single comment rendering with bright background
            author_color = get_author_color(comment['author'])
            reset = "\033[0m" if sys.stdout.isatty() else ""
            name = f"{author_color}{comment['author']}{reset} ({comment['time']})"
            if is_root:
                print(f"{name}")
            else:
                symbol = "└── " if is_last else "├── "
                print(f"{prefix}{symbol}{name}")

            if comment['text']:
                terminal_width = shutil.get_terminal_size().columns
                if is_root:
                    text_prefix = ""
                else:
                    text_prefix = prefix + ("    " if is_last else "│   ")
                available_width = max(40, terminal_width - len(text_prefix))

                rendered_text = render_markdown(comment['text'], available_width)

                for line in rendered_text.split('\n'):
                    if line.strip():
                        print(f"{text_prefix}{line}")

            remaining_children = comment['children']

        # Print remaining children
        if remaining_children:
            if is_root:
                tree_continuation = ""
            else:
                tree_continuation = prefix + ("    " if is_last else "│   ")
            print(tree_continuation)

            for i, child in enumerate(remaining_children):
                if is_root:
                    child_prefix = ""
                else:
                    child_prefix = prefix + ("    " if is_last else "│   ")
                child_is_last = (i == len(remaining_children) - 1)
                print_comment(child, child_prefix, child_is_last)

    for i, comment in enumerate(comments):
        is_last = (i == len(comments) - 1)
        print_comment(comment, "", is_last, True)

        # Add separator line between top-level siblings
        if not is_last:
            print()