---
title: "Mastering Docker & CI/CD"
date: "2026-03-14"
category: "backend"
description: "Until the day 'it works on my machine' disappears. A practical guide covering Docker core concepts, layer caching, multi-stage builds, multi-tenant operations, CI/CD pipeline automation, and environment variable security."
tags: ["Docker", "CI/CD", "GitHub Actions", "AWS ECR", "DevOps"]
thumbnail: ""
---

## 1. Why Docker Exists — "It Works on My Machine"

Every developer has heard it at least once. "It works on my machine."

The local machine runs Java 8 but the server runs Java 11 so behavior differs. The local machine is Windows but the server is Linux so paths break. And every time a new team member joins, an entire day is lost just setting up the environment.

Docker was created to solve exactly this. It **defines the runtime environment itself as code and packages everything together**, so it runs identically no matter where it's executed.

## 2. VM vs Container

So what's the difference between a traditional virtual machine (VM) and a container like Docker?

| **Item** | **VM (Virtual Machine)** | **Container** |
| --- | --- | --- |
| **Boot time** | Tens of seconds to minutes | Within seconds |
| **Size** | Heavy, in GB | Lightweight, in MB |
| **OS** | Must include a full Guest OS | Shares the Host OS kernel |
| **Isolation** | Very strong | Slightly lower, but practical |

VMs are heavy and slow because they carry an entire OS. Containers share the kernel, making them far lighter and faster.

## 3. Four Core Concepts

Here are the four core concepts you must understand to work with Docker.

**① Image**

A read-only template for creating containers. It's a perfect analogy for a "class" in object-oriented programming. Docker Hub hosts countless public images created by people around the world.

**② Container**

A running "instance" of an image. You can spin up multiple containers from the same image. One important caveat: when a container is deleted, all data inside it is lost too — this is solved later with the "Volume" concept.

**③ Dockerfile**

The file that defines *how* to build an image.

```dockerfile
FROM node:18-alpine      # Which base image to use
WORKDIR /app             # Where to set the working directory
COPY . .                 # How to copy files
RUN npm install          # What build command to run
EXPOSE 3000              # Which port to open
CMD ["npm", "start"]     # What command to run when the container starts
```

Write it like a recipe.

**④ Docker Compose**

In practice, you rarely run just one container. Docker Compose lets you define and run multiple containers — frontend, backend, DB — all at once.

```yaml
services:
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
  backend:
    build: ./backend
    ports:
      - "8080:8080"
  db:
    image: mariadb:10.6
```

Manage all your services in a single `yaml` file.

## 4. Layer Caching

To optimize performance, you need to understand **layer caching**. Each instruction in a Dockerfile creates one "layer" stacked on top of the previous. On a rebuild, layers after the first changed layer are rebuilt, while unchanged layers are reused from cache.

```dockerfile
# ❌ Bad
COPY . .
RUN npm install     # Reruns the heavy install every time any source file changes

# ✅ Good
COPY package.json package-lock.json ./
RUN npm install     # Reuses cache when no packages changed
COPY . .            # Then copy the rest of the source
```

## 5. Multi-stage Build

A technique that dramatically reduces image size. The idea is to separate the build environment from the runtime environment. A standard build can easily exceed 1GB, but multi-stage can bring it down below 200MB.

```dockerfile
# [Build stage]
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# [Runtime stage] — only the build output is carried over
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
EXPOSE 3000
CMD ["npm", "start"]
```

Discard the unnecessary build tools and keep only the lean essentials.

## 6. Networking / Volumes

**Networking:** Containers in the same Compose file can communicate with each other using just the service name — no IP address needed.

```yaml
environment:
  DB_HOST: mariadb   # Use service name instead of a complex IP
```

**Volumes** solve the data loss problem mentioned earlier. By mounting an external storage location, data persists even if the container is deleted.

```yaml
volumes:
  - db-data:/var/lib/mysql  # Maps an internal container path to an external volume
volumes:
  db-data:
```

## 7. Essential Commands

```bash
# [Images]
docker pull nginx                # Download an image from Docker Hub
docker images                    # List locally available images
docker rmi nginx                 # Delete an image you no longer need

# [Running containers]
docker run -d -p 3000:3000 my-portfolio   # Run in background (-d) and map port (-p)
docker run -d --name my-app my-portfolio  # Assign an easy-to-remember name (--name)

# [Managing containers]
docker ps                        # List currently running containers
docker ps -a                     # List all containers, including stopped ones
docker stop my-app               # Stop a container
docker rm my-app                 # Delete a container
docker logs my-app               # View logs when something goes wrong
docker exec -it my-app sh        # Shell into a running container

# [Docker Compose]
docker compose up -d             # Start all services at once
docker compose down              # Stop and remove all containers
docker compose logs -f           # Stream logs from all services in real time
docker compose ps                # Check the status of Compose services
```

