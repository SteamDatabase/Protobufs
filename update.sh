#!/bin/bash

cd "$(dirname "$0")"

rsync -arhv --delete ../steamtrack/Protobufs/ ./steam/
rsync -arhv --delete ../backend/files/csgo/Protobufs/ ./csgo/
rsync -arhv --delete ../backend/files/dota/Protobufs/ ./dota2/
rsync -arhv --delete ../backend/files/tf/Protobufs/ ./tf2/
rsync -arhv --delete ../backend/files/artifact/Protobufs/ ./artifact/
rsync -arhv --delete ../backend/files/underlords/Protobufs/ ./underlords/
cp -r ./steam/google ./

git add -A
git commit -S -a -m "$(git status --porcelain | wc -l) files | $(git status --porcelain | sed '{:q;N;s/\n/, /g;t q}' | sed 's/^ *//g')"
git push
