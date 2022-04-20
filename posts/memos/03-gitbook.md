# Gitbook

## 1. **gitbook-cli**를 이용하여 `gitbook install` 시 발생하는 에러 처리 방법

**에러 로그**

```bash
Installing GitBook 3.2.3
/usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js:287
      if (cb) cb.apply(this, arguments)
                 ^

TypeError: cb.apply is not a function
    at /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js:287:18
    at FSReqCallback.oncomplete (node:fs:196:5)
```

`gitbook install` 시 dependency가 있는 **graceful-fs** 의 버전이 `4.1.11`으로 호환성 문제가 존재하여 `4.1.4`로 downgrade를 해줘야 한다.

> [!TIP]
> 참고: [Gitbook build stopped to work in node 12.18.3](https://github.com/GitbookIO/gitbook-cli/issues/110)

<br/>

### 1.1 gitbook-cli를 global로 설치할 경우 설치 된 경로로 이동

```bash
# Linux
cd $(npm root -g)/gitbook-cli/node_modules/npm

# Windows
cd C:\Users\<USERNAME>\AppData\Roaming\npm\node_modules\gitbook-cli\node_modules\npm
```

<br/>

### 1.2 graceful-fs 4.1.4 버전으로 재설치

```bash
npm install graceful-fs@4.1.4
```

<br/>

### 1.3 gitbook Project 폴더에서 gitbook install 실행

```bash
gitbook install
```

<br/>

## 2. Gitbook의 build 산출물을 gh-pages branch로 push 하는 Shell Script

> [!NOTE]
> **gitbook-cli**가 설치되어 있어야 하며, `gh-pages` branch가 생성되어 있어야 한다.

```bash
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
```
