---
title: "Fix flash drive block size"
date: 2020-02-26T15:58:08+05:00
categories: []
tags: [flash, error, linux]
---
Let's suppose you want to format flash drive but while you are trying to start formatting you see an error like this 'The driver descriptor says the physical block size is 2048 bytes, but Linux says it is 512 bytes'.

Moreover, partitions can not be removed using neigher gnome disk nor gparted.

In that case you can use fdisk with privileged access:

```bash
    fdisk /dev/sdX
```

To show partition you can use 'p' command, to remove partition - 'q' command.

Afher that flash drive can be normalized like this:

```bash
    dd if=/dev/zero of=/dev/sdX bs=512 count=1
```

Be careful with sdX notation, check it twise before run any such command.
