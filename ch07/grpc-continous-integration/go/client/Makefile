SHELL=/bin/bash

all: client

client: main.go
	@go mod tidy
	protoc -I ../../proto --go_out=. --go-grpc_out=. ../../proto/product_info.proto	
	
	if [ "$$(which mockgen)" = "" ]; then \
		go install github.com/golang/mock/mockgen@v1.6.0; \
	fi;

	go get github.com/golang/mock/mockgen/model

	if [ ! -e mock_prodinfo ]; then \
		mkdir mock_prodinfo; \
	fi;

	mockgen productinfo/client/ecommerce ProductInfoClient > mock_prodinfo/prodinfo_mock.go
	go build -v -o client

test:
	go test mock_prodinfo/*

clean:
	rm -rf mock_prodinfo/prodinfo_mock.go
	rm -rf ecommerce
	rm -rf client

