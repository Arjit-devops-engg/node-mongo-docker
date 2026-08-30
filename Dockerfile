# ---------- Builder ----------
FROM node:22-alpine AS builder

WORKDIR /app

COPY app/package*.json ./

RUN npm ci

COPY app/ .

# ---------- Production dependencies ----------
FROM node:22-alpine AS production-deps

WORKDIR /app

COPY app/package*.json ./

RUN npm ci --omit=dev


# ---------- Production ----------
FROM node:22-alpine AS production

WORKDIR /app

ENV NODE_ENV=production

COPY --from=production-deps /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/package*.json ./

USER node

EXPOSE 3000

CMD ["node", "server.js"]

# # ---------- Builder ----------
# FROM node:22-alpine AS builder

# WORKDIR /app

# COPY app/package*.json ./

# RUN npm ci

# COPY app/ .


# # ---------- Production ----------
# FROM node:22-alpine AS production

# WORKDIR /app

# ENV NODE_ENV=production

# COPY --from=builder /app/package*.json ./
# COPY --from=builder /app/node_modules ./node_modules
# COPY --from=builder /app/server.js ./server.js

# USER node

# EXPOSE 3000

# CMD ["node", "server.js"]