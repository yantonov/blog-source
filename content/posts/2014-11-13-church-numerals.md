---
title: "Church numerals"
date: 2014-11-13T08:17:25+05:00
categories: [lambda calculus, haskell, fprog]
---
[Church numerals](http://en.wikipedia.org/wiki/Church_encoding) is a great example of introducing abstraction in terms of composition of functions. This concept demonstrates that "data" (naturals numbers in particular) and operations on data can be defined in the same way - using higher-order functions.

Summary:

``` haskell
type Church a = (a -> a) -> a -> a

zero, cone, ctwo :: Church a
zero s z = z
one s z = s z
two s = s . s
three s = s . s . s
nth n s z = iterate s z !! n

add,mul,pow  :: Church a -> Church a -> Church a

add x y = \s z -> x s (y s z)

-- a little bit easy to understand
mul1 x y = \s z -> x (y s) z
-- the same as
mul x y = x . y

pow x y = \s z -> y (x s) (x s z)

-- pretty print
c2i x = x (+1) 0 -- Church to int
c2s x = x ('*':) "" -- Church to String
```
Links:

1. [Church numerals: a tutorial](https://karczmarczuk.users.greyc.fr/Essays/church.html)  
2. [Natural Numbers as Church Numerals](http://www.cs.unc.edu/~stotts/723/Lambda/church.html)  
3. [Wikipedia](http://en.wikipedia.org/wiki/Church_encoding)
