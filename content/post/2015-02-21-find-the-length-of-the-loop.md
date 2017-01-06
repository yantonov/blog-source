---
title: "Find the length of the loop"
date: 2015-02-21T16:06:23+05:00
categories: [interview,task,problem,logic,linked list,data structures,fun, haskell]
---
*One of the popular interivew tasks...*

You are given a head of a [linked list](http://en.wikipedia.org/wiki/Linked_list). Its known list contains cycle. The goal is to determine the length of the loop.

Here is straghtforward solution in haskell

```haskell
{-
data Node a
instance Eq a => Eq (Node a)

next :: Node a -> Node a
-}

data Phase = TryFindLoop | FindLength deriving (Eq)

loopSize :: Eq a => Node a -> Int
loopSize a = slowAndFast a a 0 TryFindLoop
  where slowAndFast :: (Eq node) =>
                       Node node -> Node node -> Int -> Phase -> Int
        slowAndFast slow fast len phase =
          let nextSlow = next slow
              nextPreFast = next fast
              nextFast = next nextPreFast in
          if (slow == nextPreFast || slow == nextFast) then
            if (phase == FindLength) then
              if (nextPreFast == nextFast) then 1
              else
                2*(len+1) - len - (if slow == nextFast then 0 else 1)
            else slowAndFast nextSlow nextSlow 0 FindLength
          else
            slowAndFast nextSlow nextFast (len + 1) phase

```

Complexity: time o(n), memory o(1)

The idea: consider two pointers 'fast' and 'slow'. At each iteration 'slow' pointer makes one step, 'fast' - two steps. Somewhere 'fast' pointer touches 'slow' and you can find length of the loop.
