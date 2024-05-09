FROM golang:1.22-alpine as build-stage
WORKDIR /app
COPY . .
RUN go mod download && go mod verify
RUN CGO_ENABLED=0  go build -v -o main.go .


FROM alpine:latest

COPY --from=build-stage /app /bin

CMD ["main"]