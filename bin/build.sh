#!/bin/bash
opam init -a
opam switch 4.01.0
eval `opam config env`
opam install -y mirage
opam install -y mirage-seal
cd blog-src && jekyll build
mirage-seal --data=htdocs --no-tls --target=xen
