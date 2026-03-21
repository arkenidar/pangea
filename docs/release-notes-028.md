# Release Notes: 028

## Breaking Change

Pangea now uses quoted string literals as the canonical literal mechanism.

- Removed colon literal operator `:` from active runtime behavior.
- Removed legacy `string`/`stringa` literal keyword behavior from active runtime behavior.
- Variable names, function names used as data, and include paths must be quoted.

## New String Parsing Behavior

Quoted strings are parsed with explicit escape handling.

Supported escapes:
- `\\"` for quote
- `\\\\` for backslash
- `\\n` for newline
- `\\t` for tab

Parser now raises explicit errors for:
- invalid escape sequences
- unterminated strings
- unterminated escapes

## Migration Examples

Before:

```txt
set : x 10
print get : x
! : factorial.words
define_word : square 1 multiply argument 1 argument 1
```

After:

```txt
set "x" 10
print get "x"
! "factorial.words"
define_word "square" 1 multiply argument 1 argument 1
```

## Compatibility Scope

- Current canonical runtime: `src/pangea1/main.lua` and `ark/lua/latest.lua`.
- Historical snapshots under `ark/lua/pang-00x.lua` are preserved as archive history and may contain legacy syntax.

## Validation

Validated with:
- `bash bin/bash/test-english.bash`
- `bash bin/bash/test-italian.bash`
- negative parser checks for invalid escapes and unterminated strings
