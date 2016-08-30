#!/bin/bash

cd /app/hekla

# Start Virtual Frame Buffer
if [ -e "/tmp/.X99-lock" ]; then
    rm /tmp/.X99-lock
fi

if [ -z "$(ps aux | grep -v grep | grep Xvfb)" ]; then
    export DISPLAY=:99.0
    Xvfb :99.0 &
fi

# Start Selenium
if [ -z "$(ps aux | grep -v grep | grep selenium)" ]; then
    export _JAVA_OPTIONS="-Xms2048m -Xmx2048m"
    bin/selenium-server-standalone &> /dev/null &
fi

# Start PHP built-in server
php bin/console server:start -e test --force

# Execute behat tests
bin/behat
