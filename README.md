# Node.js + MongoDB Docker Project

A containerized Node.js REST API connected to MongoDB using Docker Compose.

## Architecture

```text
                    Host
                     |
                    :80
                     |
                     v
                  Nginx
                     |
              frontend-network
                     |
                     v
                  Node.js
                     |
               backend-network
                     |
                     v
                  MongoDB
                     |
                     v
                mongo-data