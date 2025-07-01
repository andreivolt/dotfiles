import { extractTocFromMarkdown } from './components/DocumentApp'
import { markdown } from 'virtual:markdown'
import './client'

// Inject TOC data for client-side functionality
const toc = extractTocFromMarkdown(markdown);
(window as any).__TOC_DATA__ = toc;