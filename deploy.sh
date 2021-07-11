#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

git init
git add -A
git commit -m 'deploy'
git remote add origin git@github.com:sefaekici/vue-excel-to-json.git
git push --force git@github.com:sefaekici/vue-excel-to-json.git main:gh-pages


cd -