---

## 8. Real-world Case — Multi-tenant Architecture

We currently run a multi-tenant setup where a single backend server handles multiple clients.

```
     [ Single Backend Server ]
            ↓
┌──────────────────────────┐
│   Client A    DB (isolated) │
│   Client B    DB (isolated) │
│   Client C    DB (isolated) │
└──────────────────────────┘
```

The reasons for running this architecture are clear.

- **Cost savings:** Giving each client its own server multiplies costs by n.
- **Unified management:** Deployments, monitoring, and incident response all happen in one place.
- **Traffic distribution:** Each client has different peak hours, so the risk of simultaneous overload is low.

With Docker, the server environment is locked to an image so it runs identically anywhere. DB routing is cleanly separated by passing different environment variables per client. If a failure occurs, only the affected container needs to be restarted for a fast recovery.

---

## 9. Production Deployment Flow

**Step 1. Manual Deployment**

`Write code → docker build → ECR push → SSH into EC2 → docker pull → docker run`

Hidden issues lurk at every step.

- `docker build`: Out of memory, package install failures, missing environment variables.
- `docker push`: Auth errors (when uploading layers to AWS ECR), size limits, slow network.
- `docker pull`: ECR permission misconfiguration on EC2, running out of disk space.
- `docker run`: Port conflicts, containers crashing immediately due to missing env vars.

**Step 2. CI/CD Automation**

Once you've confirmed manual deployment works reliably, move on to automation.

`Code push (GitHub) → GitHub Actions triggers → Build image + run tests → Push to AWS ECR → Server auto-pulls + restarts → Deployment complete`

---

## 10. Live Demo

The flow: modify code → `git push` → GitHub Actions triggers → EC2 runs `docker build` → multi-stage build and layer caching logs confirmed → deployment verified in the browser.

Our integrated CMS has 1 backend and 11 clients intertwined, so building everything takes too long. Instead, we **detect changed directories and build in parallel (Change Detection)**.

One important note: modifying `packages/**` common logic triggers a full rebuild of all 11 clients. This is intentional behavior, not a broken pipeline — factor in the build time whenever working on shared packages.

---

## 11. Troubleshooting 911

**First, the pipeline is stuck for no apparent reason.** Someone likely ran a deployment that got stuck, leaving a `/tmp/integrated-cms-{env}-deploy.lock` file behind. SSH into the server and delete this lock file to get the pipeline moving again.

**Second, a critical bug appears right after deployment.** Do not panic and start writing a hotfix. Immediately run `bluegreen-deploy.sh --rollback`. Nginx will instantly route traffic back to the previous slot that was running just fine moments ago.

---

## 12. Environment Variable Management

**Never do this.**

```dockerfile
# ❌ Never — this value is baked into the image permanently
ENV DB_PASSWORD=mypassword123
```

**Option 1. Inject with `-e`**

```bash
docker run -d -p 3000:3000 -e DB_PASSWORD=mypassword123 my-portfolio
```

Simple, but the password ends up in your terminal history — not recommended for production.

**Option 2. Inject with `.env` file (recommended)**

```bash
# Inside .env
DB_PASSWORD=mypassword123
JWT_SECRET=mysecret
```

```bash
docker run -d --env-file .env -p 3000:3000 my-portfolio
```

```yaml
# docker-compose.yml
services:
  backend:
    env_file:
      - .env
```

**Option 3. AWS Secrets Manager (strongly recommended for production)**

The safest approach. EC2 fetches values from AWS Secrets Manager or Parameter Store at runtime and injects them into containers. Sensitive information never exists as a file anywhere on the server.

Always add the following to `.gitignore`:

```
.env
.env.local
.env.production
```

Instead, commit a `.env.example` file with key names but empty values — team members can instantly see which environment variables are required.

## 13. A Taste of Orchestration

One final topic to close out: **orchestration**, the next step beyond Docker.

Docker Compose is a tool for a single server. When you scale out to multiple servers forming a cluster, **Kubernetes (K8s)** comes into play.

| **Item** | **Docker Compose** | **Kubernetes (K8s)** |
| --- | --- | --- |
| **Scale** | Single server | Multi-server cluster |
| **Auto-restart** | Limited | Fully automated |
| **Auto-scaling** | None | Supported (scales up/down with traffic) |
| **Complexity** | Easy | Very high |

An analogy: **Compose is a team lead manually wrangling a small team**, while **Kubernetes is a sophisticated HR system autonomously governing an organization of hundreds**.

---

That's everything. Go hands-on with what you've learned and become the true owner of your pipeline.
