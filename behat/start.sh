#!/bin/bash

cd /app/hekla

# Select Profile
if [ -n "$PROFILE" ]; then

    # If profile is javascript, start Xvfb Selenium PHP built-in server
    if [[ "javascript" == $PROFILE ]]; then
        if [ -e "/tmp/.X99-lock" ]; then
            rm /tmp/.X99-lock
        fi

        # Start Virtual Frame Buffer
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
    fi

    PROFILE="--profile=$PROFILE"
fi

# Execute behat tests
bin/behat $PROFILE $ADD_OPTIONS $FEATURES
