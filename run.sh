#!/bin/bash

rm -rf /tmp/.X*
rm -f /tmp/TS3*

cd /opt/ts3soundboard
./sinusbot -RunningAsRootIsEvilAndIKnowThat
