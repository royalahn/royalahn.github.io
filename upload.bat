rm -rf _book
rm -rf dist

gitbook install && gitbook build

git worktree add dist origin/gh-pages -fB gh-pages

cp -R _book/* dist/

cd dist

git add .
git commit -m "Upload gh-pages"
git push origin gh-pages
