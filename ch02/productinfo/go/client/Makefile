all: client

client:
	@go mod tidy
	protoc -I ../../proto --go_out=. --go-grpc_out=. ../../proto/product_info.proto	
	go build -v -o client

clean:
	rm -rf ecommerce
	rm -rf client

