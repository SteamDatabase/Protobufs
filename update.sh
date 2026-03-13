#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

REPOS=(
	"SteamTracking/SteamTracking:Protobufs:steam"
	"SteamTracking/SteamTracking:ProtobufsWebui:webui"
	"SteamTracking/GameTracking-CS2:Protobufs:csgo"
	"SteamTracking/GameTracking-Dota2:Protobufs:dota2"
	"SteamTracking/GameTracking-Deadlock:Protobufs:deadlock"
	"SteamTracking/GameTracking-TF2:Protobufs:tf2"
)

mkdir -p sources

for ENTRY in "${REPOS[@]}"; do
	IFS=: read -r REPO FOLDER DEST <<< "$ENTRY"
	REPO_DIR="sources/$(basename "${REPO}")"

	if [[ ! -d "${REPO_DIR}" ]]; then
		git clone --no-checkout --depth 1 --filter=blob:none \
			"https://github.com/${REPO}.git" "${REPO_DIR}"
	else
		git -C "${REPO_DIR}" fetch --depth 1
		git -C "${REPO_DIR}" reset --hard FETCH_HEAD
	fi

	git -C "${REPO_DIR}" sparse-checkout set "${FOLDER}"
	git -C "${REPO_DIR}" checkout

	rsync -a --delete "${REPO_DIR}/${FOLDER}/" "${DEST}/"
done

cp -r ./steam/google ./
rm -rf sources

git add -A

if git diff --cached --quiet; then
	echo "No changes to commit"
	exit 0
fi

NUM_FILES=$(git status --porcelain | wc -l)
FILE_LIST=$(git status --porcelain | awk '{print $2}' | paste -sd', ' | sed 's/,/, /g')

git commit -a -m "${NUM_FILES} files | ${FILE_LIST}"
git push
