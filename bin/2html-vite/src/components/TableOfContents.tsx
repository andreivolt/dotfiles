import { useState, useEffect } from 'react'

export interface TocItem {
  id: string
  text: string
  level: number
}

// Function to strip markdown formatting from text
function stripMarkdownFormatting(text: string): string {
  return text
    .replace(/\*\*(.*?)\*\*/g, '$1')     // Remove **bold**
    .replace(/\*(.*?)\*/g, '$1')         // Remove *italic*
    .replace(/`(.*?)`/g, '$1')           // Remove `code`
    .replace(/\[(.*?)\]\(.*?\)/g, '$1')  // Remove [link](url) -> just link text
    .replace(/~~(.*?)~~/g, '$1')         // Remove ~~strikethrough~~
    .replace(/__(.*?)__/g, '$1')         // Remove __underline__
    .replace(/_(.*?)_/g, '$1')           // Remove _italic_
    .trim()
}

export function extractTocFromMarkdown(markdown: string): TocItem[] {
  const headingRegex = /^(#{1,6})\s+(.+)$/gm
  const toc: TocItem[] = []
  let match

  while ((match = headingRegex.exec(markdown)) !== null) {
    const level = match[1].length
    const rawText = match[2].trim()
    const text = stripMarkdownFormatting(rawText)
    // Generate random ID for each heading
    const id = 'h-' + Math.random().toString(36).substr(2, 9)

    toc.push({ id, text, level })
  }

  return toc
}

interface TableOfContentsProps {
  toc: TocItem[]
  onlyRender?: boolean // For server-side rendering
}

export function TableOfContents({ toc, onlyRender = false }: TableOfContentsProps) {
  const [activeId, setActiveId] = useState<string>('')

  useEffect(() => {
    if (onlyRender) return

    const handleScroll = () => {
      const headings = toc.map(item => ({
        id: item.id,
        element: document.getElementById(item.id)
      })).filter(item => item.element)

      const scrollPosition = window.scrollY + 100

      let currentActiveId = ''
      for (const heading of headings) {
        if (heading.element && heading.element.offsetTop <= scrollPosition) {
          currentActiveId = heading.id
        }
      }

      setActiveId(currentActiveId)
    }

    window.addEventListener('scroll', handleScroll)
    handleScroll()
    return () => window.removeEventListener('scroll', handleScroll)
  }, [toc, onlyRender])

  const handleClick = (e: React.MouseEvent<HTMLAnchorElement>) => {
    if (onlyRender) return
    
    e.preventDefault()
    const href = e.currentTarget.getAttribute('href')
    if (href) {
      const targetId = href.substring(1)
      const targetElement = document.getElementById(targetId)
      
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        })
      }
    }
  }

  if (toc.length === 0) return null

  return (
    <nav className="toc">
      <ul className="toc-list">
        {toc.map((item, index) => (
          <li key={index} className={`toc-item toc-level-${item.level}`}>
            <a 
              href={`#${item.id}`} 
              className={`toc-link ${activeId === item.id ? 'active' : ''}`}
              onClick={handleClick}
            >
              {item.text}
            </a>
          </li>
        ))}
      </ul>
    </nav>
  )
}