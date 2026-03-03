# Docker Setup for Rust Playground

## Installing Docker via Scoop

Since you can't use installers, use Scoop to install Docker:

```powershell
# If Scoop isn't installed yet:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Install Docker
scoop bucket add main
scoop install docker

# Install Docker Compose (if not included)
scoop install docker-compose
```

**Note:** Scoop installs Docker CLI. For Windows, you'll also need Docker Desktop or Docker Engine running. Alternative options:

- Use WSL2 with Docker Engine
- Use Podman Desktop (also available via Scoop: `scoop install podman-desktop`)

## Workspace Structure

```
rust-plagueground/
├── project1/              # Independent Rust program 1
│   ├── Cargo.toml
│   └── src/
│       └── main.rs
├── project2/              # Independent Rust program 2
│   ├── Cargo.toml
│   └── src/
│       └── main.rs
├── Dockerfile             # Shared Dockerfile for all projects
├── docker-compose.yml     # Manage multiple containers
├── .dockerignore
└── DOCKER_SETUP.md
```

## Building Individual Projects

### Build a specific project:

```powershell
docker build -t rust-project1 --build-arg PROJECT_NAME=project1 .
```

### Run the built image:

```powershell
docker run --rm rust-project1
```

## Using Docker Compose

### Build all projects:

```powershell
docker-compose build
```

### Run a specific project:

```powershell
docker-compose run project1
```

### Run all projects:

```powershell
docker-compose up
```

## Development Workflow

### Option 1: Mount volume for live development

```powershell
docker run --rm -v ${PWD}/project1:/usr/src/app -w /usr/src/app rust:latest cargo run
```

### Option 2: Use docker-compose with watch mode

```powershell
docker-compose run --rm project1 cargo watch -x run
```

## Tips

- Each folder represents an independent Rust project with its own `Cargo.toml`
- The Dockerfile is designed to build any project by specifying the PROJECT_NAME
- Use `.dockerignore` to exclude unnecessary files and speed up builds
- Cache dependencies by copying `Cargo.toml` first before copying source code
