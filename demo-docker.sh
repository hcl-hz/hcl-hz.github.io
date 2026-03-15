#!/usr/bin/env bash

# ─────────────────────────────────────────────────────
#  Docker 포트폴리오 로컬 시연 스크립트
#  엔터를 누르면 다음 단계로 진행됩니다.
# ─────────────────────────────────────────────────────

BOLD=$'\033[1m'
CYAN=$'\033[1;36m'
GREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
RED=$'\033[1;31m'
DIM=$'\033[2m'
RESET=$'\033[0m'

PORT=3001
IMAGE="portfolio:slim"
CONTAINER="portfolio"

# ── 유틸 함수 ──────────────────────────────────────────

divider() {
  printf "%s━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━%s\n" "$CYAN" "$RESET"
}

step() {
  printf "\n"
  divider
  printf "%s  %s%s\n" "$BOLD" "$1" "$RESET"
  divider
}

wait_enter() {
  printf "\n%s  ▶  엔터를 누르면 실행합니다 ...%s\n" "$YELLOW" "$RESET"
  read -r
}

run_cmd() {
  printf "%s  \$ %s%s\n" "$GREEN" "$*" "$RESET"
  eval "$*"
  local status=$?
  if [ $status -ne 0 ]; then
    printf "%s  ✗ 명령 실패 (exit %s)%s\n" "$RED" "$status" "$RESET"
    exit $status
  fi
  printf "\n"
}

info() {
  printf "%s  %s%s\n" "$DIM" "$*" "$RESET"
}

ok() {
  printf "%s  ✓ %s%s\n" "$GREEN" "$*" "$RESET"
}

# ── 시작 ────────────────────────────────────────────────

clear
printf "\n"
divider
printf "%s    Docker 포트폴리오 시연%s\n" "$BOLD" "$RESET"
printf "%s    포트: %s  |  이미지: %s  |  컨테이너: %s%s\n" "$DIM" "$PORT" "$IMAGE" "$CONTAINER" "$RESET"
divider
printf "\n"
info "엔터를 눌러 시작하거나 Ctrl+C 로 종료하세요."
wait_enter

# ── Step 1. 사전 정리 ────────────────────────────────────

step "Step 1 / 5  |  사전 정리"
info "이름 충돌 방지를 위해 기존 컨테이너를 제거합니다."
wait_enter

docker stop $CONTAINER 2>/dev/null && ok "컨테이너 중지됨" || true
docker rm   $CONTAINER 2>/dev/null && ok "컨테이너 삭제됨" || true
printf "\n"
ok "정리 완료"

# ── Step 2. 캐시 없이 풀 빌드 ────────────────────────────

step "Step 2 / 5  |  풀 빌드 (--no-cache)"
info "Dockerfile: builder(node:18-alpine) → runner(nginx:alpine)"
info "--no-cache 로 모든 레이어를 처음부터 빌드합니다."
info "빌드 완료 후 이미지에 node가 없고 nginx만 남는 것을 확인합니다."
wait_enter

run_cmd "docker build --no-cache -t $IMAGE ."

printf "  %s이미지 용량:%s\n" "$BOLD" "$RESET"
docker images --format "  {{.Repository}}:{{.Tag}}  {{.Size}}" | grep portfolio
printf "\n"
info "최종 이미지 실행 환경 확인:"
printf "  CMD  : %s\n" "$(docker inspect $IMAGE --format '{{.Config.Cmd}}')"
printf "  PORT : %s\n" "$(docker inspect $IMAGE --format '{{range \$k,\$v := .Config.ExposedPorts}}{{$k}}{{end}}')"
printf "  node : %s\n" "$(docker run --rm $IMAGE which node 2>/dev/null || printf 'node 없음 ✓')"
printf "\n"

# ── Step 3. 레이어 캐싱 시연 ─────────────────────────────

step "Step 3 / 5  |  레이어 캐싱 시연"
info "동일 소스로 즉시 재빌드합니다."
info "변경사항이 없으므로 모든 레이어가 CACHED — 빌드 시간이 수 초로 줄어드는 것을 확인합니다."
wait_enter

run_cmd "docker build -t $IMAGE ."

# ── Step 4. 컨테이너 실행 ────────────────────────────────

