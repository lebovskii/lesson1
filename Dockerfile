#FROM python:3.6-alpine3.8
#COPY 1.py /app/
#WORKDIR /app
#ENTRYPOINT ["python3", "/app/1.py"]

FROM golang:1.10 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app

FROM alpine:latest
WORKDIR /root/
COPY --from=builder ./app .
EXPOSE 8080
CMD ["./app"]