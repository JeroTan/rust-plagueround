# KNOWLEDGE MEMORY

**IMPORTANT FOR AI:** This document logs important knowledge, concepts, and patterns learned. Update this whenever discovering significant Rust concepts or patterns. Reference this when teaching new topics to the user.

---

## Core Rust Concepts

### 1. Variables and Mutability

**Immutable by default (Safety First!):**

```rust
let x = 5;
x = 10;  // ❌ ERROR: Cannot assign twice to immutable variable
```

**Mutable with `mut` keyword:**

```rust
let mut x = 5;
x = 10;  // ✅ OK
```

**Comparison with TypeScript:**

- Rust: `let` = immutable (like `const`)
- TypeScript: `let` = mutable (like JavaScript's `let`)
- Rust forces intentionality: you must declare `mut` if you plan to change

### 2. Enums (Sum Types)

**What:** A type that can be ONE of several variants

```rust
enum Result<T, E> {
    Ok(T),      // Success variant with value T
    Err(E),     // Error variant with value E
}
```

**Custom enum example:**

```rust
enum CheckResult<T, E> {
    Success(T),
    Failure(E),
}
```

**Key difference from TypeScript:**

- Rust: Compiler forces you to handle ALL variants
- TypeScript: Easy to forget checking `error` property

### 3. Generics (Template Types)

**What:** Code that works with ANY type

**Syntax:** `<T>`, `<T, E>`, etc.

```rust
enum CheckResult<T, E> {
    Success(T),   // T = any success type (i32, String, bool, etc.)
    Failure(E),   // E = any error type
}

// Usage examples:
CheckResult<i32, String>           // i32 success, String error
CheckResult<String, io::Error>     // String success, I/O error
CheckResult<bool, MyCustomError>   // bool success, custom error
```

**Why Generics Matter:**

- ✅ ONE enum works for infinite use cases
- ✅ Type-safe (compiler checks)
- ✅ No runtime overhead (monomorphization)
- ❌ Without generics: need separate CheckResult_i32, CheckResult_String, etc.

### 4. Pattern Matching (`match`)

**What:** Rust's way of destructuring and handling all cases

```rust
match result {
    Ok(value) => println!("Success: {}", value),
    Err(error) => println!("Error: {}", error),
}
```

**Key features:**

- Forces you to handle ALL variants
- Can extract values from variants
- `_` wildcard ignores values
- More powerful than if-else

**Comparison with TypeScript:**

```typescript
// TypeScript (easy to forget error case)
if (result.success) {
  console.log(result.value);
} else if (result.error) {
  // Easy to forget!
  console.log(result.error);
}
```

```rust
// Rust (compiler forces both cases)
match result {
    Ok(v) => println!("{}", v),    // Must handle
    Err(e) => println!("{}", e),   // MUST handle, compiler error if missing
}
```

### 5. Result Type

**Built-in enum for error handling**

```rust
enum Result<T, E> {
    Ok(T),      // Success
    Err(E),     // Failure
}
```

**Methods:**

- `.is_ok()` → `true` if Ok
- `.is_err()` → `true` if Err
- `.expect(msg)` → Unwrap or crash with message
- `match` → Pattern match both cases

**Functions that can fail return Result:**

```rust
fn read_line(&mut self, buf: &mut String) -> Result<usize, io::Error>
// Either: Ok(usize) = bytes read, or Err(io::Error) = failed
```

### 6. The `use` Statement

**What:** Imports names into scope

```rust
// Without use (verbose):
CheckResult::Success(5)
CheckResult::Failure("error")

// With use (clean):
use CheckResult::{Success, Failure};
Success(5)
Failure("error")
```

**Scope:**

- **Module-level** (outside functions): Available everywhere below
- **Function-level** (inside function): Only available in that function

**NOT like TypeScript destructuring:**

- TypeScript: Extracts data FROM something at runtime
- Rust: Imports names INTO scope at compile time

---

## Rust vs TypeScript: Key Differences

| Aspect               | Rust                     | TypeScript                |
| -------------------- | ------------------------ | ------------------------- |
| **Immutability**     | Default (must use `mut`) | Mutable by default        |
| **Error Handling**   | Forced with `Result`     | Optional (easy to forget) |
| **Type Errors**      | Compile-time (safe)      | Runtime (can crash)       |
| **Generics**         | Built-in, powerful       | Through unions/overloads  |
| **Pattern Matching** | `match` expression       | if-else chains            |
| **Safety**           | Memory-safe by design    | Trust developers          |

---

## Cargo Commands (Essential)

```powershell
cargo new project_name              # Create new Cargo project
cargo init                          # Initialize in current directory
cargo build                         # Compile (debug)
cargo build --release              # Compile (optimized)
cargo run                           # Compile + run (debug)
cargo run --release                # Compile + run (optimized)
cargo check                         # Check without building (fast)
```

---

## Cargo.lock: When to Track?

**The Question:** Should we commit `Cargo.lock` to git?

**Answer:** Depends on project type!

| Project Type | Track Cargo.lock? | Why |
|---|---|---|
| **Binary/App/Game** | ✅ YES | Ensures everyone uses same dependency versions (reproducibility) |
| **Library** | ❌ NO | Users have their own Cargo.lock; locking versions breaks their builds |

**Example:**
```
Project type: guessing_game (binary)
→ SHOULD track Cargo.lock
→ Ensures users get exact rand 0.8.5 we tested with
```

**How Cargo.lock works:**
- `Cargo.toml`: "Give me rand 0.8.5" (flexible, allows patches)
- `Cargo.lock`: "Use EXACTLY rand 0.8.5" (strict, reproducible)

**Without Cargo.lock tracked:**
```
User 1: cargo build → gets rand 0.8.5
User 2: cargo build → gets rand 0.8.6 (newer version)
→ Different behavior, potential bugs! ❌
```

**With Cargo.lock tracked:**
```
User 1: cargo build → gets rand 0.8.5
User 2: cargo build → gets rand 0.8.5 (same!)
→ Consistent, reproducible builds ✅
```

---

## Common Patterns Learned

### 1. Creating Custom Result-like Types

```rust
enum MyResult<T, E> {
    Ok(T),
    Err(E),
}

fn my_function() -> MyResult<i32, String> {
    if condition {
        Ok(42)
    } else {
        Err("Something failed".to_string())
    }
}
```

### 2. Handling with Match

```rust
match my_function() {
    Ok(value) => println!("Success: {}", value),
    Err(error) => println!("Error: {}", error),
}
```

### 3. Importing Variants

```rust
use MyResult::{Ok, Err};
// or
use MyResult::*;  // Import all variants
```

---

## Important Learnings About Rust's Design Philosophy

1. **Safety First**: Immutable by default, forces you to be intentional
2. **Explicitness**: No hidden magic, compiler catches bugs
3. **No Null**: Use `Option<T>` or `Result<T, E>` instead
4. **Pattern Matching**: Better than if-else for complex logic
5. **Zero-Cost Abstractions**: Generics generate code, no runtime overhead

---

## Projects Created This Session

- **001_hello_world**: Basic println with multilingual output (rustc)
- **002_hello_cargo**: Cargo project exploring is_even, custom generics
- **003_cargo_name**: Demonstrates package naming with cargo new

---

## What to Study Next

- [ ] Rust's `Option<T>` type (similar to `Result`, for nullable values)
- [ ] Traits (Rust's interface/contract system)
- [ ] Ownership and borrowing (Rust's memory safety model)
- [ ] More about `String` vs `&str`
- [ ] Error handling patterns (custom error types)
- [ ] Modules and crate organization

---

_Last Updated: 2026-03-03_
