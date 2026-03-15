---
title: "Cursor AI"
date: "2026-03-14"
category: "projects"
description: "Cursor AI 사용법"
tags: ["Cursor", "AI", "VSCode"]
thumbnail: ""
---

---

이번에 작성한 글은 Cursor를 빨리 익히기 위해 정보들을 모아봤습니다.

알아두면 진짜 좋은 기능들도 있으니 한번 공부해보시는걸 추천합니다.

---

## **#1 VSCode 연동**

Cursor는 VSCode를 포크 떠서 만든 IDE기 떄문에 기존에 VSCode에서 사용하던 확장들을 가져올 수 있습니다.

Cursor Settings > General > Account

로 가셔서 설정할 수 있습니다.

**Cursor Settings를 못찾겠다면 Ctrl + Shift + J를 누르셔서 여시면 됩니다.**

## **#2 주요 커맨드 ( 단축키 )**

Cursor에서는 아래 3가지 기능을 단축키로 외워두시면 80퍼센트 알게된거라 보시면 됩니다.

**1. Tab**

에디터에서 약 1초간 가만히 있으면 Cursor Copilot++이 AI로 **코드를 자동완성** 해줍니다.

![1](https://blog.kakaocdn.net/dn/cdDb18/btsJ4eATVwU/hvckbgbLoex5JEeOo5UKG0/img.png)

코드 자동 예측해서 완성

![2](https://blog.kakaocdn.net/dn/cRoxgk/btsJ5fTbJeO/s6G0KkwOoU6ZsaJCzPkkn0/img.png)

다른 줄의 패턴에 따라 자동 완성
다른 줄의 패턴에 따라 자동 완성

**2. Ctrl + K**

Ctrl + K를 사용하면 AI로 **바로바로 코드를 편집**하고 작성할 수 있습니다.

이걸 쓰는 이유는 특정 범위 또는 줄만 바로 프롬포트로 수정하거나 질문 가능하기때문입니다.

완전히 새로운 코드를 생성하려면 아무 것도 선택하지 않고 Ctrl K만 입력하면 됩니다.

@Codebase, @Docs, @Web 등 여러 가지 심볼 설정을 똑같이 사용가능합니다.

심볼에 관해선 아래 #3 에 설명

![3](https://blog.kakaocdn.net/dn/GTFbL/btsJ3XMKOBh/ZJRPnbzrqi0EbExZGmQjgK/img.png)

코드에 Ctrl + K를 사용하면 미니 팝업이 뜹니다.

![4](https://blog.kakaocdn.net/dn/cEzQo2/btsJ6cOZUZc/ORWKTYcniTMSg7xunqKN01/img.png)

코드를 생성하거나 수정요청할 수 있으며 바뀌는걸 Ctrl + shift + Y로 수락, Ctrl + N로 거부

![5](https://blog.kakaocdn.net/dn/bH7nMH/btsJ6fZfVhl/auMcvlKPV3Zbu0sKPHHk71/img.png)

미니팝업에 질문을 쓰고 Alt + Enter를 입력하면 바로 해당 코드에 질문 가능합니다

![6](https://blog.kakaocdn.net/dn/HHXcp/btsJ303JNcn/GPk9Jue2AqkAOMbjiUq04k/img.png)

또한 VSCode 내부 CMD 커맨드 터미널에도 사용 가능합니다

**3. Ctrl + L**

Ctrl + L를 사용하면 에디터 화면 오른쪽에 LLM과 **Chat을 할 수 있는 탭**이 열립니다.

Chat을 통해 현재 열린 코드 파일을 보는 AI와 대화할 수 있습니다.

채팅에서는 항상 현재 파일과 커서를 볼 수 있으므로 "지금 코드에 버그가 있나요?"와 같은 질문을 할 수 있습니다.

@Codebase, @Docs, @Web 등 여러 가지 심볼 설정을 똑같이 사용가능합니다.

심볼에 관해선 아래 #3 에 설명

![7](https://blog.kakaocdn.net/dn/cWeTgN/btsJ6V61F8p/QHZY7X7fSTtvreM8Wfp2O0/img.png)

Ctrl+Shift+L 또는 "@"을 사용하여 특정 코드 블록을 컨텍스트에 추가할 수 있습니다.

![8](https://blog.kakaocdn.net/dn/Td96H/btsJ6pggIG3/QEJHTBjc8Vd5N97QhZqOdk/img.png)

Ctrl+Enter를 눌러 전체 코드베이스와 채팅할 수 있습니다. 스캔에 조금 시간 걸립니다.

---

## **#3 심볼 @**

Cursor에는 Chat이나 미니 프롬프트에 챗을 사용할 때 심볼로 검색 기능을 바꿀 수 있습니다.

"@" 기호를 입력시 여러 검색 기능을 볼 수 있으며 원하는 검색 방식을 선택할 수 있습니다.

**@Codebase**

![9](https://blog.kakaocdn.net/dn/bkYI3Z/btsJ6H2hFeI/MPnqVe6Khe0JnrvTEYutTK/img.png)

@Codebase 를 입력시 전체 코드베이스를 스캔하여 답변을 합니다.

프로젝트 전체적으로 훑어보고 싶으시거나 파일 전체를 대상으로 질문하고 싶을 때 사용을 추천합니다.

**@Docs**

![10](https://blog.kakaocdn.net/dn/cUcSsm/btsJ6jm0xDQ/GCIQq5JQGnSF3WkHaxCqc0/img.png)

@Docs 탭

![11](https://blog.kakaocdn.net/dn/sMKQt/btsJ3Y5YZT1/jCKqjgW61O1y5U2tqKDgoK/img.png)

Docs 탭을 선택 후 뜨는 입력창, 원하시는 문서 링크를 넣으시고 Confirm 눌러주세요

![12](https://blog.kakaocdn.net/dn/kCIHe/btsJ418wVBx/3Jgmyu3bIBLvgBMVZ8O9H1/img.png)

문서를 제대로 받아온 모습

@Docs 를 입력시 인기 있는 라이브러리를 참조하거나 @Docs → Add new doc 를 사용하여

원하시는 문서의 웹사이트 링크를 입력하여 참조가능합니다. 참조한 문서는 계속 사용 가능합니다.

참조한 문서를 토대로 AI가 답변을 해줍니다.

**@Web**

![13](https://blog.kakaocdn.net/dn/FRGN9/btsJ5BIhtqh/2wFJe1MGlngfokGK8R0LA0/img.png)

@Web 를 입력시 AI가 인터넷에서 최신 정보를 검색하여 요약한 내용을 바탕으로 답변을 해줍니다.

이렇게 심볼을 상황에 맞게 잘 선택하여 써주시면 됩니다.

근데 @Web은 써보니까 그냥 제가 검색하는게 나을것 같은 성능이네요.

---

## **#4 AI 모델 추천, 어떤 모델을 써야할까?**

![14](https://blog.kakaocdn.net/dn/dHnTx9/btsJ5B9lOeZ/jWocrv6PoagJEpkKuqLOG1/img.png)

2024.10.15 날짜 기준으로 Hobby(기본) 요금제를 사용하고 있는 제 화면에는 이렇게 모델들이 있습니다.

상황에 따라 다른 모델을 쓰는것을 추천합니다.

**일반적인 상황**

**claude-3.5-sonnet**이 추론 능력이라던지 일반적인 상황에선 쓰기 가장 좋았습니다.

**복잡한 코드나 에러 분석해야할 때**

**o1-mini**가 가장 전문적인 것 같아 쓰기 좋았습니다.

참고 : 모델 교체할 때는 ctrl + / 키를 누르시면 단축키로 바로 모델 교체 가능합니다.

모델 교체 메뉴를 바로 여는 단축키는 ctrl + alt + / 키입니다.

![15](https://blog.kakaocdn.net/dn/yFAmD/btsJ4da1zkb/4Klu0kxgIi5E6KhgyWKVk0/img.png)

이외에도 따로 쓰고 싶으신 모델은 Cursor Settings 설정에 가셔서 토글하실 수 있고 원하는 모델을 추가할 수 있습니다.

---

## **#5 AI 규칙 설정**

![16](https://blog.kakaocdn.net/dn/dBWkCU/btsJ4fNc1KA/Xm3nE1yAqFcrX09RiauX9k/img.png)

Cursor Settings -> General -> Rules for AI

Cursor Settings(Ctrl + Shift + J)를 들어가보시면 AI 규칙을 설정할 수 있습니다.

그냥 써도 기본으로 최대한 한국어로 답변하라는 규칙이 설정되어있을겁니다.

이걸 조금 더 가공해서 더 퀄리티 높은 답변을 할 수 있도록하는 규칙을 공유해드리겠습니다.

**닫기**

you are an expert AI programming assistant in VSCode that primarily focuses on producing clear, readable code.

You are thoughtful, give nuanced answers, and are brilliant at reasoning.

You carefully provide accurate, factual, and thoughtful answers, and you are a genius at reasoning.

1. Follow the user's requirements carefully and precisely.

2. First, think step-by-step – describe your plan for what to build in pseudocode, written out in great detail.

3. Confirm, then write the code!

4. Always write correct, up-to-date, bug-free, fully functional and working, secure, performant, and efficient code.

5. Focus on **readability** over performance.

6. Fully implement all requested functionality.

7. Leave **NO** to-dos, placeholders, or missing pieces.

8. Ensure the code is complete! Thoroughly verify the final version.

9. Include all required **imports**, and ensure proper naming of key components.

10. Be concise. Minimize any unnecessary explanations.

11. If you think there might not be a correct answer, say so. If you do not know the answer, admit it instead of guessing.

12. Always provide concise answers.

13. Please answer in Korean

혹시나 현재 사용하고 계신 언어에 맞게 또는 원하는 플랫폼에 맞는 AI 답변을 원할 경우

아래 링크에서 다른 규칙도 찾아보시는걸 추천 드립니다.

https://cursor.directory/

[**Cursor Directory**
Find the best cursor rules for your framework and language
cursor.directory](https://cursor.directory/)

---

## **#6 노트패드 기능 (베타)**

Cursor에서도 노트패드를 관리할 수 있습니다.

Ctrl + i 키 또는 맥에선 Cmd + i 키를 누르셔서 Composer 탭을 열어주신 뒤(아마 작을겁니다)

![17](https://blog.kakaocdn.net/dn/bYjCvy/btsJ4KlQRZ4/SBt6wNNBs3KpFbiiO8okqk/img.png)

오른쪽 상단에 Open Control Panel 버튼을 눌러주시면 노트패드가 열립니다.

![18](https://blog.kakaocdn.net/dn/cHyWbo/btsJ5ovExHi/hQT95gHW0IwY0hLYH3HKM1/img.png)

노트패드창에서 왼쪽탭 상단에 더하기 버튼이 있을텐데 이 버튼을 눌러서 노트 하나 생성합시다.

![19](https://blog.kakaocdn.net/dn/QC5AR/btsJ3Z3P8F5/rTCtSsUwyDVa5aSqluyxsk/img.png)

노트 내용에 아무거나 쓰신 뒤 Ctrl + L 키를 눌러 프롬프트에 들고 갑시다.

![20](https://blog.kakaocdn.net/dn/bKlwOE/btsJ4YYtlhY/uHMukld8JLY9qIvuBqQlKK/img.png)

이런식으로 방금 만든 노트패드가 @로 추적이 가능합니다.

![21](https://blog.kakaocdn.net/dn/c6cglp/btsJ5CNZZlJ/8k4TMMZSMR25xODbkCT1K0/img.png)

노트패드를 프롬프트에 포함시켜 이런식으로 결과물을 받아올 수도 있긴하지만

노트패드 작성시에 AI 기능이 있었다면 더 좋지 않을까 싶네요 아직 베타니까 기다려봅시다.

---

## **#7 프로젝트 5분만에 분석하는 법**

Cursor를 이용해 5분 만에 프로젝트 구조를 파악하는 방법을 알려드리겠습니다.

> 1. Ctrl + L 을 눌러 Cursor 채팅 패널을 엽니다.
>
> [http://www.mermaidchart.com](http://www.mermaidchart.com/)

https://kimyir.tistory.com/97

[**Cursor로 5분만에 프로젝트 분석하기**
프로젝트 5분만에 분석하는 법 Cursor를 이용해 5분 만에 프로젝트 구조를 파악하는 방법을 알려드리겠습니다. 1. Ctrl + L 을 눌러 Cursor 채팅 패널을 엽니다. 2. "Normal chat"에서 "Long Co
kimyir.tistory.com](https://kimyir.tistory.com/97)

---

이상 Cursor의 기본 사용 방법과 꿀팁을 정리해보았습니다.

VSCode를 바탕으로 만들어서 그런지 접근하기 쉬웠고 쓰기도 편한 것 같습니다.

물론 기능이 많은 만큼 IDE 속도가 느려진 것 같지만 능률을 위해서라면 그래도 쓸 것 같네요.

내 코드가 혹시나 AI가 학습하지 않을까 걱정되신다면

Cursor Settings -> General -> Privacy mode 탭에 가셔서 enabled로 설정해주시면 됩니다.

코드가 외부에 유출안되지만 AI 답변 품질이 떨어질 순 있습니다.

**번외) 다른 유용한 AI 추천**

터미널 AI 도우미

https://github.com/Aider-AI/aider
