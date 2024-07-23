all: server

server: main.go
	@go mod tidy
	protoc -I ../../proto --go_out=. --go-grpc_out=require_unimplemented_servers=false:. ../../proto/order_management.proto	
	go build -v -o server

clean:
	rm -rf ecommerce
	rm -rf client
	rm -rf server

