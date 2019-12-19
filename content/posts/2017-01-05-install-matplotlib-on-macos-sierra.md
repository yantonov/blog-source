---
date: 2017-01-05T22:38:37+05:00
title: Install matplotlib on mac sierra
categories: [python, python3, matplotlib, mac]
---
During matplotlib installation (for python3) some error may occured:  
'The following required packages can not be built:  
* freetype  
* png'  

Thats why some additional steps may be required:

1. install [homebrew](http://brew.sh)

2. install pkg-config
```bash
brew install pkg-config
```

3. install freetype
```bash
brew install freetype
```

4. install matplotlib
```bash
pip3 install matplotlib
```

Enjoy!

