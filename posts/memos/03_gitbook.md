# Gitbook

**gitbook-cli**를 이용하여 `gitbook install` 시 발생하는 에러 처리 방법 (기록용)

```shell
Installing GitBook 3.2.3
/usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js:287
      if (cb) cb.apply(this, arguments)
                 ^

TypeError: cb.apply is not a function
    at /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js:287:18
    at FSReqCallback.oncomplete (node:fs:196:5)
```

`gitbook install` 시 dependency가 있는 **graceful-fs** 의 버전이 `4.1.11`으로 호환성 문제가 존재하여 `4.1.4`로 downgrade를 해줘야 한다.

> 참고: [Gitbook build stopped to work in node 12.18.3](https://github.com/GitbookIO/gitbook-cli/issues/110)

### gitbook-cli를 global로 설치할 경우 설치 된 경로로 이동

```shell
# Linux
cd /usr/lib/node_modules/gitbook-cli/node_modules/npm

# Windows
cd C:\Users\<USERNAME>\AppData\Roaming\npm\node_modules\gitbook-cli\node_modules\npm
```

### graceful-fs 4.1.4 버전으로 재설치

```shell
npm install graceful-fs@4.1.4
```

### gitbook 폴더에서 gitbook install 실행

```shell
gitbook install
```
