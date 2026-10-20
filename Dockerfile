FROM node:24-alpine AS base

FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY package.json package-lock.json ./

RUN npm config set registry 'https://registry.npmmirror.com/'
RUN npm ci --registry=https://registry.npmmirror.com/ --fetch-retries=5 --fetch-timeout=600000

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# 构建时注入后端 API 地址（NEXT_PUBLIC_ 前缀变量会在 next build 时内联进客户端代码）
ARG NEXT_PUBLIC_API_HOST_URL
ENV NEXT_PUBLIC_API_HOST_URL=${NEXT_PUBLIC_API_HOST_URL}

RUN npm run build

FROM base AS runner
WORKDIR /app

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/.next/server ./.next/server

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
