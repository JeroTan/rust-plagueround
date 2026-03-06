# AGENT MEMORY

**IMPORTANT FOR AI:** This document serves as a session memory log. You MUST continually update this file throughout the session to record any highlights, important updates, decisions, and progress made. This helps maintain context across interactions and provides a historical record of the work completed.

**⚠️ LINKED DOCUMENT:** Keep [KNOWLEDGE_MEMORY.md](KNOWLEDGE_MEMORY.md) updated with important concepts and patterns learned. This document tracks what we know, AGENT_MEMORY.md tracks what we did.

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

- ✅ COMPLETED: Cargo projects and commands
- ✅ COMPLETED: Custom enums with generics
- ✅ COMPLETED: Pattern matching and error handling
- Next: Continue with "The Rust Programming Language" book chapters

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
  - Excludes: /target/, _.pdb, Cargo.lock, _.exe, build artifacts
  - Excludes: IDE files (.vscode/, .idea/), OS files (Thumbs.db, .DS_Store)
  - Excludes: Editor temp files, logs, Docker overrides
  - Excludes: node_modules, Python cache, generated docs
- Removed `.exe` and `.pdb` files from git tracking (they were generated artifacts)
- Committed cleanup with proper .gitignore in place

**Cargo and Package Management**

- Created multiple Cargo projects using `cargo new` and `cargo init --name`
- Learned: `cargo build` (debug) vs `cargo build --release` (optimized)
- Learned: `cargo run` compiles and executes
- Fixed `.gitignore` to properly ignore `target/` at any directory level
- **IMPORTANT**: `Cargo.lock` handling differs by project type:
  - ✅ **Binary/App/Game**: TRACK Cargo.lock (ensures reproducible builds)
  - ❌ **Library**: DON'T track Cargo.lock (users have their own)
  - Reason: `Cargo.lock` locks dependency versions; binaries need consistency
- Updated `.gitignore` to NOT ignore Cargo.lock (our projects are binaries)

**Enums and Custom Types**

- Created custom enum `CheckResult<T, E>` similar to Rust's `Result<T, E>`
- Learned: Enums are sum types with named variants
- Learned: Pattern matching with `match` expression
- Learned: Each variant can hold different data types
- Example: `CheckResult::Success(T)` vs `CheckResult::Failure(E)`

**Generics (Key Learning!)**

- **What are generics?** Code that works with ANY type
- `<T, E>` syntax allows flexibility: `CheckResult<i32, String>`, `CheckResult<bool, MyError>`, etc.
- Rust's `Result<T, E>` uses generics to be reusable across all functions
- Generics vs specific types: Generic is flexible, specific is limited
- Created: `CheckResult<T, E>` enum that works like `Result<T, E>`

**Pattern Matching & Error Handling**

- `match` expression (Rust's way, not if-else)
  - Forces you to handle ALL cases
  - Safer than TypeScript's optional checks
- `use CheckResult::{Success, Failure}` - imports variants into scope
- Underscore `_` - ignores values you don't need
- `.expect()`, `.is_ok()`, `.is_err()` - shorthand helpers

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
- ✅ How games are built (assembly optimization)
- ✅ ASCII encoding and printing in assembly
- ✅ Platform-specific considerations (Linux vs Windows syscalls)
- ✅ Macros (`!` symbol, code generation, benefits vs functions)
- ✅ Macro vs Function comparison (performance, flexibility)
- ✅ Cargo package manager and naming conventions
- ✅ `cargo new` and `cargo init` with `--name` flag
- ✅ Project folder naming vs package naming constraints
- ✅ **Variables & Mutability** - immutable by default with `mut` keyword
- ✅ **Enums** - sum types with variants, custom error types
- ✅ **Generics** - `<T, E>` templates that work with ANY types
- ✅ **Pattern Matching** - `match` expressions force handling all cases
- ✅ **Result Type** - built-in `Result<T, E>` for error handling
- ✅ **Custom Generic Enums** - created `CheckResult<T, E>` like `Result`
- ✅ **Use Statement** - importing variants into scope
- ✅ Rust vs TypeScript differences (safety, immutability, pattern matching)
- ✅ **Traits** - A type gains power by implementing a trait (e.g., Rng trait gives ThreadRng the gen_range() method)
- ✅ **Trait Imports** - Must import trait to use its methods on types even if the type already exists
- ✅ **Shadowing** - Redeclare variables with same or different type; old values automatically dropped/freed (no memory waste)
  - **✨ CONFIRMED by official Rust book!** Book explicitly teaches shadowing pattern for type conversion (String → i32)
  - Use case: Reuse variable names instead of creating guess_str and guess separately
  - **Community consensus:** Default to shadowing for transformations; use `mut` only for repeated modifications
  - **Hybrid pattern:** Use `mut` during setup, shadow to lock as immutable (best practice in production)
- ✅ **Expressions vs Statements (Semicolon Rule)** - Key to understanding when functions return values
  - No semicolon = Expression (returns value) ✅
  - Semicolon = Statement (returns nothing/unit type) ❌
  - Idiomatic Rust: use expressions, no `return` keyword needed
  - Builder pattern relies on this: `self` with no semicolon to enable chaining
- ✅ **`match` is Rust's only conditional branching for multiple cases (NO `switch` statement!)**
  - `match` vs `switch`: match is exhaustive, no fallthrough, returns values, powerful patterns
  - Compiler forces handling ALL cases (catches bugs TypeScript switch allows)
  - Can match on ranges, tuples, enums, with guard clauses
  - Returns value (expression), not statement (different from switch)
  - Rust philosophy: one clear powerful way instead of multiple tools
- ✅ **003_guessing_game** - Started implementation; added rand crate, understood ThreadRng and method chaining
- ✅ **Conditions and Logical Operators** - Parentheses optional, only needed for precedence
  - Base rule: NO parentheses for `if` conditions (Rust design difference from TypeScript)
  - Use `&&`, `||`, `!` for multiple conditions
  - Parentheses only for operator precedence when mixing && and ||

**Summary:** Completed comprehensive introduction to Rust fundamentals including variables, shadowing, generics, custom types, error handling, pattern matching, traits, method chaining, and conditions. User has strong understanding of Rust's syntax philosophy and differences from TypeScript. Currently building 003_guessing_game with loop control.

---

### 2026-03-06 Session Update

**Major Breakthroughs:**

1. **Builder Pattern & Method Chaining** - User understood that returning `Self` with no semicolon enables fluent interfaces
2. **Expressions vs Statements** - Semicolon rule: key to understanding when functions return values
3. **Match is Rust's only tool** - Rust removed `switch`, replaced with superior exhaustive `match`
4. **Parentheses are optional** - Rust doesn't require parentheses for conditions (unlike TypeScript)
5. **Hybrid Shadowing Pattern** - Discovered production pattern: `mut` for setup, shadow to lock immutable

**User Learning Style:** Asks "why" questions, compares to TypeScript background, understands design philosophy deeply

---

_Last Updated: 2026-03-06_
