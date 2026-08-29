# Node.js + MongoDB Docker Project

A simple containerized Node.js REST API connected to MongoDB using Docker Compose and Nginx.

## Architecture

```text
Client
  |
  | :80
  v
Nginx
  |
  | frontend-network
  v
Node.js API
  |
  | backend-network
  v
MongoDB
  |
  v
Docker Volume
```

## Tech Stack

* Node.js
* Express
* MongoDB
* Nginx
* Docker
* Docker Compose

## Features

* Multi-stage Docker build
* MongoDB authentication
* Persistent MongoDB volume
* Nginx reverse proxy
* Separate frontend and backend networks
* Container health checks
* Environment-based configuration
* Node.js runs as a non-root user

## Run the Project

Create the environment file:

```bash
cp .env.example .env
```

Start the containers:

```bash
docker compose up -d
```

Check the services:

```bash
docker compose ps
```

Access the API:

```text
http://localhost
```

## Useful Commands

```bash
docker compose logs
docker compose logs nodeapp
docker compose down
docker compose down -v
docker compose build --no-cache
```

> `docker compose down -v` removes the MongoDB volume and deletes the stored database data.

## API

| Method | Endpoint  | Description   |
| ------ | --------- | ------------- |
| GET    | `/`       | API status    |
| GET    | `/health` | Health check  |
| GET    | `/notes`  | Get notes     |
| POST   | `/notes`  | Create a note |

## Environment Variables

Copy `.env.example` to `.env` and configure the MongoDB credentials.

**Do not commit `.env` to GitHub.**
