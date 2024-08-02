# 1) Generate CA and self-signed certificates
if [[ ! -e "ca.key" || ! -e "ca.crt" ]]; then
    openssl genrsa -aes256 -out ca.key 4096

    # create the root CA certificate with a validity of 
    # ten years using the SHA256 hash algorithm.
    openssl req -new -x509 -sha256 -days 3650 -key ca.key -out ca.crt

	# this command can show the information of the certificate
    openssl x509 -noout -text -in ca.crt 
fi

# 2) Generate private RSA key
if [ ! -e "server.key" ]; then
    openssl genrsa -out server.key 2048

    # create a certificate signing request.
    openssl req -new -sha256 -key server.key -out server.csr
fi

# 3) Generate client key and certificate
if [ ! -e "client.key" ]; then
    openssl genrsa -out client.key 2048
    openssl req -new -key client.key -out client.csr
fi

# 4) use our root CA to sign the CSR and create server/client certificate
openssl x509 -req -days 365 -sha256 -in server.csr \
    -CA ca.crt -CAkey ca.key -set_serial 1 -out server.crt -extfile extfile.cnf
openssl x509 -req -days 365 -sha256 -in client.csr \
    -CA ca.crt -CAkey ca.key -set_serial 2 -out client.crt -extfile extfile.cnf

# 5) generate .pem
openssl pkcs8 -topk8 -inform pem -in server.key -outform pem -nocrypt -out server.pem
openssl pkcs8 -topk8 -inform pem -in client.key -outform pem -nocrypt -out client.pem
