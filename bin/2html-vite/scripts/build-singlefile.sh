#!/bin/bash

# Build HTML and process with single-file to embed all resources
temp_file=$(mktemp /tmp/2html.XXXXXX.html)

# Generate HTML from markdown
node scripts/build-html.js > "$temp_file"

# Process with single-file to embed all external resources
bunx single-file-cli \
  --block-images=false \
  --block-scripts=false \
  --timeout=30000 \
  "file://$temp_file"

# Clean up
rm "$temp_file"