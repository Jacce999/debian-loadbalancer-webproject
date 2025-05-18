# Debian Loadbalancer Web Project

This project demonstrates a simple NGINX load balancer setup using two Debian-based web servers.

## Structure

- `loadbalancer/`: Contains the NGINX configuration (`default`)
- `web1/`: HTML content for ProSales
- `web2/`: HTML content for Rörfixarna AB

## Usage

- Web1 and Web2 both serve similar HTML content to ensure load balancing does not cause 404s.
- NGINX forwards traffic in a round-robin fashion.