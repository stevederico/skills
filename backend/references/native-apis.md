# Native Node.js API Alternatives

Avoid external packages by using native Node.js capabilities.

## HTTP Requests

```javascript
// ❌ AVOID: axios, node-fetch (in Node 18+), got, request
import axios from 'axios'

// ✅ USE: Native fetch (available in Node.js 18+)
const response = await fetch('https://api.example.com/data')
const data = await response.json()

// With POST
const response = await fetch('https://api.example.com/users', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ name: 'John' })
})
```

## File Operations

```javascript
// ❌ AVOID: fs-extra, graceful-fs
import fs from 'fs-extra'

// ✅ USE: Native fs/promises
import { readFile, writeFile, mkdir } from 'fs/promises'
const data = await readFile('file.txt', 'utf-8')
await writeFile('output.txt', data)
await mkdir('newdir', { recursive: true })
```

## Path Manipulation

```javascript
// ✅ USE: Native path module
import path from 'path'
const filePath = path.join(__dirname, 'uploads', 'image.png')
const ext = path.extname(filename)
```

## URL Parsing

```javascript
// ❌ AVOID: query-string, qs packages for simple parsing
// ✅ USE: Native URL and URLSearchParams
const url = new URL('https://example.com/path?foo=bar&baz=qux')
console.log(url.searchParams.get('foo')) // 'bar'
const params = new URLSearchParams('foo=bar&baz=qux')
```

## UUID Generation

```javascript
// ❌ AVOID: uuid package for simple use cases
import { v4 as uuidv4 } from 'uuid'

// ✅ USE: Native crypto for random IDs (Node 15.6+)
import { randomUUID } from 'crypto'
const id = randomUUID() // e.g., '9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d'
```

## Hashing

```javascript
// ❌ AVOID: md5, sha1 packages
// ✅ USE: Native crypto
import { createHash } from 'crypto'
const hash = createHash('sha256').update('data').digest('hex')
```

## Environment Variables

```javascript
// ✅ USE: Native process.env
const apiKey = process.env.API_KEY

// For development, dotenv is acceptable:
// import 'dotenv/config' // at top of entry file only
```

## Date/Time

```javascript
// ❌ AVOID: moment, date-fns for simple operations
// ✅ USE: Native Date and Intl APIs
const now = new Date()
const formatted = new Intl.DateTimeFormat('en-US').format(now)
const isoString = now.toISOString()
```

## JSON Parsing

```javascript
// ✅ USE: Native JSON
const obj = JSON.parse(jsonString)
const str = JSON.stringify(obj)
```

## Decision Framework

1. Can native Node.js do this? → Use native
2. Is it a one-time simple operation? → Write custom code
3. Does it require specialized domain knowledge? → Consider package
4. Is it a complex, well-tested algorithm? → Package may be justified
5. When in doubt → Prefer native or custom code