step "Step 4 / 6  |  컨테이너 실행"
info "포트 $PORT → 컨테이너 내부 80 (nginx) 로 매핑합니다."
wait_enter

run_cmd "docker run -d -p $PORT:80 --name $CONTAINER $IMAGE"

# 기동 대기
printf "  %s기동 대기 중...%s\n" "$DIM" "$RESET"
for i in 1 2 3; do
  sleep 1
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT 2>/dev/null)
  if [ "$HTTP_CODE" = "200" ]; then
    ok "HTTP $HTTP_CODE — 서버 응답 정상"
    break
  fi
done

printf "\n  %s실행 중인 컨테이너:%s\n" "$BOLD" "$RESET"
docker ps --format "  {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep $CONTAINER
printf "\n"
printf "%s  ✓ 브라우저에서 http://localhost:%s 접속해보세요.%s\n" "$GREEN" "$PORT" "$RESET"
wait_enter

# ── Step 5. 새 포스트 배포 시연 ──────────────────────────────

step "Step 5 / 6  |  새 포스트 배포 시연"
info "posts/temp/ 에 대기 중인 포스트 파일을 각 언어 폴더로 이동 후 재빌드합니다."
info "콘텐츠 변경 → 이미지 재빌드 → 컨테이너 재시작 → 반영 확인 흐름을 보여줍니다."
wait_enter

# 기존 파일 제거 (temp → posts 이동 시연을 위해)
printf "  %s[현재 상태]%s\n" "$BOLD" "$RESET"
info "posts/temp/ 대기 중인 파일:"
ls posts/temp/
printf "\n"
info "기존 posts/en/docker-cicd.md, posts/ko/docker-cicd.md 를 제거합니다."
wait_enter

rm -f posts/en/docker-cicd.md posts/ko/docker-cicd.md
ok "기존 포스트 제거 완료"
printf "\n"

# temp 파일 이동
info "temp 파일을 각 언어 폴더로 이동합니다."
wait_enter

run_cmd "mv posts/temp/docker-cicd.mden posts/en/docker-cicd.md"
run_cmd "mv posts/temp/docker-cicd.mdko posts/ko/docker-cicd.md"

ok "posts/en/docker-cicd.md 배치 완료"
ok "posts/ko/docker-cicd.md 배치 완료"
printf "\n"

# 재빌드
info "변경된 소스를 반영해 이미지를 재빌드합니다."
wait_enter

run_cmd "docker build -t $IMAGE ."

# 컨테이너 재시작
info "실행 중인 컨테이너를 재시작합니다."
wait_enter

docker stop $CONTAINER 2>/dev/null; docker rm $CONTAINER 2>/dev/null
run_cmd "docker run -d -p $PORT:80 --name $CONTAINER $IMAGE"

# 기동 대기
printf "  %s기동 대기 중...%s\n" "$DIM" "$RESET"
for i in 1 2 3; do
  sleep 1
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT 2>/dev/null)
  if [ "$HTTP_CODE" = "200" ]; then
    ok "HTTP $HTTP_CODE — 서버 응답 정상"
    break
  fi
done

# 새 포스트 접근 확인
printf "\n"
info "새 포스트 API 응답 확인:"
KO_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/api/post/docker-cicd 2>/dev/null)
EN_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT/api/post/docker-cicd 2>/dev/null)
printf "  /api/post/docker-cicd  →  HTTP %s\n" "$KO_CODE"
printf "\n"
printf "%s  ✓ 브라우저에서 http://localhost:%s/ko 또는 /en 접속 후 포스트를 확인하세요.%s\n" "$GREEN" "$PORT" "$RESET"
wait_enter

# ── Step 6. 로그 확인 및 정리 ─────────────────────────────

step "Step 6 / 6  |  로그 확인 및 정리"
info "nginx 기동 로그와 접근 로그를 확인합니다."
wait_enter

run_cmd "docker logs $CONTAINER"

info "시연을 마칩니다. 컨테이너를 정리합니다."
wait_enter

run_cmd "docker stop $CONTAINER && docker rm $CONTAINER"

# ── 완료 ──────────────────────────────────────────────────

printf "\n"
divider
printf "%s    시연 완료!%s\n" "$BOLD" "$RESET"
divider
printf "\n"
