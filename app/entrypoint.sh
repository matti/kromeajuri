#!/usr/bin/env sh
set -e

mkdir -p /app/tmp
Error() {
  echo "$1 EXITED"
  exit 1
}

(
  Xvfb :0 -screen 0 1600x900x8 -fbdir /app/tmp; Error "Xvfb"
) &

(
  fluxbox; Error "fluxbox"
) &

su - app -c "chromedriver --whitelisted-ips --url-base=wd/hub --verbose --port=$PORT" &
wait $!

Error "chromedriver"
