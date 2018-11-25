#!/bin/bash

cd "$(dirname "$0")"

rsync -arhv ../steamtrack/Protobufs/ ./steam/
rsync -arhv ../backend/files/csgo/Protobufs/ ./csgo/
rsync -arhv ../backend/files/dota/Protobufs/ ./dota2/
rsync -arhv ../backend/files/tf/Protobufs/ ./tf2/
rsync -arhv ../backend/files/artifact/Protobufs/ ./artifact/
cp -r ./steam/google ./

git add -A
git commit -S -a -m "$(git status --porcelain | wc -l) files | $(git status --porcelain | sed '{:q;N;s/\n/, /g;t q}' | sed 's/^ *//g')"
git push
