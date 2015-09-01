# for your home directory
#!/bin/bash

git clone git@github.com:chuckshulicker/not-my-dotfiles.git &&
  cp -fr not-my-dotfiles/* . &&
  cp -fr not-my-dotfiles/.??* . &&
  rm -fr not-my-dotfiles/ &&
  git checkout . # fixes issues with weird permissions changes after copy
