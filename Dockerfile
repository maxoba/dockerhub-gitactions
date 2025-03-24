
FROM --platform=$BUILDPLATFORM python:3.10-alpine AS builder
WORKDIR /src
COPY requirements.txt /src
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

COPY . .
CMD ["python3", "server.py"]
FROM builder as dev-envs
RUN apk update && apk add --no-cache git bash
RUN addgroup -S docker && \
    adduser -S vscode -G docker -s /bin/bash

COPY --from=gloursdocker/docker / /

CMD ["python3", "server.py"]

