FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0

RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates gpg-agent gnupg \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update && apt-get install -y google-chrome-stable --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends xvfb fluxbox curl libglib2.0-0 libnss3 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin

RUN curl -L https://chromedriver.storage.googleapis.com/73.0.3683.20/chromedriver_linux64.zip | zcat > chromedriver && chmod +x chromedriver

RUN groupadd -r app && useradd -r -g app -G audio,video app \
  && mkdir -p /home/app/Downloads \
  && chown -R app:app /home/app

WORKDIR /app
COPY app .

# kaniko pls
# RUN chown -R app /app
# USER app

ENTRYPOINT [ "/app/entrypoint.sh" ]
