# EC2 서버 초기 세팅 가이드

이 문서는 `hcl-hz.github.io` 포트폴리오 사이트를 EC2에 배포하기 위한 원타임 서버 세팅 절차입니다.
GitHub Actions(`deploy-ec2.yml`)가 `main` 브랜치 push마다 자동 배포를 수행하며, 이 문서의 세팅이 완료된 이후부터 동작합니다.

---

## 대상 서버

- **Host**: `ec2-3-26-181-158.ap-southeast-2.compute.amazonaws.com`
- **User**: `ubuntu`
- **Key**: `~/Downloads/id_rsa.pem`

---

## 작업 순서

### 1. SSH 접속

```bash
ssh -i ~/Downloads/id_rsa.pem ubuntu@ec2-3-26-181-158.ap-southeast-2.compute.amazonaws.com
```

---

### 2. Docker 설치 (Docker CE + Compose Plugin v2)

```bash
sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io docker-compose-plugin

# ubuntu 유저가 sudo 없이 docker 명령 실행 가능하게 설정
sudo usermod -aG docker ubuntu
```

**로그아웃 후 재접속** (그룹 변경 적용)

```bash
exit
ssh -i ~/Downloads/id_rsa.pem ubuntu@ec2-3-26-181-158.ap-southeast-2.compute.amazonaws.com
```

설치 확인:

```bash
docker --version
docker compose version
```

---

### 3. 레포 클론

```bash
git clone https://github.com/hcl-hz/hcl-hz.github.io.git ~/hcl-hz.github.io
```

---

### 4. EC2 보안 그룹 설정 (AWS 콘솔)

아래 인바운드 규칙이 없으면 추가:

| 유형 | 프로토콜 | 포트 | 소스 |
|------|----------|------|------|
| HTTP | TCP | 80 | 0.0.0.0/0 |
| SSH  | TCP | 22 | 내 IP 또는 0.0.0.0/0 |

---

### 5. GitHub Secrets 등록

GitHub 레포 → **Settings → Secrets and variables → Actions** 에서 아래 3개 추가:

| Secret 이름 | 값 |
|-------------|-----|
| `EC2_HOST` | `ec2-3-26-181-158.ap-southeast-2.compute.amazonaws.com` |
| `EC2_USER` | `ubuntu` |
| `EC2_SSH_KEY` | `id_rsa.pem` 파일 전체 내용 (`cat ~/Downloads/id_rsa.pem`) |

> **주의**: Supabase 관련 secrets는 불필요. 빌드는 로컬 마크다운(`posts/ko/*.md`, `posts/en/*.md`)만 사용.

---

## 배포 구조

```
GitHub main push
  └─ .github/workflows/deploy-ec2.yml
       └─ SSH → EC2 ~/hcl-hz.github.io
            ├─ git pull origin main
            ├─ docker compose down --remove-orphans
            ├─ docker compose build --no-cache
            │    └─ Dockerfile (멀티스테이지)
            │         ├─ builder: node:18-alpine → npm ci → npm run build → out/
            │         └─ runner:  nginx:alpine → out/ 복사 → 포트 80 서빙
            ├─ docker compose up -d
            └─ docker image prune -f
```

컨테이너 포트 매핑: `EC2:80 → nginx:80`

---

## 세팅 완료 후 검증

```bash
# EC2에서 컨테이너 상태 확인
docker ps

# 응답 확인
curl -I http://localhost

# 외부에서 접속
# http://ec2-3-26-181-158.ap-southeast-2.compute.amazonaws.com
```

---

## 트러블슈팅

**포트 80 충돌**
```bash
sudo lsof -i :80
# 충돌 프로세스 확인 후 중지 (예: apache2)
sudo systemctl stop apache2
sudo systemctl disable apache2
```

**빌드 OOM (t3.micro 메모리 부족)**
- `Dockerfile`에 `NODE_OPTIONS=--max-old-space-size=900` 설정 이미 적용됨
- 그래도 실패하면 EC2에 swap 추가:
```bash
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

**`docker compose` 명령어 없음**
- `docker-compose` (v1 하이픈 있는 형태)가 설치된 경우
- 위의 설치 절차(`docker-compose-plugin`)를 따르면 `docker compose` (v2) 사용 가능
