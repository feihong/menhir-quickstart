help:
  just --list

init:
  opam switch create . 5.2.0 -y --deps-only
  opam update
  just install

install:
  opam install -y . --deps-only --with-test

build:
  dune build

watch:
  dune build --watch

test:
  dune build @runtest

format:
  dune build @fmt --auto-promote

hello:
  dune exec hello/hello.exe

simpl:
  dune exec simpl/main.exe
