# zsh

요즘 정말 많이 사용하고 있는 `zsh`

현재 사용하고 있는 Setting을 정리해 본다.

### 1. zsh 설치

#### 1.1 Ubuntu

```shell
sudo apt install zsh git
```

#### 1.2 CentOS / Oracle Linux

```shell
# yum을 이용한 방법
sudo yum install zsh git
```

```shell
# dnf를 이용한 방법
sudo dnf install zsh git
```

### 2. oh my zsh 설치

> 참고: [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### 2.1 사용자 기본 Shell 변경

```shell
chsh -s $(which zsh) $USER
```

### 3. zsh plugins 설치

> 참고: [zsh-users](https://github.com/zsh-users)

```shell
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

```shell
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```shell
# zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
```

#### 3.1 설치한 plugins 사용하기

```shell
vi ~/.zshrc
```

```shell
# 아래 부분을 찾아서 변경
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
```

```shell
source ~/.zshrc
```

### 4. oh my zsh Theme 변경

```shell
vi ~/.zshrc
```

```shell
# 아래 부분을 찾아서 변경
ZSH_THEME="agnoster"
```

```shell
source ~/.zshrc
```

#### 4.1 prompt_context 변경

```shell
echo 'prompt_context() {}' >> ~/.zshrc
```

을 하거나,

```shell
vi .oh-my-zsh/themes/agnoster.zsh-theme
```

```shell
# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USERNAME" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{ %F{yellow}% }.)%n@%m"
  fi
}
```

에서 원하는 형식으로 변경 (`user`만 나오게)

```shell
ex) prompt_segment black default "%(!.%{ %F{yellow}% }.)%n"
```
