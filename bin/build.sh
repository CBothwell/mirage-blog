#!/bin/bash
if [[ ! -e $HOME/.opam ]]
then opam init -a --switch="4.01.0"
if
eval `opam config env`
if [[ ! -e $HOME/.opam/4.01.0/lib/mirage ]]
then opam install -y mirage
fi
if [[ ! -e $HOME/.opam/4.01.0/lib/mirage-seal ]]
then opam install -y mirage-seal
fi
cd blog-src && jekyll build
cd ../ && mirage-seal --data=htdocs --no-tls --target=xen
