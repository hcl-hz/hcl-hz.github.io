---
title: "PMS (Project Management System)"
date: "2026-03-14"
category: "projects"
description: "CMS 위에 풀스택으로 설계·개발한 프로젝트 관리 시스템. 멀티테넌트 구조, 6단계 티켓 상태 머신, 역할 기반 데이터 스코핑, 알림 트랜잭션 격리 등 실무 판단이 녹아있는 구조."
tags: ["Next.js", "Spring Boot", "MariaDB", "Docker", "Full Stack"]
thumbnail: ""
---

## 프로젝트 개요

기존 CMS(Content Management System) 위에 **PMS(Project Management System)** 를 풀스택으로 설계하고 개발한 프로젝트입니다.
CMS의 기존 자산(게시판, 댓글, 그룹 구조 등)을 최대한 재활용하면서, 1:1 확장 테이블로 PMS 레이어를 얹는 방식으로 중복 개발을 최소화했습니다.

---

## 도메인 구조
```
PmsCompany (ACTIVE/INACTIVE)
│  companyCode 자동 채번 (COMP001…)
│  adminGroupUuid → Group (CMS 재활용)
│
└── PmsProject
       projectCode 자동 채번 (PRJ001…, 회사별)
       │
       ├── PmsAdminAssignedProject (담당자 매핑, 알림 라우팅용)
       └── PmsBoard → BbsMasterDomain (CMS 재활용)

BbsArticleDomain (CMS 재활용, 티켓 본문)
└── PmsTicket (1:1, 상태 레이어)
      status: RECEIVED/CONFIRMED/IN_PROGRESS/DONE/HOLD/CANCELED
      ├── PmsStatusHistory (append-only 이력)
      └── PmsWorkLog (작업시간 기록)

BbsComment (CMS 재활용)
└── PmsCommentExt (1:1 확장)
      commentType: PUBLIC / INTERNAL
```

---

## 핵심 설계 포인트

### 티켓 상태 머신 + 지연 생성

6단계 상태 머신(RECEIVED → CONFIRMED → IN_PROGRESS → DONE, 어느 단계에서든 HOLD·CANCELED 가능)을 설계했습니다.
CMS에 이미 존재하는 게시글에는 `pms_ticket` 레코드가 없을 수 있는데, 이를 미리 일괄 생성하지 않고 **최초 상태 조회 시점에 RECEIVED로 자동 생성**하는 지연 생성 방식을 적용했습니다. 불필요한 사전 마이그레이션 없이 CMS 자산을 그대로 흡수할 수 있습니다.

### 멀티 DB 교차 조회

알림 발송 시 PMS DB에 수신자 정보가 없으면 `integrated_cms` DB를 폴백으로 조회하는 구조입니다.
`ThreadLocal` 기반 `ServiceContextHolder`로 DB 컨텍스트를 전환하여, 서비스 레이어에서 DB 구조에 의존하지 않고 순차적으로 접근합니다.

### 역할 기반 데이터 스코핑

사용자 역할(Role)에 따라 조회 가능한 데이터 범위를 서버 레벨에서 제한합니다.
그룹 계층을 재귀 탐색하여 ADMIN의 접근 범위를 동적으로 결정하고, 클라이언트가 아닌 쿼리 생성 단계에서 스코프를 주입합니다.

### 알림 트랜잭션 격리 (REQUIRES_NEW)

알림 발송 로직을 `@Transactional(REQUIRES_NEW)`로 메인 트랜잭션과 완전히 분리했습니다.
알림이 실패해도 코멘트 저장에 영향 없고, 코멘트가 롤백되면 알림도 남지 않는 FAIL-OPEN 구조입니다.

### 내부 메모 참조 인코딩

INTERNAL 코멘트(SITE_ADMIN 전용 내부 메모)를 특정 PUBLIC 코멘트에 연결할 때, FK 컬럼 없이 본문에 `[[PMS_PUBLIC_COMMENT:{id}]]` 접두어를 삽입하는 참조 인코딩 방식을 사용했습니다.
스키마 변경 없이 참조 관계를 표현하고, 권한에 따라 INTERNAL 내용 노출을 JPQL 레벨에서 차단합니다.

### 복합 트랜잭션 원자성

프로젝트 생성 시 그룹 폴더 + 전용 게시판 + PmsBoard 매핑 + 담당자 지정 4개 테이블을 단일 `@Transactional`로 처리합니다.
티켓 생성도 5개 테이블을 원자적으로 처리하여 부분 생성 상태가 발생하지 않도록 설계했습니다.

### 필터 URL 동기화 + UX

모든 필터(프로젝트·상태·키워드·기간)를 URL 쿼리스트링으로 양방향 동기화하여 뒤로가기·공유 링크에서도 동일한 필터뷰가 복원됩니다.
TanStack Query `placeholderData`로 필터 변경 시 목록 깜빡임을 방지했습니다.

---

## 기술 스택

| 분류 | 기술 |
|---|---|
| Frontend | Next.js 14, TypeScript, TanStack Query |
| Backend | Spring Boot |
| Database | MariaDB (멀티테넌트, 멀티 DB) |
| Infra | Docker |

---

## 배운 점

트랜잭션 경계를 어디서 끊을 것인가, 데이터 접근 권한을 어느 레이어에서 처리할 것인가 같은 구조적 판단이 시스템 안정성에 직결된다는 것을 실감했습니다.
특히 알림 트랜잭션 격리와 지연 생성 패턴을 통해, 단순한 기능 구현을 넘어 운영 환경에서의 장애 격리와 마이그레이션 전략을 고민하게 됐습니다.