terraform {
  required_version = ">= 1.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.42.1"
    }
  }
}

locals {
  ssh_config = <<-EOF
    Port 4322
        AddressFamily any
        ListenAddress 0.0.0.0
        ListenAddress ::
        Protocol 2
        HostKey /etc/ssh/ssh_host_rsa_key
        HostKey /etc/ssh/ssh_host_dsa_key
        HostKey /etc/ssh/ssh_host_ecdsa_key
        SyslogFacility AUTH
        LogLevel INFO
        LoginGraceTime 2m
        StrictModes yes
        MaxAuthTries 6
        MaxSessions 10
        PubkeyAuthentication yes
        AuthorizedKeysFile .ssh/authorized_keys
        AuthorizedPrincipalsFile none
        HostbasedAuthentication no
        IgnoreUserKnownHosts no
        IgnoreRhosts yes
        PasswordAuthentication no
        ChallengeResponseAuthentication no
        KerberosAuthentication no
        KerberosOrLocalPasswd yes
        KerberosTicketCleanup yes
        GSSAPIAuthentication no
        GSSAPICleanupCredentials yes
        UsePAM yes
        AllowAgentForwarding yes
        AllowTcpForwarding yes
        GatewayPorts no
        X11Forwarding no
        X11DisplayOffset 10
        X11UseLocalhost yes
        PrintMotd no
        PrintLastLog yes
        TCPKeepAlive yes
        PermitUserEnvironment yes
        Compression yes
        ClientAliveInterval 120
        ClientAliveCountMax 300
        UseDNS yes
        PidFile /run/sshd.pid
        MaxStartups 10:30:100
        PermitTunnel no
        ChrootDirectory none
        VersionAddendum none
        Banner none
        Subsystem sftp /usr/lib/sftp-server
        PermitEmptyPasswords yes
        PermitRootLogin yes
        AllowUsers admin root
  EOF

  cloud_init_config = {
    users = [
      {
        name                = "admin"
        ssh_authorized_keys = []
        sudo                = "ALL=(ALL) NOPASSWD:ALL"
        groups              = "sudo, docker"
        shell               = "/bin/bash"
      },
      {
        name                = "root"
        ssh_authorized_keys = []
        shell               = "/bin/bash"
      }
    ]
    package_update = true
    ssh_pwauth     = true
    chpasswd = {
      expire = false
      users = [
        {
          name     = "admin"
          password = ""
        },
        {
          name     = "root"
          password = ""
        }
      ]
    }
    timezone                  = "UTC"
    locale                    = "en_US.UTF-8"
    preserve_hostname         = false
    hostname                  = "server1"
    fqdn                      = "server1.example.com"
    prefer_fqdn_over_hostname = false
    manage_etc_hosts          = true

    write_files = [
      {
        path    = "/etc/ssh/sshd_config"
        content = local.ssh_config
      }
    ]
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

module "hetzner_server_example" {
  source = "../../modules/compute"

  name     = "exmaple-server"
  type     = "cpx11"
  image    = "ubuntu-22.04"
  location = "nbg1"

  networking = {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  cloud_init = {
    gzip          = true
    base64_encode = true

    config = local.cloud_init_config
  }
}
