# Generate private RSA key
if [ ! -e server.key ]; then
	openssl genrsa -out server.key 2048
fi

# self-signed certificate
openssl req -new -x509 -sha256 -key server.key \
        -addext "subjectAltName = DNS:localhost" -out server.crt -days 3650

