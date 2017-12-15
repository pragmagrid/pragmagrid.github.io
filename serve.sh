#!/bin/bash
set -e

PORT=3000

jekyll serve --watch --host localhost --port $PORT & (sleep 5 && open "http://localhost:$PORT/") 

#jekyll serve --limit_posts 10 --watch --host localhost --port $PORT
