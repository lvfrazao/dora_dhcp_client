# DORA The DHCP Client

Version 0.1.0

A Python command line DHCP client that was designed for troubleshooting. Provides an interface for sending tailored DHCP packets to a DHCP server and inspect the response.

## Installation

`pip install dora-dhcp-client`

## Requirements

* Python 3.8.0 or higher

**NOTE: This has been tested on Ubuntu 18.04 and Windows WSL. May or may not work on other platforms.**

## Basic Usage

Check if port 68 (and port 67 if relay field is set) is currently bound to by another program (for example with: `sudo netstat -tulpn`). If there is anything bound to these ports they must first be killed, and prevented from restarting.

Run `dora.py` with a `-h`/`--help` flag to see all the available options:

```shell
$ sudo dora.py -h
usage: dora.py [-h] [-i INTERFACE] [-a MAC_ADDR] [-d] [-u] [-s SERVER] [-r RELAY] [-v] [-o OPTIONS] [-p PORT] [--target_port TARGET_PORT] [-@ TARGET]

optional arguments:
  -h, --help            show this help message and exit
  -i INTERFACE, --interface INTERFACE
                        Interface to bind to and make DHCP requests
  -a MAC_ADDR, --mac_addr MAC_ADDR
                        MAC address to use (default random)
  -d, --debug           Print debug statements
  -u, --unicast         Send DHCP packets over unicast to specified server
  -s SERVER, --server SERVER
                        Server to send DHCP packets. Required for unicast and for relay use.
  -r RELAY, --relay RELAY
                        Address to set the giaddr field to
  -v, --verbose         Verbosity level (v: show ack packet, vv: show all packets, vvv: show debug)
  -o OPTIONS, --options OPTIONS
                        JSON body of options to include in requests
  -p PORT, --port PORT  Port to send packets from on client machine
  --target_port TARGET_PORT
                        Port to send to on target machine
  -@ TARGET             Given an IP address of a DHCP server, sends unicast requests
```

**NOTE: dora.py must be able to bind to port 68 (and 67 under certain circumstances) in order to function properly. This may require the use of `sudo`. This may also require stopping any services (e.g., systemd-networkd) that are already bound to those ports.**

![DORA Client Example](images/dora_ex1.PNG)

Running `dora.py` without supplying any options just binds to an arbitrary interface and sends out broadcast UDP packets. 

`-i` allows selection of the interface to bind to (e.g., "eth0")
`-a` allows the MAC address to be set in both the client identifier option and the chaddr field
`-d` Prints very low level debug statements and includes any Python tracebacks
`-u` sets the unicast flag in the DHCP packet
`-s` specifies an unicast address to send the packets to, the `-u` flag *should* be selected but doesnt need to be
`-r` sets the giaddr field of the packet
`-v` sets the verbosity level of the output. No `v` flags means that the client will just report success or failure to obtain a lease. A single `v` flag (`-v`) will pretty print  a human readable form of the DHCPACK packet. This will show the set of options that the DHCP server has sent us back. Two `v` flags (`-vv`) will pretty print the all four packets in the lease handshake (DHCPDISCOVER, DHCPOFFER, DHCPREQUEST, DHCPACK). Three `v` flags will print everything stated before and it will enable the debug output (same as setting the `-d` flag).
`-p` sets the client port (default: 68)
`--target_port` sets the server port (default: 67)
`-@` is a convenience flag that sets the unicast flag, sets the giaddr field to the IP of the current machine, and sends unicast packets to the server specified

**NOTE the DHCP RFC 2131 sets the client port to 68 and the server port to 67 options that set different client or server ports are not expected to work with an RFC compliant server**
