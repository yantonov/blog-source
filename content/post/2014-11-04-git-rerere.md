---
title: "Git rerere"
date: 2014-11-04T14:26:21+05:00
categories: [git, vcs, scm, rerere, merge]
---
There is some usefull [git](https://git-scm.com) command rerere (reuse recorded resolution). Sometimes especially for long lived branch you need to resolve same conflicts again and again. This command let you save the results of conflict resolution and apply it again when needed.

Let see how its works:

``` bash
# create test repo
git init rerere

# move to it
cd rerere

# enable rerere - reuse recorded resolution (its disabled by default)
git config rerere.enabled true

# add some file
echo "test" > readme.txt
git add .
git commit -m "initial"

# add some changes
echo "line1" >> readme.txt
git add .
git commit -m "1"

# save first revision hash (used only to avoid hardcoded hash sums)
initialRevision=`git log HEAD^1 --pretty=format:"%H"`

# create second branch based on initial revision
# (simulate one long lived branch)
git checkout -b first $initialRevision
echo "line2" >> readme.txt
git add .
git commit -m "2"

# create third branch based again on initial revision
# (simulate one more long lived branch)
git checkout -b second $initialRevision
echo "line2" >> readme.txt
git add .
git commit -m "2 again"

# move to master
git checkout master

# merge with first long lived branch
git merge first

# resolve conflict and preserve line1
echo -e "test\nline1" > readme.txt
git add .
git commit -m "first merge"

# now watch for output:
# 'Recorded resolution for 'readme.txt'.'
# git saves conflict resolution for readme.txt file

# now lets merge with second branch
# the same conflict has here

git merge second
# look at the output
# 'Resolved 'readme.txt' using previous resolution.'

cat readme.txt
# you can see the results of saved resolution without conflict markers
# means : "test\nline1"
```

This is pretty usefull for example, for package versions (pom files, project.clj), because such file fragments are strictly localized.

``` xml
...
    <version>1.2.3</version>
...
```

Be caferul, this works for precisely same (charater by charater) conflicts and same files.
And one more, resolved conflicts older than 60 days will be pruned automatically, so you do not have to worry about repository size.

**Upd 1** Multiple changes to same file

Suppose you have resolved several conflicts at the same file.
What will rerere do ? Lets see ...

``` bash
# create test repo
git init rerere

# move to it
cd rerere

# enable rerere - reuse recorded resolution (its disabled by default)
git config rerere.enabled true

# add some file
echo -e "first\nsecond\third\fourth" > readme.txt
git add .
git commit -m "initial"

# add some changes
echo -e "first\nsecond 111\nthird\nfourth 111" > readme.txt
git add .
git commit -m "111"

# save first revision hash (used only to avoid hardcoded hash sums)
initialRevision=`git log HEAD^1 --pretty=format:"%H"`

# create second branch based on initial revision
# (simulate one long lived branch)
git checkout -b first $initialRevision
echo -e "first\nsecond 222\nthird\nfourth 111" > readme.txt
git add .
git commit -m "222"

# create third branch based again on initial revision
# (simulate one more long lived branch)
git checkout -b second $initialRevision
echo -e "first\nsecond 222\nthird\nfourth 333" > readme.txt
git add .
git commit -m "222 and 333"

# move to master
git checkout master

# merge with first long lived branch
git merge first

# resolve conflict and preserve 111
echo -e "first\nsecond 111\nthird\nfourth 111" > readme.txt
git add .
git commit -m "first merge"

# now watch for output:
# 'Recorded resolution for 'readme.txt'.'
# git saves conflict resolution for readme.txt file

# now lets merge with second branch
# the same conflict has here

git merge second
# look at the output
# Automatic merge failed; fix conflicts and then commit the result.

cat readme.txt
# you can see the conflict markers (rerere will apply stored resolution only in case of same conflict for whole file)
# there are no partial changes !

# contents of the file:
# 'Resolved 'readme.txt' using previous resolution.'
# first
# <<<<<<< HEAD
# second 111
# third
# fourth 111
# =======
# second 222
# third
# fourth 333
# >>>>>>> second
```

As you can see, there are no partial application.

Simple rule: same conflict for whole file -> apply stored resolution, any differences -> resolve manually and save it as another resolution sample.
