#!/bin/bash
opam init -a #; opam switch "4.01.0"
eval `opam config env`

#opam install -y mirage
opam pin -y add mirage-seal https://github.com/CBothwell/mirage-seal.git; opam install -y mirage-seal

cd blog-src && jekyll build
cd ../ && mirage-seal --data=htdocs --no-tls --target=xen
