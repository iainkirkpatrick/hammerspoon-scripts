#!/bin/bash
cp ./init.lua ~/.hammerspoon/
if [ $? -eq 0 ]; then
  echo "setup complete, run Hammerspoon to start scripts"
else
  echo "oops, setup failed"
fi
