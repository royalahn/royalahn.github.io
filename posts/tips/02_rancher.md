# Rancher

회사에서 정말 많이 그리고 유용하게 사용하고 있는 Rancher

나는 Rancher가 있어서 정말 좋다. 👍

### 1. Docker 설치

Docker는 설치하는 방법은 정말 다양하다.

#### 1.1 Rancher에서 제공하는 Shell Script

> 참고: [rancher-install-docker](https://github.com/rancher/install-docker)

```shell
# Docker 20.10 (추천)
curl https://releases.rancher.com/install-docker/20.10.sh | sh
```

```shell
# Docker 19.03
curl https://releases.rancher.com/install-docker/19.03.sh | sh
```

### 1.2 Docker에서 제공하는 방법

> 참고: [docker-install-centos](https://docs.docker.com/engine/install/centos/)

> 참고: [docker-install-ubuntu](https://docs.docker.com/engine/install/ubuntu/)

위에 링크를 참고하면 됨.

### 1.3 Docker에서 제공하는 Shell Script

> 참고: [docker-install-centos](https://docs.docker.com/engine/install/centos/)

> 아쉽게도 2021-07-31 현재 Oracle Linux 8.4 arm64에서는 동작하지 않는거 같음.

```shell
curl -fsSL https://get.docker.com -o get-docker.sh
```

```shell
sudo sh get-docker.sh
```

### 2. Rancher 설치

> 참고: [rancher 2.5 installation with docker](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/)

> 참고: [rancher 2.5 installation with docker advanced options](https://rancher.com/docs/rancher/v2.5/en/installation/other-installation-methods/single-node-docker/advanced/)

```shell
# 포트는 변경 가능 (-p 8080:80 -p 8443:443)
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /opt/rancher:/var/lib/rancher \
  --privileged \
  rancher/rancher:latest
```
