# Network

## OSI Model
### Level 1: Physical Layer
- Signal and binary transmission

### Level 2: Data Link Layer

### Level 3: Network Layer
- IP

### Level 4: Transport Layer
- TCP
- UDP
- QUIC (Quick UDP Internet Connections)
- SSL
- TLS

### Level 5: Session Layer

### Level 6: Presentation Layer

### Level 7: Application Layer
- HTTP
- SMTP
- FTP
- Telnet
- Web Socket
- gRCP

## IP Address
**IPv4**
- Use 4 bytes (32 bits)
- Has 4 octet, 1 octet = 1 byte (8 bits)
- 8 bits = 0 - 255
- 2 power of 32 equal 4294967296

**IPv6**
- Use 16 bytes (128 bits)
- Has 8 set, 1 set = 2 bytes (16 bits)
- 16 bits = 0000 - FFFF (Hexadecimal)
- 2 power of 128 equal 340282366920938463463374607431768211456

**Type**
- Public address
    - Use for API Gateway, Load balancer
- Private address
    - Use for Internal host    

## Private IP Address
**Class A**
- `Range:` 10.0.0.0 - 10.255.255.255
- `Default subnet mask:` 255.0.0.0

**Class B**
- `Range:` 172.16.0.0 - 172.31.255.255
- `Default subnet mask:` 255.255.0.0

**Class C**
- `Range:` 192.168.0.0 - 192.168.255.255
- `Default subnet mask:` 255.255.255.0

``` bash
# Find private ip address
ifconfig
```