## Build
FROM golang:1.17-buster AS build

WORKDIR /app

ENV GOPRIVATE=github.com/*/*
ARG GITHUB_TOKEN
RUN git config --global url.https://$GITHUB_TOKEN@github.com/.insteadOf https://github.com/ 

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY * ./

RUN go build -o /application

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /app

COPY --from=build /application ./application

EXPOSE 8080

ENTRYPOINT ["/app/application"]
