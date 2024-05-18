#!/bin/sh

# Git proxy settings
echo "Configuring Git..."
git config --global http.proxy http://gateway.zscaler.net:80/
git config --system http.proxy http://gateway.zscaler.net:80/
git config --global http.sslVerify false
git config --system http.sslVerify false
git config --global --unset http.sslcainfo
git config --system --unset http.sslcainfo
