# Usage
```
docker-compose up
```
Port 8993 for ddf1 and ddf2 are mapped to 1993 & 2993 respectively. Use these to access each one directly (for installation and such)

Port 8993 for the haproxy is mapped to 8993, use this to access ddf1 & ddf2 through the loadbalancer.

# Default Setup

The haproxy loadbalancer will route all traffic to ddf1. If ddf1 goes down, then all traffic goes to ddf2 until it goes back up.
This means haproxy is acting strictly as a failover instead of a proper loadbalancing, which should suit out HA testing needs.

# Configuring

The configuration file used for the haproxy instance can be found at `nodes/haproxy/haproxy.cfg`.

The `backup` option listed next to ddf2's server line under the `backend ddfs` section is what causes this failover-only behavior. Servers marked
with backup will only be used if all non-backup servers go down first. Removing the word `backup` from this line will cause the haproxy to act as
a regular loadbalancer. It will still failover properly and mark each server as unavailable if it goes down, but all traffic will be routed to
each server according to the loabalancing method specified in the `balance` line under `backend ddfs` (set to roundrobin by defualt).

> Note that since the configuration file uses SSL passthrough by default, modifying the failover behavior to use loadbalancing will cause
> each packet sent to be routed individually according to the loadbalancing method specified. For example, if round robin is used, every packet sent
> will be sent back and forth to each backend server. Since it uses a TCP connection, it should work, but would be very slow as each packet sent to
> the wrong server will have to be retransmitted.

# Client-Server Stickiness

The file `nodes/haproxy/haproxy-sticky.cfg` contains an example setup using SSL Session ID stick-table. Rename this file to `haproxy.cfg` and rename the default `haproxy.cfg` file to use this load-balanced setup instead of the default failover-only setup.