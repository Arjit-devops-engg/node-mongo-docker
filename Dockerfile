# ---------- Builder ----------
FROM node:22-alpine AS builder

WORKDIR /app

COPY app/package*.json ./

RUN npm ci

COPY app/ .


# ---------- Production ----------
FROM node:22-alpine AS production

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/server.js ./server.js

USER node

EXPOSE 3000

CMD ["node", "server.js"]


# # ---------- Builder ----------
# FROM node:22-alpine AS builder

# WORKDIR /app

# COPY app/package*.json ./

# RUN npm ci --omit=dev

# COPY app/ .


# # ---------- Production ----------
# FROM gcr.io/distroless/nodejs22-debian12 AS production

# WORKDIR /app

# COPY --from=builder /app/node_modules ./node_modules
# COPY --from=builder /app/server.js ./server.js

# USER nonroot

# EXPOSE 3000

# CMD ["server.js"]

# # ---------- Builder ----------
# FROM node:22-alpine AS builder
# WORKDIR /app
# COPY /app/package*.json ./
# RUN npm ci 
# COPY app/ .

# # ---------- Production ----------
# FROM gcr.io/distroless/nodejs22-debian12 AS prodction

# WORKDIR /app

# # ENV NODE_ENV=production

# COPY --from=builder /app/package*.json ./
# COPY --from=builder /app/node_modules ./node_modules
# COPY --from=builder /app/server.js ./server.js

# USER nonroot

# EXPOSE 3000
# CMD [ "server.js" ]