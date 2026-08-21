# For MCP directory inspection (Glama and similar): boots the connector
# and answers initialize/tools/list. Full functionality requires the klo
# app on macOS; without it the server degrades gracefully to its local
# tool set instead of failing.
FROM node:20-slim
WORKDIR /app
COPY klo-mcp.mjs package.json ./
ENTRYPOINT ["node", "klo-mcp.mjs"]
