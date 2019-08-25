#!/usr/bin/env bash

##
# consul config
##
echo '{
  "datacenter": "us-east-1",
  "bootstrap_expect": ${bootstrap-expect},
  "retry_join": [
    "provider=aws tag_key=consul tag_value=scheduler addr_type=private_v4"
  ],
  "bind_addr": "__BIND_ADDR__",
  "autopilot": {
    "cleanup_dead_servers": true,
    "last_contact_threshold": "200ms",
    "max_trailing_logs": 250,
    "server_stabilization_time": "10s"
  }
}' > /etc/consul.d/10-aws.json

BIND_ADDR=$(curl http://169.254.169.254/latest/meta-data/local-ipv4/)
sed -i "s/__BIND_ADDR__/$${BIND_ADDR}/g" /etc/consul.d/10-aws.json

echo '{
  "ui": true
}' > /etc/consul.d/20-ui.json

echo '{
  "enable_syslog": true,
  "log_level": "INFO"
}' > /etc/consul.d/30-logging.json

##
# vault config
##
echo '{
  "storage": {
    "consul": {
      "address": "127.0.0.1:8500",
      "path": "vault/"
    }
  }
}' > /etc/vault.d/01-consul.json

echo '{
  "seal": {
    "awskms": {
      "region": "us-east-1",
      "kms_key_id": "${vault-seal-awskms-kms_key_id}"
    }
  }
}' > /etc/vault.d/10-aws.json

echo '{
  "ui": true
}' > /etc/vault.d/20-ui.json

##
# nomad config
##
echo '{
  "consul": {
    "address": "127.0.0.1:8500",
    "auto_advertise": true,
    "server_service_name": "nomad",
    "server_auto_join": true,
    "client_service_name": "nomad-client",
    "client_auto_join": true
  },
  "datacenter": "us-east-1",
  "region": "us-east-1"
}' > /etc/nomad.d/01-consul.json

echo '{
  "server": {
    "bootstrap_expect": 3
  },
  "leave_on_terminate": true
}' > /etc/nomad.d/10-aws.json

echo '{
  "enable_syslog": true,
  "log_level": "INFO"
}' > /etc/nomad.d/30-logging.json

echo '{
  "acl": {
    "enabled": true,
    "token_ttl": "30s",
    "policy_ttl": "60s"
  }
}' > /etc/nomad.d/40-acl.json

##
# restart services
##
systemctl restart dnsmasq
systemctl restart consul
systemctl restart vault
systemctl restart nomad
