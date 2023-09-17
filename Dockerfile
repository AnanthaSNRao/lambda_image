FROM golang:1.21.0 as build
WORKDIR /lambda
# Copy dependencies list
COPY go.mod go.sum ./
# Build with optional lambda.norpc tag
COPY main.go .
RUN go build -tags lambda.norpc -o main main.go
# Copy artifacts to a clean image
FROM public.ecr.aws/lambda/provided:al2
COPY --from=build /lambda/main ./main
ENTRYPOINT [ "./main" ]