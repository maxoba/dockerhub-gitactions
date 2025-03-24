FROM --platform=$BUILDPLATFORM python:3.10-alpine AS  builder

WORKDIR /src
COPY  requirements.txt /src
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt



COPY . .

CMD ["python3","server.py"]

FROM builder as  dev-envs

RUN <<EOF
apk update
apk add git
EOF


RUN <<EOF
addgroup -s docker
adduser -s --shell bash --ingroup docker vscode
EOF

COPY --from=gloursdocker/docker / /
CMD ["python3","server.py"]
