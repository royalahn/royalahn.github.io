#!/bin/bash

# 1. Remove directories
git worktree remove dist
rm -rf _book
rm -rf dist

# 2. Build gitbook
gitbook install && gitbook build

# 3. Copy gh-pages branch to dist directory
git worktree add dist origin/gh-pages -fB gh-pages

# 4.Remove all files except .git and .gitignore
find ./dist ! -name ".git*" -delete

# 5. Copy gitbook output to dist (gh-pages branch)
cp -R _book/* dist/

# 6. Checkout gh-pages branch
cd dist

# 7. Commit and push to origin/gh-pages
git add .
git commit -m "Upload gh-pages"
git push origin gh-pages
