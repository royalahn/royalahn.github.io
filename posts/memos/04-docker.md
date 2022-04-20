# Docker

요즘 Systemd 대신 Docker를 많이 사용하는데, 자주 사용하는 commands를 정리해본다.

> [!TIP]
> Docker Hub에 등록할 Tag 버전명을 환경변수로 등록해서 사용

```bash
echo "export FILE_MANAGER_VERSION=2.0.1" >> ~/.zshrc

# 적용
source ~/.zshrc

# 확인
echo ${FILE_MANAGER_VERSION}
```

## 1. Dockerfile

> [!NOTE]
> [Spring Boot with Docker](https://spring.io/guides/gs/spring-boot-docker/)
>
> Springboot 기준 Dockerfile

**테스트 버전 참고**

![Java](https://img.shields.io/badge/Java-11-23B300.svg?style=plastic&logo=java&logoColor=white) ![SpringBoot](https://img.shields.io/badge/SpringBoot-2.3.3-0b90a8.svg?style=plastic&logo=springboot&logoColor=white) ![Gradle](https://img.shields.io/badge/Gradle-6.4.1-blue.svg?style=plastic&logo=gradle&logoColor=white)

```bash
FROM openjdk:11-jre

ENV TZ=Asia/Seoul

ARG JAR_FILE=build/libs/*.jar

# Set Timezone
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo ${TZ} > /etc/timezone

# Container Volume
VOLUME ["/opt/hugh"]

# Port
EXPOSE 8080

# Copy jar file to the container
COPY ${JAR_FILE} app.jar

# Run Application
ENTRYPOINT ["java","-jar","/app.jar"]
```

<br/>

## 2. Docker Build

> [!NOTE]
> Docker build를 하기 전에 Springboot의 Gradle build가 선행되어야 한다.
>
> `build/libs` 폴더 하위에 jar 파일 존재 여부 확인

```bash
# Dockerfile 이 위치한 폴더에서 실행해야 하며 뒤에 . 이 필요 (현재 경로를 의미)
sudo docker build -t royalahn/file-manager:${FILE_MANAGER_VERSION} .
```

<br/>

## 3. Docker Run

> [!NOTE]
> `USER_HOST`, `USER_USERNAME`, `USER_PASSWORD`는 환경변수이며 사전에 등록이 필요

```bash
sudo docker run -d -p 8080:8080 -v /opt/hugh:/opt/hugh --name file-manager \
  -e USER_HOST=${USER_HOST} \
  -e USER_USERNAME=${USER_USERNAME} \
  -e USER_PASSWORD=${USER_PASSWORD} \
  royalahn/file-manager:${FILE_MANAGER_VERSION}
```

<br/>

## 4. Docker Logs

> [!NOTE]
> Docker run 시 -d 옵션을 주어 detach(Background)로 실행했을 때 로그를 보는 방법

```bash
sudo docker logs file-manager
```

<br/>

## 5. Docker Exec

> [!NOTE]
> Docker 가 실행된 가상 VM에 접속하기 위한 방법

```bash
sudo docker exec -it file-manager /bin/bash
```

<br/>

## 6. Docker Stop

> [!NOTE]
> Docker로 실행중인 서비스를 잠시 멈추는 방법

```bash
sudo docker stop file-manager

# 전체를 멈추는 방법
sudo docker stop $(docker ps -a -q)
```

<br/>

## 7. Docker Remove

> [!NOTE]
> 멈춤상태의 서비스를 제거하는 방법

```bash
sudo docker rm file-manager

# 전체를 제거하는 방법
sudo docker rm $(docker ps -a -q)
```

<br/>

## 8. Docker Remove Images

> [!NOTE]
> Docker 이미지 제거

```bash
sudo docker rmi royalahn/file-manager:${FILE_MANAGER_VERSION}
```

<br/>

## 9. Docker Hub에 로그인

```bash
echo "export DOCKER_USERNAME=royalahn" >> ~/.zshrc

# <changeit>을 실제 비번으로 변경
echo "export DOCKER_PASSWORD=<changeit>" >> ~/.zshrc

source ~/.zshrc

echo ${DOCKER_PASSWORD} | sudo docker login -u ${DOCKER_USERNAME} --password-stdin
```

<br/>

## 10. Docker Tag

> [!NOTE]
> `2.0.1` 의 Tag를 `latest`나 `master` 등으로 변경

```bash
sudo docker tag royalahn/file-manager:${FILE_MANAGER_VERSION} royalahn/file-manager:master
sudo docker tag royalahn/file-manager:${FILE_MANAGER_VERSION} royalahn/file-manager:latest
```

<br/>

## 11. Docker Push

```bash
sudo docker push royalahn/file-manager:${FILE_MANAGER_VERSION}
```

<br/>

## 12. Docker Pull

```bash
sudo docker pull royalahn/file-manager:${FILE_MANAGER_VERSION}
sudo docker pull docker.io/royalahn/file-manager:${FILE_MANAGER_VERSION}
```

<br/>

## 13. Docker Service의 로그

> [!NOTE]
> Systemd에 의해 수행되는 Docker의 로그

```bash
echo 'alias docker-log="sudo journalctl -xeu docker"' >> ~/.zshrc
source ~/.zshrc

# 수행
docker-log
```
