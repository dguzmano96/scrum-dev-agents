---
name: skill-BestPractices
description: >-
  Software development best practices—SOLID, DRY, Clean Code, OOP, naming,
  refactoring, and maintainability. Uses WebSearch for authoritative guidance.
  Use when writing or reviewing code, refactoring, designing classes or modules,
  pull requests, architecture decisions, or when the user invokes /skill-BestPractices.
---

# Software Best Practices

## When to use

- Writing new features, classes, modules, or APIs
- Reviewing or refactoring existing code
- Naming, structuring, or splitting responsibilities
- Explaining trade-offs between patterns (OOP vs composition, abstraction levels)
- Aligning code with SOLID, DRY, KISS, YAGNI, and Clean Code principles

## Research (WebSearch)

Use the **WebSearch** tool when any of the following apply:

- Language- or framework-specific idioms for applying SOLID, DRY, or Clean Code
- Official style guides, lint rules, or community standards for the stack in use
- Comparing patterns (e.g. Strategy vs inheritance, value objects, CQRS)
- Uncertainty about a principle in context (when DRY hurts, Law of Demeter, etc.)
- Modern guidance on testing, coupling, or cohesion for the user’s ecosystem

**Query tips:**

- Name the **language/framework** and principle (e.g. `C# SOLID dependency injection`, `TypeScript composition over inheritance`)
- Prefer authoritative sources: language docs, Martin Fowler, Robert C. Martin summaries, reputable style guides
- After searching, **apply guidance to this repo’s** existing patterns—do not impose alien style

If WebSearch is unavailable, rely on widely accepted principles below and repo conventions.

## Core principles (apply with judgment)

### SOLID

| Principle | Practical check |
|-----------|-----------------|
| **S**ingle responsibility | One reason to change per module/class |
| **O**pen/closed | Extend via new types/composition, not endless `if/else` edits |
| **L**iskov substitution | Subtypes honor contracts; no surprising overrides |
| **I**nterface segregation | Small, focused interfaces; clients don’t depend on unused APIs |
| **D**ependency inversion | Depend on abstractions; inject dependencies; avoid hard-coded globals |

### DRY

- Eliminate **duplicated knowledge** (business rules, validation, mapping)—not every similar-looking line.
- Prefer a single source of truth; extract only when duplication is real and stable.
- **Do not** over-abstract two lines used once; premature abstraction violates YAGNI.

### Clean Code

- **Names** reveal intent: `calculateInvoiceTotal` over `calc`.
- **Functions** do one thing, stay short, few parameters; use objects/records when arity grows.
- **Comments** explain *why*, not *what* obvious code already shows.
- **Errors** use exceptions/types meaningfully; fail fast; avoid silent catches.
- **Formatting** matches the project; consistency beats personal preference.

### OOP (when the language supports it)

- Favor **composition over inheritance** for reuse and flexibility.
- Keep inheritance hierarchies shallow; model domain behavior, not taxonomies for convenience.
- Encapsulate invariants; expose behavior, not raw mutable state when avoidable.
- Prefer immutability or clear ownership where the codebase already does.

### Related habits

- **KISS**: simplest design that meets requirements.
- **YAGNI**: no speculative features or abstraction layers.
- **Boy Scout Rule**: leave touched code slightly cleaner when safe and in scope.
- **Minimize scope**: smallest visibility and diff that solves the task.

## Workflow

1. **Read context**: surrounding files, tests, and project conventions before suggesting patterns.
2. **Match the codebase**: naming, layering, error handling, and test style already in use.
3. **Minimize diff**: improve design within the requested scope—avoid drive-by refactors.
4. **Explain trade-offs** briefly when multiple valid designs exist.
5. **Validate**: run existing tests/linters when changing behavior or structure.

## Code review lens

When reviewing, prioritize in order:

1. Correctness and security
2. Clarity and maintainability (names, structure, coupling)
3. SOLID/DRY violations that will cause real pain (not nitpicks)
4. Tests for behavior that changed or is risky
5. Performance only when relevant or measured

**Feedback tone:**

- 🔴 **Must fix**: bugs, security, broken contracts, harmful duplication
- 🟡 **Should consider**: clearer naming, smaller functions, better separation
- 🟢 **Optional**: style preferences that don’t affect maintainability

## Anti-patterns to flag

- God classes/modules; feature envy; shotgun surgery
- Clever one-liners that obscure intent
- Copy-paste business logic across layers
- Empty `catch` blocks; boolean flags proliferating behavior
- Inheritance only for code reuse without true “is-a” relationships
- Interface explosion or abstraction with a single implementation and no extension path

## Output

- Lead with the recommendation or refactor; tie it to a named principle when helpful.
- Prefer small, reviewable steps over big-bang rewrites unless asked.
- Cite WebSearch URLs when guidance depends on fetched standards.
- State what was **not** changed to respect scope when applicable.
