#!/bin/bash
docker run -d --name ubuntu hwchiu/netutils 
docker run -d -p 6379:6379 --name redis redis:5.0
