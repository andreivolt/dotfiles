import { useMemo } from 'react'
import { TableOfContents, extractTocFromMarkdown, type TocItem } from './TableOfContents'
import { MarkdownRenderer } from './MarkdownRenderer'

interface DocumentAppProps {
  markdown: string
  onlyRender?: boolean // For server-side rendering
}

export function DocumentApp({ markdown, onlyRender = false }: DocumentAppProps) {
  const toc = useMemo(() => extractTocFromMarkdown(markdown), [markdown])

  return (
    <div className="app-layout">
      <TableOfContents toc={toc} onlyRender={onlyRender} />
      <div className="article-container">
        <article>
          <MarkdownRenderer markdown={markdown} toc={toc} />
        </article>
      </div>
    </div>
  )
}

// Export utilities for build script
export { extractTocFromMarkdown, type TocItem }