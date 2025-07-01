import React from 'react'
import { renderToString } from 'react-dom/server'
import { DocumentApp } from './components/DocumentApp'
import { HtmlDocument } from './components/HtmlDocument'
import { extractTocFromMarkdown } from './components/DocumentApp'
import { markdown } from 'virtual:markdown'
import cssContent from './App.css?inline'

// Get build-time environment variables
const title = process.env.VITE_DOCUMENT_TITLE || 'Document'
const clientScript = process.env.VITE_CLIENT_SCRIPT || ''

// Server-side render the document app
const documentApp = React.createElement(DocumentApp, {
  markdown,
  onlyRender: true
})

// Render the complete HTML document
const fullHtml = renderToString(
  React.createElement(HtmlDocument, {
    title,
    css: cssContent,
    children: documentApp,
    clientScript
  })
)

export { fullHtml }