---
title: "PMS (Project Management System)"
date: "2026-03-14"
category: "projects"
description: "A full-stack PMS built on top of a CMS. Features include multi-DB cross queries, role-based data scoping, notification transaction isolation, and deferred ticket creation."
tags: ["Next.js", "Spring Boot", "MariaDB", "Docker", "Full Stack"]
thumbnail: ""
---

## Overview

A **Project Management System (PMS)** designed and developed full-stack on top of an existing CMS.
Beyond basic CRUD, the focus was on structurally solving complex requirements that arise in real production environments.

---

## Key Design Decisions

### Multi-DB Cross Queries

Designed to query data distributed across multiple databases as if it were a single source.
An abstraction layer wraps the schema differences of each DB, so the upper service logic does not depend on the DB structure.

### Role-based Data Scoping

Restricts the range of queryable data at the server level based on the user's role.
Instead of filtering on the client side, the scope is injected at the query generation stage, ensuring security.

### Notification Transaction Isolation

Separated the notification dispatch logic from the main transaction, so that notification failures do not affect core business logic.
Processed asynchronously via event-based architecture to send notifications without response delays.

### Deferred Ticket Creation

Implemented logic to delay ticket creation until specific conditions are met.
Condition-based creation instead of immediate creation prevents unnecessary tickets and keeps the workflow clear.

---

## Tech Stack

| Category | Skills |
|---|---|
| Frontend | Next.js 14, TypeScript, TanStack Query |
| Backend | Spring Boot |
| Database | MariaDB |
| Infra | Docker |

---

## What I Learned

This project taught me that structural judgment matters far more than just implementing features.
Decisions like where to cut transaction boundaries and which layer should handle data access control directly impact system stability.
