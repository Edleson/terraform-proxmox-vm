terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "2.9.6"
        }
    }
}

provider "proxmox" {
    pm_api_url          = var.pm_api_url
    pm_user             = var.pm_user
    pm_password         = var.pm_password
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret
    pm_otp              = var.pm_otp 
    pm_tls_insecure     = var.pm_tls_insecure
    pm_parallel         = var.pm_parallel
    pm_log_enable       = var.pm_log_enable
    pm_log_levels       = var.pm_log_levels
    pm_log_file         = var.pm_log_file
    pm_timeout          = var.pm_timeout
    pm_debug            = var.pm_debug
}

resource "null_resource" "cloud_init_config_files" {
    count = var.pm_enable_user_data ? 1 : 0
    connection {
        type     = var.pm_connection_type
        user     = var.pm_ssh_user
        password = var.pm_ssh_password
        host     = var.pm_ssh_host
    }

    provisioner "file" {
        source      = var.pm_user_data_file
        destination = "/var/lib/vz/snippets/${var.pm_user_data_id}.yml"
    }
}

resource "proxmox_vm_qemu" "server" {
    

    count                           = var.create_vm ? 1 : 0
    name                            = var.name 
    target_node                     = var.target_node
    vmid                            = var.vmid
    desc                            = var.desc
    define_connection_info          = var.define_connection_info
    bios                            = var.bios
    onboot                          = var.onboot
    oncreate                        = var.oncreate
    tablet                          = var.tablet
    boot                            = var.boot
    bootdisk                        = var.bootdisk
    agent                           = var.agent
    iso                             = var.iso
    # pxe                             = var.pxe
    clone                           = var.clone
    full_clone                      = var.full_clone
    hastate                         = var.hastate
    hagroup                         = var.hagroup
    qemu_os                         = var.qemu_os
    memory                          = var.memory
    balloon                         = var.balloon
    sockets                         = var.sockets
    cores                           = var.cores
    vcpus                           = var.vcpus
    cpu                             = var.cpu
    numa                            = var.numa
    hotplug                         = var.hotplug
    scsihw                          = var.scsihw
    pool                            = var.pool
    tags                            = var.tags
    force_create                    = var.force_create
    os_type                         = var.os_type
    force_recreate_on_change_of     = var.force_recreate_on_change_of
    os_network_config               = var.os_network_config
    ssh_forward_ip                  = var.ssh_forward_ip
    ssh_user                        = var.ssh_user
    ssh_private_key                 = var.ssh_private_key
    ci_wait                         = var.ci_wait
    ciuser                          = var.ciuser
    cipassword                      = var.cipassword
    cicustom                        = var.pm_enable_user_data ? "user=local:snippets/${var.pm_user_data_id}.yml" : null
    cloudinit_cdrom_storage         = var.cloudinit_cdrom_storage
    searchdomain                    = var.searchdomain
    nameserver                      = var.nameserver
    ipconfig0                       = var.ipconfig0
    ipconfig1                       = var.ipconfig1
    ipconfig2                       = var.ipconfig2
    ipconfig3                       = var.ipconfig3
    ipconfig4                       = var.ipconfig4
    ipconfig5                       = var.ipconfig5
    automatic_reboot                = var.automatic_reboot
    sshkeys                         = var.sshkeys

    dynamic "vga" {
        for_each = var.vga
        content {
            type   = vga.value.type
            memory = vga.value.memory
        }
    }

    dynamic "network" {
        for_each = var.network
        content {
            model     = network.value.model
            macaddr   = network.value.macaddr
            bridge    = network.value.bridge
            tag       = network.value.tag
            firewall  = network.value.firewall
            rate      = network.value.rate
            queues    = network.value.queues
            link_down = network.value.link_down
        }
    }
    
    dynamic "disk" {
        for_each = var.disk
        content {
            type        = disk.value.type
            storage     = disk.value.storage
            size        = disk.value.size
            format      = disk.value.format
            cache       = disk.value.cache
            backup      = disk.value.backup
            iothread    = disk.value.iothread
            replicate   = disk.value.replicate
            ssd         = disk.value.ssd
            discard     = disk.value.discard
            mbps        = disk.value.mbps
            mbps_rd     = disk.value.mbps_rd
            mbps_rd_max = disk.value.mbps_rd_max
            mbps_wr     = disk.value.mbps_wr
            mbps_wr_max = disk.value.mbps_wr_max
            file        = disk.value.file
            # media       = disk.value.media
            volume      = disk.value.volume
            slot        = disk.value.slot
        }
    }
    
    dynamic "serial" {
        for_each = var.serial
        content {
            id   = var.serial.id
            type = var.serial.type
        }
    }

    # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
    # lifecycle {
    #     ignore_changes = [
    #         network,
    #     ]
    # }

    depends_on = concat(
        var.proxmox_vm_depends_on,
        [null_resource.cloud_init_config_files]
    )

}