#!/bin/sh

docker create --name=kallithea-gevent --publish="127.0.0.1:5000:5000/tcp" kallithea-gevent
