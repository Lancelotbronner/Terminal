# Terminal

This package aims to aid in the making of Command-Line Applications by providing an API to wrap
ANSI commands.

The package contains a few modules: `Termios`, `ControlSequence`, `Prompt` and `Terminal`. The last one re-exports all previous ones.

*Any help, comments or suggestions would be welcome!*

## Termios

A swift termios wrapper, with documentation from the man pages.

## ControlSequence

Wraps ANSI sequences, string styling shortcuts, terminal query sequences and parsing, etc.

## Prompt

Alternative to readline, provides a plugin architecture to customize your prompt

## Terminal

Provides convenience APIs for terminal-related things
