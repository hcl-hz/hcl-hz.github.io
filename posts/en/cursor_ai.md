---
title: "Cursor AI"
date: "2026-03-14"
category: "projects"
description: "How to use Cursor AI"
tags: ["Cursor", "AI", "VSCode"]
thumbnail: ""
---

---

This article compiles information to help you quickly learn Cursor.

There are some really useful features that I recommend learning.

---

## **#1 VSCode Integration**

Since Cursor is an IDE forked from VSCode, you can import your existing VSCode extensions.

You can set this up by going to:
Cursor Settings > General > Account

**If you can't find Cursor Settings, press Ctrl + Shift + J to open it.**

## **#2 Key Commands (Shortcuts)**

In Cursor, knowing these 3 features and their shortcuts will cover about 80% of what you need to know.

**1. Tab**

If you pause for about 1 second in the editor, Cursor Copilot++ will **auto-complete code** using AI.

![1](https://blog.kakaocdn.net/dn/cdDb18/btsJ4eATVwU/hvckbgbLoex5JEeOo5UKG0/img.png)

Code auto-prediction and completion

![2](https://blog.kakaocdn.net/dn/cRoxgk/btsJ5fTbJeO/s6G0KkwOoU6ZsaJCzPkkn0/img.png)

Auto-completion based on patterns from other lines
Auto-completion based on patterns from other lines

**2. Ctrl + K**

Using Ctrl + K allows you to **instantly edit and write code** with AI.

This is useful because you can modify or ask questions about specific ranges or lines directly with prompts.

To generate completely new code, just press Ctrl + K without selecting anything.

You can use various symbol settings like @Codebase, @Docs, @Web in the same way.

More about symbols in #3 below

![3](https://blog.kakaocdn.net/dn/GTFbL/btsJ3XMKOBh/ZJRPnbzrqi0EbExZGmQjgK/img.png)

Using Ctrl + K on code opens a mini popup.

![4](https://blog.kakaocdn.net/dn/cEzQo2/btsJ6cOZUZc/ORWKTYcniTMSg7xunqKN01/img.png)

You can generate or request code modifications, accept changes with Ctrl + Shift + Y, reject with Ctrl + N

![5](https://blog.kakaocdn.net/dn/bH7nMH/btsJ6fZfVhl/auMcvlKPV3Zbu0sKPHHk71/img.png)

Write a question in the mini popup and press Alt + Enter to ask about the code directly

![6](https://blog.kakaocdn.net/dn/HHXcp/btsJ303JNcn/GPk9Jue2AqkAOMbjiUq04k/img.png)

Also works in VSCode's internal CMD command terminal

**3. Ctrl + L**

Pressing Ctrl + L opens a tab on the right side of the editor for **chatting with the LLM**.

You can chat with AI that sees the currently open code file.

Since the chat always sees the current file and cursor position, you can ask questions like "Are there any bugs in this code?"

You can use various symbol settings like @Codebase, @Docs, @Web in the same way.

More about symbols in #3 below

![7](https://blog.kakaocdn.net/dn/cWeTgN/btsJ6V61F8p/QHZY7X7fSTtvreM8Wfp2O0/img.png)

Use Ctrl+Shift+L or "@" to add specific code blocks to the context.

![8](https://blog.kakaocdn.net/dn/Td96H/btsJ6pggIG3/QEJHTBjc8Vd5N97QhZqOdk/img.png)

Press Ctrl+Enter to chat with the entire codebase. Scanning takes some time.

---

## **#3 Symbol @**

In Cursor, you can change the search functionality using symbols when using chat or mini prompts.

Type "@" to see various search options and select your preferred search method.

**@Codebase**

![9](https://blog.kakaocdn.net/dn/bkYI3Z/btsJ6H2hFeI/MPnqVe6Khe0JnrvTEYutTK/img.png)

Typing @Codebase scans the entire codebase to provide answers.

Recommended when you want to browse the entire project or ask questions about the whole file.

**@Docs**

![10](https://blog.kakaocdn.net/dn/cUcSsm/btsJ6jm0xDQ/GCIQq5JQGnSF3WkHaxCqc0/img.png)

@Docs tab

![11](https://blog.kakaocdn.net/dn/sMKQt/btsJ3Y5YZT1/jCKqjgW61O1y5U2tqKDgoK/img.png)

Input window after selecting Docs tab, enter your desired document link and click Confirm

![12](https://blog.kakaocdn.net/dn/kCIHe/btsJ418wVBx/3Jgmyu3bIBLvgBMVZ8O9H1/img.png)

Successfully loaded document

Using @Docs allows you to reference popular libraries or use @Docs → Add new doc to

input website links for desired documents as references. Referenced documents remain available for use.

AI provides answers based on the referenced documents.

**@Web**

![13](https://blog.kakaocdn.net/dn/FRGN9/btsJ5BIhtqh/2wFJe1MGlngfokGK8R0LA0/img.png)

Using @Web makes AI search the internet for latest information and provide answers based on summarized content.

Use these symbols appropriately for different situations.

However, after trying @Web, I think searching myself might be better given its current performance.

---

## **#4 AI Model Recommendations - Which Model Should I Use?**

![14](https://blog.kakaocdn.net/dn/dHnTx9/btsJ5B9lOeZ/jWocrv6PoagJEpkKuqLOG1/img.png)

As of 2024.10.15, these are the models available on my screen using the Hobby (basic) plan.

I recommend using different models depending on the situation.

**For General Situations**

**claude-3.5-sonnet** was best for reasoning ability and general situations.

**For Complex Code or Error Analysis**

**o1-mini** seemed most professional and worked best.

Note: To switch models, press ctrl + / for quick model switching.
The shortcut to open the model switch menu is ctrl + alt + /.

![15](https://blog.kakaocdn.net/dn/yFAmD/btsJ4da1zkb/4Klu0kxgIi5E6KhgyWKVk0/img.png)

You can toggle and add other desired models in Cursor Settings.

---

## **#5 AI Rules Configuration**

![16](https://blog.kakaocdn.net/dn/dBWkCU/btsJ4fNc1KA/Xm3nE1yAqFcrX09RiauX9k/img.png)

Cursor Settings -> General -> Rules for AI

In Cursor Settings (Ctrl + Shift + J), you can configure AI rules.

By default, it should be set to respond in Korean as much as possible.

Here's a refined set of rules to get higher quality responses:

**Close**

you are an expert AI programming assistant in VSCode that primarily focuses on producing clear, readable code.

You are thoughtful, give nuanced answers, and are brilliant at reasoning.

You carefully provide accurate, factual, and thoughtful answers, and you are a genius at reasoning.

1. Follow the user's requirements carefully and precisely.

2. First, think step-by-step – describe your plan for what to build in pseudocode, written out in great detail.

3. Confirm, then write the code!

4. Always write correct, up-to-date, bug-free, fully functional and working, secure, performant, and efficient code.

5. Focus on **readability** over performance.

6. Fully implement all requested functionality.

7. Leave **NO** to-dos, placeholders, or missing pieces.

8. Ensure the code is complete! Thoroughly verify the final version.

9. Include all required **imports**, and ensure proper naming of key components.

10. Be concise. Minimize any unnecessary explanations.

11. If you think there might not be a correct answer, say so. If you do not know the answer, admit it instead of guessing.

12. Always provide concise answers.

13. Please answer in Korean

If you want AI responses tailored to your current language or desired platform,
I recommend checking other rules at the link below:

https://cursor.directory/

[**Cursor Directory**
Find the best cursor rules for your framework and language
cursor.directory](https://cursor.directory/)

---

## **#6 Notepad Feature (Beta)**

You can manage notepads in Cursor.

Press Ctrl + i (or Cmd + i on Mac) to open the Composer tab (it will likely be small)

![17](https://blog.kakaocdn.net/dn/bYjCvy/btsJ4KlQRZ4/SBt6wNNBs3KpFbiiO8okqk/img.png)

Click the Open Control Panel button in the top right to open the notepad.

![18](https://blog.kakaocdn.net/dn/cHyWbo/btsJ5ovExHi/hQT95gHW0IwY0hLYH3HKM1/img.png)

Click the plus button at the top of the left tab in the notepad window to create a new note.

![19](https://blog.kakaocdn.net/dn/QC5AR/btsJ3Z3P8F5/rTCtSsUwyDVa5aSqluyxsk/img.png)

Write anything in the note and press Ctrl + L to bring it to the prompt.

![20](https://blog.kakaocdn.net/dn/bKlwOE/btsJ4YYtlhY/uHMukld8JLY9qIvuBqQlKK/img.png)

The notepad you just created can be tracked using @.

![21](https://blog.kakaocdn.net/dn/c6cglp/btsJ5CNZZlJ/8k4TMMZSMR25xODbkCT1K0/img.png)

While you can include notepads in prompts to get results like this,
it would be nice if the notepad had AI features. Since it's still in beta, let's wait and see.

---

## **#7 How to Analyze Projects in 5 Minutes**

I'll show you how to understand project structure in 5 minutes using Cursor.

> 1. Press Ctrl + L to open the Cursor chat panel.
>
> [http://www.mermaidchart.com](http://www.mermaidchart.com/)

https://kimyir.tistory.com/97

[**Analyzing Projects in 5 Minutes with Cursor**
How to Analyze Projects in 5 Minutes I'll show you how to understand project structure in 5 minutes using Cursor. 1. Press Ctrl + L to open the Cursor chat panel. 2. Switch from "Normal chat" to "Long Co
kimyir.tistory.com](https://kimyir.tistory.com/97)

---

That concludes the basic usage and tips for Cursor.

Being based on VSCode makes it accessible and easy to use.

While the many features might slow down the IDE a bit, I think it's worth it for productivity.

If you're concerned about AI learning from your code,
go to Cursor Settings -> General -> Privacy mode and set it to enabled.
This prevents code from being exposed externally but may reduce AI response quality.

**Bonus) Other Useful AI Recommendations**

Terminal AI Assistant

https://github.com/Aider-AI/aider
