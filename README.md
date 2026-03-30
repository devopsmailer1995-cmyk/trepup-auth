# Trepup Auth - Backend Demo

Node.js Authentication Service deployed to AWS ECS Fargate.

## Features

- ✅ Express + Prisma (Demo)
- ✅ JWT Authentication (Demo)
- ✅ GitHub Actions CI/CD with OIDC
- ✅ Docker containerization
- ✅ ECS Fargate deployment
- ✅ Health check endpoint
- ✅ Database migrations (Demo)

## Deployment

Push to `main` branch triggers automatic deployment:

```bash
git add .
git commit -m "Deploy changes"
git push origin main
```

## Configuration

- **Port**: 8082
- **Health Check**: `/health` and `/ready`
- **Database**: PostgreSQL (Demo)
- **JWT**: Configured (Demo)

## API Endpoints

- `GET /health` - Health check
- `GET /ready` - Readiness check
- `POST /api/auth/login` - Login (Demo)
- `POST /api/auth/register` - Register (Demo)

## Workflow

See `.github/workflows/deploy-backend.yml` for the complete CI/CD pipeline.

## Repository

https://github.com/devopsmailer1995-cmyk/trepup-auth
# Trigger deployment
