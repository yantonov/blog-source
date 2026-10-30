---
title: "Handling enter during ime composition"
date: 2026-10-30T17:06:54+01:00
categories: [programming]
tags: [frontend, javascript, typescript, enter]
---
When implementing form submission on Enter, it is important to account for Input Method Editors (IMEs), which are commonly used to enter Chinese, Japanese, and Korean text.

During text composition, Enter may confirm a selected character or word. Submitting the form on that same keystroke can save incomplete text. Checking isComposing prevents the handler from submitting while composition is active. In React, this flag is accessed through nativeEvent:

```typescript
if (e.key === 'Enter' && !e.nativeEvent.isComposing) {
  save();
}
```

[Source](https://t.me/mypillowbook/609)
