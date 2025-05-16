# 使用支援 Dart 3.x 的 Flutter 映像
FROM ghcr.io/cirruslabs/flutter:3.19.0 AS build

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build web

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html