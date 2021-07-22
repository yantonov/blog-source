---
title: "Nice alternative to mocks, generate stub implementation"
date: 2020-08-27T17:47:15+05:00
categories: [programming]
tags: [stub, mock, test, tdd, go, golang]
---
[Here](https://github.com/matryer/moq) is nice [go](https://golang.org/) library named 'moq' that helps you to easily test dependent code but without verbose mocks setup.

The idea is to generate trivial implementations and just save all the calls as a list preserving all the arguments.

Using this you can simply assert all the invariants and stop to write long mock setup.
