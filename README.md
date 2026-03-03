# Rust Playground 🦀

A Dockerized workspace for experimenting with multiple independent Rust programs.

## Quick Start

### Prerequisites

Install Docker via Scoop (see [DOCKER_SETUP.md](DOCKER_SETUP.md) for details):

```powershell
scoop install docker
```

### Create a New Project

```powershell
# Create a new Rust project
cargo new project1

# Or use cargo init in an existing directory
mkdir project1
cd project1
cargo init
cd ..
```

### Build and Run with Docker

```powershell
# Build a specific project
docker build -t rust-project1 --build-arg PROJECT_NAME=project1 .

# Run it
docker run --rm rust-project1
```

### Using Docker Compose

```powershell
# Build all projects
docker-compose build

# Run a specific project
docker-compose run project1

# Start development container
docker-compose run dev bash
```

## Project Structure

Each subdirectory is an independent Rust project:

```
rust-plagueground/
├── project1/           # Your Rust experiments
├── project2/           # Another independent project
├── Dockerfile          # Shared Docker configuration
└── docker-compose.yml  # Multi-project orchestration
```

## Development Tips

- Each project has its own `Cargo.toml` and is completely independent
- Use the `dev` service for interactive development with full Rust toolchain
- Build artifacts are cached in Docker layers for faster rebuilds
- See [DOCKER_SETUP.md](DOCKER_SETUP.md) for detailed instructions

## Repository

https://github.com/JeroTan/rust-plagueround.git
