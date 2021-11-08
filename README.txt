LuaPN: Lua-based Polish Notation Language. codenamed: pang

This source code is MIT licensed.

run with "lua script.lua" or run with "rlwrap lua script.lua"

alias pang="rlwrap lua latest.lua"

pang fizzbuzz.words # run, don't enter repl
pang factorial.words - # run, then enter repl
pang - # enter repl , no file to run


missing:
break inside while
tables
write writeln read
convert to number
demo: count vowels

historical evolution:
- pang was a rewrite of some earlier tests about leveraging polish notation for programming on a lua layer.
- since version 004 already it was able to do a simple but not trivial task: the fizzbuzz math game.
- then -as I recall- I felt urged to implement functions/procedures and I tested it with a recursive function call scenario (the factorial operation).
- then I moved to taking input programs from files (single line or multi line ones) and/o from a textual command line UI.
- I also tried to manage an unusual task: writing a program using only Italian words (even if some of them are poor translations from English, the standard language of Internet and Computer Programming). this kind of coragious heresy showed some promising success. remember that I wanted a simple language: only words separated by spaces (that was the main reason of earlier single-line programs.)
- then some complications were introduced with the management of strings (jargon for textual data) and I applied a technique for multi-word strings (one word strings were the previous standard way, limited... I know). this introduced punctuation... the double quotes, but still in a "words separated by spaces" way.
- then the temptation and dilemma of introducing a symbol/way (word or punctuation) to prevent a word from triggering execution while parsing. this led to use of ":" colon punctuation, that allowed a single unified way to manage certain kinds of "arguments" (jargon for parameters).
- experienced first a more moderate and considerate way of development and editing and refinement ... then it went more out of hand and caotic... think of changes that break backward compatibility (I recall that project "pang" was started as a rewrite from a big incompatible change, namely deferred execution/evaluation of function/procedure arguments/parameters).

- so what? time for some serious feedback? :) with proper documentation is should follow ;)
