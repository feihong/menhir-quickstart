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

hello:
  dune exec hello/hello.exe
