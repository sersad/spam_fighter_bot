FROM golang:1.23-alpine3.20 as builder
WORKDIR /go/src/github.com/sersad/spam_fighter_bot
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build -o spam_fighter_bot ./cmd/spam_fighter_bot/spam_fighter_bot.go

FROM alpine:3.20
RUN apk --no-cache add ca-certificates && rm -rf /var/cache/apk/*
COPY --from=builder /go/src/github.com/sersad/spam_fighter_bot/spam_fighter_bot spam_fighter_bot

CMD ["./spam_fighter_bot"]