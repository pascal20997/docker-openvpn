# Very dynamic OpenVPN #

Please be patient: Until now this container is still BETA

## How to configure ##
This container provides a very high dynamic. In this section I´ll
show you what I mean.

### Adding users ###
You can add users via environment variables. Use this structure:


| Variable name      | Value         | Description                           |
| ------------------ |:-------------:| ------------------------------------- |
| OPENVPN\_USER\_n   | e.g. pascal   | The username while n is the indicator |
| OPENVPN\_PASS\_n   | e.g. 123456   | The password for OPENVPN\_USER\_n     |
| OPENVPN_HOSTNAME   | e.g. host.tld | The host name used in user config     |

For example if you want to add 4 users then the first user is OPENVPN_USER_1,
the second OPENVPN_USER_2 and so on. The same structure with OPENVPN_PASS_1.
Each user MUST HAVE a password.

### Configure certificate parameters ###
It´s almost the same than pure easy-rsa names:

Variables:
```
EASYRSA_COUNTRY: "DE"
EASYRSA__PROVINCE: "BW"
EASYRSA_CITY: "Stuttgart"
EASYRSA_ORG: "YourOrganization"
EASYRSA_EMAIL: "your@domain.tld"
EASYRSA_OU: "YourOrganizationUnit"
```

## Using hooks to expand the functionality ##
I also provide you some hooks. You can use them to expand the 
container without adding own commands to your docker-compose file 
or building a new image.

### How to use ###
The hooks provides you nearly unlimited freedom. You have to mount
a file (you can find the paths in the next section) to the container. 
This file should be a bash script. There you can add anything and call 
what you want.

#### pre-init hook ####
This hook will be executed before the openvpn initialization starts.

Path to mount: `/opt/kronovanet_docker/hook/pre_init.sh`

#### after-init hook ####
This hook will be executed after the openvpn initialization is finished and 
before the openvpn servers starts! You can modify the openvpn 
configurations or add your own configs and start them with this hook 
for example.
 
Path to mount: `/opt/kronovanet_docker/hook/after_init.sh`

## Example configuration for docker-compose ##
```
version: '2'
services:
    openvpn:
      image: pascal20997/openvpn
      container_name: kronova_openvpn
      volumes:
           - "./certs:/opt/certs"
      ports:
           - "1194:1194/udp"
           - "8080:443"
      restart: always
      privileged: true
      environment:
          OPENVPN_USER_1: "myname"
          OPENVPN_PASS_1: "mypass"
          EASYRSA_COUNTRY: "DE"
          EASYRSA__PROVINCE: "BW"
          EASYRSA_CITY: "Stuttgart"
          EASYRSA_ORG: "MyOrganization"
          EASYRSA_EMAIL: "your@domain.tld"
          EASYRSA_OU: "MyOrganizationUnit"
volumes:
    data:
      driver: local
```