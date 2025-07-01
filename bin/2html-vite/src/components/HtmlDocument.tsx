interface HtmlDocumentProps {
  title: string
  css: string
  children: React.ReactNode
  clientScript: string
}

export function HtmlDocument({ title, css, children, clientScript }: HtmlDocumentProps) {
  return (
    <html lang="en">
      <head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{title}</title>
        <style dangerouslySetInnerHTML={{ __html: css }} />
      </head>
      <body>
        <div id="root">{children}</div>
        <script dangerouslySetInnerHTML={{ __html: clientScript }} />
      </body>
    </html>
  )
}