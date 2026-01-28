---
name: deployer
description: Railway platform deployment with optimal configuration and troubleshooting
license: MIT
version: 1.0.0
---

# Railway Deployment Skill

Expert Railway deployment engineer with deep knowledge of Railway CLI, containerized deployments, and cloud infrastructure optimization.

## When to Use This Skill

Activate this skill when:
- Deploying applications to Railway platform
- Configuring Railway services and environment variables
- Managing databases and add-ons through Railway
- Troubleshooting Railway deployments
- Setting up custom domains on Railway
- Interacting with Railway CLI

Do NOT use when:
- Writing application code (use frontend/backend skills)
- Debugging application logic (use debug skill)
- Security auditing (use security skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Deployment Verification | RD01-RD02 |
| HIGH | Configuration | RD03-RD06 |
| MEDIUM | CLI Operations | RD07-RD09 |
| LOW | Optimization | RD10-RD11 |

## Core Principles

### Priority: CRITICAL

**[RD01] Never Say "Deployed" Until Verified**
- After `railway up`, ALWAYS check logs with `railway logs --lines 10`
- Verify server started successfully before telling user
- Check for startup errors, port binding, database connections
- Confirm the service is actually responding to requests
- Deployment is NOT complete until service is confirmed running

**[RD02] Dockerfile Deployment Preferred**
- Always prefer Dockerfile over Nixpacks for full control
- Use Deno image (denoland/deno:2.1.4) when possible
- Fall back to Node.js 22+ when Deno won't work
- Set builder to DOCKERFILE in railway.json

### Priority: HIGH

**[RD03] Environment Variables**
- Set all required env vars BEFORE deployment
- Use `railway variables --set "KEY=value"`
- Never commit secrets to version control
- Verify PORT variable works with Railway's automatic assignment
- Required backend vars: JWT_SECRET, STRIPE_KEY, NODE_ENV=production

**[RD04] Single-Origin Deployment**
- For combined frontend+backend, set `backendURL: ""` in constants.json
- This makes frontend use same-origin requests (avoids CORS issues)
- Prevents CSP violations like "connect-src 'self'"
- Use `devBackendURL` for local development

**[RD05] Node.js Version Configuration**
- Railway's Nixpacks defaults to Node 18 (often too old)
- For Node 22+, add to package.json:
```json
{
  "engines": {
    "node": ">=22.5.0"
  }
}
```
- Or create `.node-version` file with: `22`
- Or set `NIXPACKS_NODE_VERSION=22` environment variable

**[RD06] CORS Configuration**
- Verify CORS allows the frontend domain
- For single-origin, CORS not needed
- For separate services, set origin to exact frontend URL
- Never use `origin: '*'` in production

### Priority: MEDIUM

**[RD07] Railway CLI Commands**
- `railway init` - Create new project
- `railway link` - Link to existing project
- `railway up` - Deploy current directory
- `railway logs` - Stream live logs
- `railway logs --lines 100` - Last 100 log lines
- `railway variables` - List all variables
- `railway variables --set "KEY=value"` - Set variable
- `railway domain` - Generate Railway domain
- `railway status` - Show deployment status

**[RD08] Database Provisioning**
- `railway add --database postgres` - Add PostgreSQL
- `railway add --database mysql` - Add MySQL
- `railway add --database redis` - Add Redis
- `railway add --database mongo` - Add MongoDB
- Railway auto-injects connection variables like `DATABASE_URL`

**[RD09] Troubleshooting Workflow**
1. Check build logs: `railway logs --build`
2. Check deployment logs: `railway logs --deployment`
3. Check live logs: `railway logs`
4. Verify environment variables: `railway variables`
5. Check service status: `railway status`

### Priority: LOW

**[RD10] Monorepo Strategy**
- Set root directory in Railway or use railway.json
- For backend: Set start command to `node server.js`
- For frontend: Set build command and output directory
- Consider single service serving both (backend serves frontend build)

**[RD11] SQLite Consideration**
- Railway uses ephemeral storage for SQLite
- Recommend switching to PostgreSQL for production persistence
- Add PostgreSQL with: `railway add --database postgres`

## Dockerfile Templates

**Deno (Preferred):**
```dockerfile
FROM denoland/deno:2.1.4
WORKDIR /app
COPY package*.json deno.json* ./
RUN deno install
COPY . .
RUN deno run build
EXPOSE 8000
CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "backend/server.js"]
```

**Node.js (Fallback):**
```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 8000
CMD ["node", "--experimental-sqlite", "backend/server.js"]
```

**railway.json for Dockerfile:**
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile"
  }
}
```

## Deployment Workflow

### New Projects:
1. Verify Railway CLI installed: `railway --version`
2. Authenticate: `railway login`
3. Initialize: `railway init`
4. Set environment variables: `railway variables --set "KEY=value"`
5. Deploy: `railway up`
6. **CRITICAL: Verify with logs**: `railway logs --lines 10`
7. Generate domain: `railway domain`

### Existing Projects:
1. Link to project: `railway link`
2. Check status: `railway status`
3. Update variables if needed
4. Deploy: `railway up`
5. **CRITICAL: Verify with logs**: `railway logs --lines 10`

## Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Build fails | Node version too old | Add engines to package.json or .node-version file |
| "bad option: --experimental-sqlite" | Node < 22.5 | Update Node version configuration |
| CORS errors | Origin mismatch | Set backendURL: "" for same-origin or configure CORS |
| CSP violation | connect-src policy | Use same-origin deployment |
| Port binding error | Wrong PORT usage | Ensure server uses process.env.PORT |
| Database connection fails | Missing env vars | Check DATABASE_URL is set |

## Security Practices

**[RD-X01] Never commit .env files**
**[RD-X02] Never log environment variables**
**[RD-X03] Use different secrets per environment**
**[RD-X04] Rotate secrets regularly**
**[RD-X05] Never hardcode credentials**

## Quality Checklist

Before completing deployment:
- [ ] All required environment variables set
- [ ] Successful build confirmed in logs
- [ ] Server started successfully (verified in logs)
- [ ] Service responds to requests
- [ ] Database connectivity verified (if applicable)
- [ ] CORS allows frontend domain (if separate services)
- [ ] Domain generated and accessible

## References

See [references/railway-commands.md](references/railway-commands.md) for:
- Complete CLI command reference
- Troubleshooting guides
- Configuration examples
- Best practices
