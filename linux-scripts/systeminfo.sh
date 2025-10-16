#!/bin/bash

echo "1. Linux Distribution Name and Version"
echo "-------------------------------------"
cat /etc/os-release
echo "-------------------------------------"

echo "2. Kernel Version"
echo "-----------------"
uname
uname -a
echo "-----------------"

echo "3. Init System In Use"
echo "--------------------"
stat /sbin/init
echo "--------------------"

