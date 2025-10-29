FROM node:18-alpine3.20

WORKDIR /app

# 使用更快的 Alpine 源
RUN sed -i 's|dl-cdn.alpinelinux.org|mirrors.ustc.edu.cn|g' /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash

COPY package*.json ./

# 设置 npm 镜像，加速依赖安装
RUN npm config set registry https://registry.npmmirror.com && npm install

COPY . .

# 可选：如果确实需要执行权限
# RUN chmod +x index.js

EXPOSE 3000

CMD ["node", "index.js"]
