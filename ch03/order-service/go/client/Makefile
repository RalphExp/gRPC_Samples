all: client

client: main.go
	@go mod tidy
	protoc -I ../../proto --go_out=. --go-grpc_out=. ../../proto/order_management.proto	
	go build -v -o client

clean:
	rm -rf ecommerce
	rm -rf client

