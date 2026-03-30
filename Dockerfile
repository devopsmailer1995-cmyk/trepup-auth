# Demo Node.js Backend Dockerfile for trepup-auth
# This is a simplified demo version for testing the pipeline

FROM node:20-alpine

RUN apk add --no-cache curl

WORKDIR /app

# Create a simple Express-like demo app
RUN echo '{"name":"trepup-auth","version":"1.0.0","scripts":{"start":"node dist/index.js"}}' > package.json

# Create dist directory and server
RUN mkdir -p dist && cat > dist/index.js << 'EOF'
const http = require('http');
const port = process.env.PORT || 8082;

const server = http.createServer((req, res) => {
  const url = req.url;
  
  if (url === '/health' || url === '/ready') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      status: 'healthy', 
      service: 'trepup-auth',
      port: port,
      timestamp: new Date().toISOString(),
      database: 'connected (demo)',
      jwt: 'configured (demo)'
    }));
  } else if (url === '/api/auth/login') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      message: 'Login endpoint (demo)',
      token: 'demo-jwt-token-' + Date.now()
    }));
  } else if (url === '/api/auth/register') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      message: 'Register endpoint (demo)',
      userId: 'demo-user-' + Date.now()
    }));
  } else {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      service: 'trepup-auth',
      description: 'Authentication Service - Demo',
      version: '1.0.0',
      port: port,
      endpoints: ['/health', '/ready', '/api/auth/login', '/api/auth/register'],
      environment: process.env.NODE_ENV || 'development'
    }));
  }
});

server.listen(port, () => {
  console.log('✅ Trepup Auth Service listening on port ' + port);
  console.log('🔐 JWT Authentication: Enabled (demo)');
  console.log('🗄️  Database: Connected (demo)');
});
EOF

ENV NODE_ENV=production
ENV PORT=8082

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nodejs && \
    chown -R nodejs:nodejs /app

USER nodejs

EXPOSE 8082

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8082/health || exit 1

CMD ["node", "dist/index.js"]
