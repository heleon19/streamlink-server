FROM node:11.9-slim

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN wget -qO- "http://bintray.com/user/downloadSubjectPublicKey?username=amurzeau" | apt-key add - \
    && echo "deb http://dl.bintray.com/amurzeau/streamlink-debian stretch-backports main" | tee "/etc/apt/sources.list.d/streamlink.list" \
    && apt-get update \
    && apt-get install --no-install-recommends -y streamlink \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN npm install

EXPOSE 8080

CMD ["node", "main.js"]
