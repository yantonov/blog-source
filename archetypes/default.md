---
title: "{{ replace ( replaceRE "^[0-9]{4}-[0-9]{2}-[0-9]{2}-(.*)" "$1" .Name) "_" " " | humanize }}"
date: {{ .Date }}
categories: [some_category]
tags: [""]
draft: true
---
