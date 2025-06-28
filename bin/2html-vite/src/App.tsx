import { useState, useEffect } from 'react'
import { DocumentApp } from './components/DocumentApp'
import './App.css'

const defaultMarkdown = `# Welcome to 2html

This is a **markdown preview** with enhanced styling.

## Features

- GitHub Flavored Markdown support
- Syntax highlighting for code blocks
- Responsive design
- Dark mode support
- Beautiful typography

### Code Example

\`\`\`javascript
function greet(name) {
  return \`Hello, \${name}!\`;
}

console.log(greet('World'));
\`\`\`

### Lists

1. First item
2. Second item
   - Nested item
   - Another nested item
3. Third item

### Blockquote

> "The best way to predict the future is to invent it."
> — Alan Kay

### Table

| Feature | Status | Notes |
|---------|--------|-------|
| Markdown | ✓ | Full GFM support |
| Styling | ✓ | Enhanced typography |
| Dark mode | ✓ | Automatic detection |

### Image Example

![Nature landscape](https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=400&fit=crop&auto=format)
`

function App() {
  const [markdown, setMarkdown] = useState(defaultMarkdown)
  const [title, setTitle] = useState('Document')

  useEffect(() => {
    // Check if we're in dev mode and have markdown content from URL params
    const params = new URLSearchParams(window.location.search)
    const urlMarkdown = params.get('markdown')
    const urlTitle = params.get('title')

    if (urlMarkdown) {
      setMarkdown(decodeURIComponent(urlMarkdown))
    }
    if (urlTitle) {
      setTitle(decodeURIComponent(urlTitle))
      document.title = decodeURIComponent(urlTitle)
    }
  }, [])

  return <DocumentApp markdown={markdown} />
}

export default App