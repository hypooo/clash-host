#!/bin/bash
docker builder prune -f && docker compose build --no-cache && docker compose up -d