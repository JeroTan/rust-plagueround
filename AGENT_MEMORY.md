# AGENT MEMORY

**IMPORTANT FOR AI:** This document serves as a session memory log. You MUST continually update this file throughout the session to record any highlights, important updates, decisions, and progress made. This helps maintain context across interactions and provides a historical record of the work completed.

---

## Summary

This is a Rust playground workspace created for learning and experimenting with Rust programming. The workspace was initialized on March 3, 2026, and is connected to the GitHub repository at https://github.com/JeroTan/rust-plagueround.git.

**Current State:**

- Docker configuration completed for multi-project setup
- Workspace structure supports multiple independent Rust programs
- Each project folder will be a separate Rust program with its own Cargo.toml
- Git repository pushed to GitHub
- Started exploring Cargo package manager
- Multiple Cargo projects created: 002_hello_cargo, 003_cargo_name

**Key Decisions:**

- Using Docker for containerization of Rust projects
- Multi-stage Dockerfile for optimized builds with dependency caching
- Docker Compose for managing multiple projects simultaneously
- Scoop-based installation approach (no installers) for Windows environment
- Decided NOT to rush into Cargo/Docker—learning fundamentals first with rustc

**Active Tasks:**

- Exploring Cargo.toml and project structure
- Learning Cargo commands (build, run, etc.)
- Understanding package naming conventions

---

## Timeline

### 2026-03-03

**Initial Setup**

- Created AGENT_MEMORY.md to track session progress
- Workspace designated as a Rust programming playground
- Git remote configured: https://github.com/JeroTan/rust-plagueround.git
- Initial push to GitHub completed

**Docker Configuration**

- Created comprehensive Docker setup for multiple independent Rust programs
- **Dockerfile**: Multi-stage build with ARG for PROJECT_NAME to build any project
  - Stage 1: Builds Rust project with dependency caching
  - Stage 2: Minimal runtime image based on Debian slim
- **docker-compose.yml**: Orchestration for multiple projects + dev container
- **.dockerignore**: Optimized to exclude unnecessary files for faster builds
- **DOCKER_SETUP.md**: Complete guide including Scoop installation instructions
- **README.md**: Quick start guide for the workspace
- Structure supports folder-based organization: each folder = independent Rust project

**First Rust Program**

- Verified Rust (1.82.0) and Cargo (1.82.0) installations
- Created `001_hello_world` project folder
- Followed "The Rust Programming Language" book step-by-step
- Wrote and compiled first program using `rustc main.rs`
- Successfully executed `.\main.exe` to see "Hello, world!"
- Learning workflow: compile with rustc → run .exe on Windows

**VS Code & Development Setup**

- Installed Rust Analyzer extension for enhanced development experience
- Created `.vscode/settings.json` with auto-formatting configuration
  - Rust Analyzer set as default formatter for Rust files
  - Enabled `formatOnSave` for automatic code formatting
  - Set `editor.tabSize: 4` for 4-space indentation (Rust standard)
  - Set `editor.insertSpaces: true` to use spaces instead of tabs
- Established VS Code setup as recommended template for all workspace projects
- Now code will auto-format when saved using rustfmt

**Git Configuration**

- Created comprehensive `.gitignore` for Rust projects
  - Excludes: /target/, *.pdb, Cargo.lock, *.exe, build artifacts
  - Excludes: IDE files (.vscode/, .idea/), OS files (Thumbs.db, .DS_Store)
  - Excludes: Editor temp files, logs, Docker overrides
  - Excludes: node_modules, Python cache, generated docs
- Removed `.exe` and `.pdb` files from git tracking (they were generated artifacts)
- Committed cleanup with proper .gitignore in place

**Cargo Projects Created**

- **001_hello_world**: Simple `rustc` compiled program (no Cargo)
- **002_hello_cargo**: Cargo project with name `hello_cargo`
  - Created using: `cargo init --name hello_cargo`
  - Contains: Cargo.toml, src/main.rs, .gitignore
- **003_cargo_name**: Cargo project with name `cargo_name`
  - Created using: `cargo new 003_cargo_name --name cargo_name`
  - Demonstrates: `cargo new` with custom package name

---

## Notes & Context

⚠️ **IMPORTANT RECOMMENDATION FOR NEW PROJECTS:**
When setting up a new Rust project in this workspace, **ALWAYS ask the user if they want to add VS Code configuration**. See "VS Code Setup Template" section below.

- This workspace is for experimentation and learning Rust
- Feel free to try different Rust concepts, patterns, and projects
- Any significant code, patterns, or learnings should be documented here

**VS Code Setup Template** ✨

A workspace-wide `.vscode/settings.json` has been created with the following recommended configuration for all Rust projects:

```json
{
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer",
    "editor.formatOnSave": true,
    "editor.tabSize": 4,
    "editor.insertSpaces": true
  }
}
```

**Why this is important:**

- Ensures consistency across all Rust projects in the workspace
- Automatically formats code on save using rustfmt
- Sets 4-space indentation (Rust standard, not 2 or tabs)
- Reduces manual formatting and speeds up development

**For new projects:** When user creates new project folders, recommend copying `.vscode/settings.json` to each project's `.vscode/` folder for consistent formatting.

**Docker Architecture:**

- Each project folder is completely independent with its own Cargo.toml
- Single Dockerfile handles all projects via build argument
- Docker Compose manages multiple projects simultaneously
- Development container (dev service) available for interactive work

**Installation Note:**

- Laptop doesn't support standard installers
- Using Scoop package manager for all tools
- Alternative: Podman Desktop if Docker Desktop not available

**Learning Progression** 📚

**Current Phase: Learning Fundamentals**
- Learning through "The Rust Programming Language" book step-by-step
- Using `rustc` to compile and understand the basics
- Will progress to Cargo and Docker once fundamentals are solid
- **DO NOT rush into Cargo/Docker** - Build strong foundation first

**Future Phases (When Ready):**
1. Cargo basic projects
2. Managing dependencies
3. Cargo features
4. Then: Docker containerization

**Topics Explored Today:**
- ✅ Pipes & Standard I/O (stdin, stdout, stderr)
- ✅ Command-line arguments and how to pass data to programs
- ✅ Assembly language - direct translation to binary
- ✅ Registers (AX, BX, CX, etc.) - CPU's fast storage
- ✅ Why `main()` function exists universally in programming languages
- ✅ Multiple programs communicating (IPC concepts)
- ✅ How games are built (assembly optimization in performance-critical parts)
- ✅ ASCII encoding and printing in assembly
- ✅ Platform-specific considerations (Linux vs Windows syscalls)
- ✅ Macros (`!` symbol, code generation, benefits vs functions)
- ✅ Macro vs Function comparison (performance, flexibility, debugging)
- ✅ Cargo package manager and naming conventions
- ✅ `cargo new` and `cargo init` with `--name` flag
- ✅ Project folder naming vs package naming constraints

---

_Last Updated: 2026-03-03_
