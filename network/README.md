# Network

## Port
Port numbers range from 0-65535

**Port numbers has 3 categories**
- System or Well-known ports, Port numbers range 0-1023
- User or Registered ports, Port numbers range 1024-49151
    - These are ports that can be registered by companies and developers for a particular service
- Dynamic or Private ports, Port numbers range 49152-65535
    - These are client-side ports that are free to use

## Test connection
``` bash
ping {ip_address|domain_name}

# To test connectivity to a specific TCP service listening on your host
nc -vz {domain_name} {port}

# Transfer data with URL to a server
curl -kv {protocol}://{domain_name}:{port}

# Verify certificate
openssl s_client -connect {domain_name}:{port} -servername {domain_name} -showcerts </dev/null
```

## Resolve domain name to ip address
``` bash
ping {domain_name}
```

## DNS record
- A Record
    - Point to IPv4 (32 bit length)
- AAAA Record
    - Point to IPv6 (128 bit length)
- CNAME record (Canonical name)
- NS record
- MX record
- TXT record
- SOA record

## Query DNS record
- DNS servers use port 53 to communicate
``` bash
# Find the A record of а domain
nslookup {domain_name}

# View domain's name server (NS) records
nslookup -type=ns {domain_name}

# View all available DNS records
nslookup -type=any {domain_name}

# View information
nslookup -debug {domain_name}

# View specific name server information
nslookup {domain_name} {name_server}

# Reverse DNS lookup
nslookup {ip_address}

# Specify timeout for the server to respond
nslookup -timeout=[seconds] {domain_name}
```

## View a certificate fingerprint as SHA-256, SHA-1 or MD5
``` bash
# SHA-256
openssl x509 -noout -fingerprint -sha256 -inform pem -in [path/to/certificate-file.crt]

# SHA-1
openssl x509 -noout -fingerprint -sha1 -inform pem -in [path/to/certificate-file.crt]

# MD5
openssl x509 -noout -fingerprint -md5 -inform pem -in [path/to/certificate-file.crt]

# openssl x509 -noout -fingerprint -sha256 -inform pem -in server.crt
```