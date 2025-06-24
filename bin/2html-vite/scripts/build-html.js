#!/usr/bin/env node
import { build } from 'vite'
import { readFileSync, mkdirSync, rmSync } from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

// Get title from command line args
const args = process.argv.slice(2)
const titleIndex = args.findIndex(arg => arg === '-t' || arg === '--title')
const title = titleIndex !== -1 && args[titleIndex + 1] ? args[titleIndex + 1] : 'Document'

// Read markdown from stdin
let markdown = ''
for await (const chunk of process.stdin) {
  markdown += chunk
}

// Clean up common HTML entities that shouldn't be in markdown
markdown = markdown
  .replace(/&nbsp;/g, ' ')           // Convert non-breaking spaces to regular spaces
  .replace(/&amp;/g, '&')           // Convert escaped ampersands
  .replace(/&lt;/g, '<')            // Convert escaped less-than
  .replace(/&gt;/g, '>')            // Convert escaped greater-than
  .replace(/&quot;/g, '"')          // Convert escaped quotes


// Create the virtual markdown plugin inline
let markdownContent = markdown

const stdinMarkdownPlugin = () => ({
  name: 'stdin-markdown',
  resolveId(id) {
    if (id === 'virtual:markdown') {
      return id
    }
  },
  load(id) {
    if (id === 'virtual:markdown') {
      return `export const markdown = ${JSON.stringify(markdownContent)};`
    }
  }
})

// Temporary directories
const tempDir = join(__dirname, '..', '.temp')

try {
  // Clean and create temp directory
  rmSync(tempDir, { recursive: true, force: true })
  mkdirSync(tempDir, { recursive: true })

  // Build the client bundle first
  await build({
    root: join(__dirname, '..'),
    plugins: [stdinMarkdownPlugin()],
    build: {
      lib: {
        entry: 'src/client-entry.ts',
        name: 'ClientApp',
        fileName: 'client',
        formats: ['iife']
      },
      outDir: join(tempDir, 'client'),
      rollupOptions: {
        external: [],
      },
      minify: true
    },
    define: {
      'process.env.NODE_ENV': '"production"'
    },
    logLevel: 'silent'
  })

  // Read the built client script
  const clientScript = readFileSync(join(tempDir, 'client', 'client.iife.js'), 'utf-8')

  // Build the SSR bundle with client script injected
  await build({
    root: join(__dirname, '..'),
    plugins: [stdinMarkdownPlugin()],
    build: {
      lib: {
        entry: 'src/build-entry.tsx',
        name: 'SSRRenderer',
        fileName: 'ssr',
        formats: ['es']
      },
      outDir: join(tempDir, 'ssr'),
      rollupOptions: {
        external: [],
      },
      ssr: true,
      minify: false
    },
    define: {
      'process.env.NODE_ENV': '"production"',
      'process.env.VITE_DOCUMENT_TITLE': JSON.stringify(title),
      'process.env.VITE_CLIENT_SCRIPT': JSON.stringify(clientScript)
    },
    logLevel: 'silent'
  })

  const ssrPath = join(tempDir, 'ssr', 'build-entry.js')

  // Import the SSR bundle to get the final HTML
  const ssrModule = await import(ssrPath)
  const { fullHtml } = ssrModule

  // Output the complete HTML document
  console.log('<!DOCTYPE html>' + fullHtml)

} catch (error) {
  console.error('Build failed:', error)
  process.exit(1)
} finally {
  // Clean up temporary files
  try {
    rmSync(tempDir, { recursive: true, force: true })
  } catch (e) {
    // Ignore cleanup errors
  }
}