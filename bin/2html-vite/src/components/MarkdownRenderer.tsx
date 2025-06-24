import ReactMarkdown from 'react-markdown'
import remarkGfm from 'remark-gfm'
import type { TocItem } from './TableOfContents'

// Function to extract text from React children for TOC display
const getTextFromChildren = (children: any): string => {
  if (typeof children === 'string') return children
  if (typeof children === 'number') return children.toString()
  if (Array.isArray(children)) {
    return children.map(getTextFromChildren).join('')
  }
  if (children?.props?.children) {
    return getTextFromChildren(children.props.children)
  }
  return ''
}

// Track heading index for matching with TOC items in order
let headingIndex = 0


// Create heading components that use TOC IDs
const createHeadingComponent = (level: number, toc: TocItem[] = []) => ({ children, ...props }: any) => {
  // Get the next heading ID from TOC in order
  const id = toc[headingIndex]?.id || `h-${Math.random().toString(36).substr(2, 9)}`
  headingIndex++
  
  const HeadingTag = `h${level}` as keyof JSX.IntrinsicElements
  // Remove the problematic 'node' prop and any other unwanted props
  const { node, ...cleanProps } = props
  
  return <HeadingTag id={id} {...cleanProps}>{children}</HeadingTag>
}

interface MarkdownRendererProps {
  markdown: string
  toc?: TocItem[]
}

export function MarkdownRenderer({ markdown, toc = [] }: MarkdownRendererProps) {
  // Reset heading index for each render
  headingIndex = 0
  
  const components = {
    h1: createHeadingComponent(1, toc),
    h2: createHeadingComponent(2, toc),
    h3: createHeadingComponent(3, toc),
    h4: createHeadingComponent(4, toc),
    h5: createHeadingComponent(5, toc),
    h6: createHeadingComponent(6, toc)
  }

  return (
    <ReactMarkdown 
      remarkPlugins={[remarkGfm]} 
      components={components}
    >
      {markdown}
    </ReactMarkdown>
  )
}