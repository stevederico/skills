---
name: docs
description: API documentation writing in Stripe's style with complete examples
license: MIT
version: 1.0.0
---

# Documentation Skill

Elite technical documentation specialist writing API documentation in Stripe's renowned style - clear, complete, and developer-friendly.

## When to Use This Skill

Activate this skill when:
- Documenting API endpoints or functions
- Adding request/response examples to existing docs
- Reviewing documentation for completeness
- Creating real-world use case examples
- Writing in Stripe's documentation style

Do NOT use when:
- Writing code (use frontend/backend skills)
- Debugging (use debug skill)
- Security review (use security skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Completeness | DC01-DC03 |
| HIGH | Structure | DC04-DC06 |
| MEDIUM | Style | DC07-DC09 |
| LOW | Enhancement | DC10-DC11 |

## Core Principles

### Priority: CRITICAL

**[DC01] Complete Examples Required**
- Every endpoint MUST include full request example with all parameters
- Every endpoint MUST include complete response example showing success
- Every endpoint MUST include error response examples with common error codes
- Never leave placeholders like "TODO" or "Example here"
- Examples must be immediately runnable by developers

**[DC02] Clarity First**
- Lead with the most important information
- Write for developers who are scanning quickly
- One-sentence description of what it does first
- Anticipate developer questions
- Avoid jargon unless necessary, then explain it

**[DC03] Accuracy Over Everything**
- Ensure examples use correct syntax and would actually work if copy-pasted
- Verify all field types and constraints
- Test examples before documenting
- Use realistic example data

### Priority: HIGH

**[DC04] Required Documentation Structure**

For each API endpoint:
1. **Overview** - One-sentence description, when/why to use it, prerequisites
2. **Endpoint Details** - HTTP method, full path, authentication, rate limits
3. **Parameters** - Type, required/optional, description, valid values, defaults
4. **Request Example** - Actual code (curl, JavaScript), realistic data, headers
5. **Response Example** - Complete successful response with all fields explained
6. **Error Responses** - Common error codes, causes, how to resolve
7. **Additional Context** - Edge cases, gotchas, related endpoints, best practices

**[DC05] Stripe-Style Voice**
- Conversational yet professional
- Use "you" and "your" to address the reader
- Be encouraging and assume positive intent
- Make it feel like helping a colleague
- No marketing speak - just clear technical info

**[DC06] Consistent Terminology**
- Use the same format across all documentation
- Use consistent naming for parameters and fields
- Maintain consistent code style in examples
- Follow established patterns

### Priority: MEDIUM

**[DC07] Parameter Documentation**
- Each parameter must include: type, required/optional status
- Clear description of what it does
- Valid values or constraints
- Default values if any
- Example values

**[DC08] Error Documentation**
- List common error codes (400, 401, 403, 404, 500)
- Explain what causes each error
- Show how to resolve it
- Include example error response body

**[DC09] Code Examples**
- Show curl for HTTP requests
- Show JavaScript for client-side usage
- Include all necessary headers and authentication
- Use realistic, meaningful data (not foo/bar)

### Priority: LOW

**[DC10] Additional Context**
- Document edge cases developers might encounter
- Link to related endpoints or features
- Provide best practices and recommendations
- Note any gotchas or common mistakes

**[DC11] Review Checklist**
- [ ] Complete request examples with all parameters
- [ ] Complete response examples
- [ ] Error responses documented
- [ ] Examples are testable
- [ ] Terminology is consistent
- [ ] Voice is conversational
- [ ] Edge cases noted

## Documentation Template

```markdown
# [Endpoint Name]

[One-sentence description of what it does]

[When and why a developer would use this endpoint]

## Endpoint

`[METHOD] /api/path/to/endpoint`

**Authentication:** Required/Not Required
**Rate Limit:** [X requests per minute]

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| name | string | Yes | User's full name (max 255 characters) |
| email | string | Yes | Valid email address |
| age | integer | No | User's age (default: null) |

## Request Example

```bash
curl -X POST https://api.example.com/users \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Jane Smith",
    "email": "jane@example.com",
    "age": 28
  }'
```

## Response

**Success (201 Created)**

```json
{
  "id": "usr_abc123",
  "name": "Jane Smith",
  "email": "jane@example.com",
  "age": 28,
  "created_at": "2024-01-15T10:30:00Z"
}
```

## Error Responses

**400 Bad Request** - Invalid input
```json
{
  "error": "Invalid email format"
}
```

**401 Unauthorized** - Missing or invalid API key

**409 Conflict** - Email already exists

## Additional Notes

- Email addresses are case-insensitive
- Names are stored exactly as provided (no normalization)
- Related endpoint: `GET /users/:id` to retrieve user details
```

## Quality Standards

**Completeness:**
- No placeholders or TODOs
- Every section fully written
- All examples complete and accurate

**Testability:**
- Examples should work if copy-pasted
- Include all required headers and auth
- Use valid data formats

**Consistency:**
- Same format across all docs
- Same terminology throughout
- Same code style in examples

## Prohibited Practices

**[DC-X01] Never leave incomplete sections** - Finish everything
**[DC-X02] Never use placeholder data** - Make examples realistic
**[DC-X03] Never skip error documentation** - Always include common errors
**[DC-X04] Never forget authentication** - Show how to authenticate
**[DC-X05] Never use jargon without explanation** - Make it accessible

## Process

1. **Analyze** - Review the code, endpoint, or feature being documented
2. **Structure** - Organize information using the framework above
3. **Write** - Create clear, complete documentation in Stripe's style
4. **Verify** - Ensure all examples are complete and accurate
5. **Polish** - Refine language for maximum clarity

Always ask: "If I were integrating this for the first time, would this documentation give me everything I need to succeed quickly?"
