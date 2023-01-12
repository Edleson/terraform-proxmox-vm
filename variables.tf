##############################################################################
# Global variables
##############################################################################
variable "pm_vm_count" {
  type        = number
  description = "Count variable"
  default     = 1
  sensitive   = false
}

variable "pm_connection_type" {
  type        = string
  description = "Proxmox connection type. (REQUIRED when 'pm_enable_user_data = true')"
  default     = "ssh"
  sensitive   = false
}

variable "pm_ssh_user" {
  type        = string
  description = "Proxmox ssh user. (REQUIRED when 'pm_enable_user_data = true')"
  default     = null
  sensitive   = false
}

variable "pm_ssh_password" {
  type        = string
  description = "Proxmox ssh user password. (REQUIRED when 'pm_enable_user_data = true')"
  default     = null
  sensitive   = true
}

variable "pm_ssh_host" {
  type        = string
  description = "Proxmox ssh host. (REQUIRED when 'pm_enable_user_data = true')"
  default     = null
  sensitive   = false
}

#########################################################################################
# Arguments are supported in the Terraform Telmate Proxmox 
# === PROVIDER BLOCK ===
#########################################################################################
variable "pm_api_url" {
  type        = string
  description = "This is the target Proxmox API endpoint. REQUIRED(or use environment variable PM_API_URL)"
  default     = null
  sensitive   = false
}

variable "pm_user" {
  type        = string
  description = "The user, remember to include the authentication realm such as myuser@pam or myuser@pve. (OPTIONAL; or use environment variable PM_USER)"
  default     = null
  sensitive   = false
}

variable "pm_password" {
  type        = string
  description = " The password. (Optional; sensitive; or use environment variable PM_PASS)"
  default     = null
  sensitive   = true
}

variable "pm_api_token_id" {
  type        = string
  description = "This is an API token you have previously created for a specific user. (OPTIONAL; or use environment variable PM_API_TOKEN_ID) "
  default     = null
  sensitive   = false
}

variable "pm_api_token_secret" {
  type        = string
  description = "This uuid is only available when the token was initially created. (OPTIONAL; or use environment variable PM_API_TOKEN_SECRET)"
  default     = null
  sensitive   = true
}

variable "pm_otp" {
  type        = string
  description = " The 2FA OTP code. (Optional; or use environment variable PM_OTP)"
  default     = null
  sensitive   = false
}

variable "pm_tls_insecure" {
  type        = bool
  description = "Disable TLS verification while connecting to the proxmox server. Default: false"
  default     = true
  sensitive   = false
}

variable "pm_parallel" {
  type        = number
  description = "Allowed simultaneous Proxmox processes e.g: creating resources. (Optional; defaults to 4)"
  default     = 4
  sensitive   = false
}

variable "pm_log_enable" {
  type        = bool
  description = "Enable debug logging  (Optional; defaults to false)"
  default     = false
  sensitive   = false
}

variable "pm_log_levels" {
  description = "A map of log sources and levels."
  type = object({
    _default    = string
    _capturelog = string
  })
  default = {
    _default    = "DEBUG"
    _capturelog = ""
  }
}

variable "pm_log_file" {
  type        = string
  description = "If logging is enabled, the log file the provider will write logs to.  (Optional; defaults to 'terraform-plugin-proxmox.log')"
  default     = "terraform-proxmox.log"
  sensitive   = false
}

variable "pm_timeout" {
  type        = number
  description = " Timeout value (seconds) for proxmox API calls. (Optional; defaults to 300)"
  default     = 300
  sensitive   = false
}

variable "pm_debug" {
  type        = bool
  description = "Enable verbose output in proxmox-api-go"
  default     = false
  sensitive   = false
}
#########################################################################################
# User data 
# ** Cloud init**
#########################################################################################
variable "pm_enable_user_data" {
  type        = bool
  description = "Enable user data using cloud init provider"
  default     = false
  sensitive   = false
}

variable "pm_user_data_id" {
  type        = string
  description = "Proxmox cloud init unique identify. (REQUIRED when 'pm_enable_user_data = true')"
  default     = ""
  sensitive   = false
}

variable "pm_user_data_file" {
  type        = string
  description = "Path to cloud init file"
  default     = "user-data/cloud-init.yaml"
  sensitive   = false
}
#########################################################################################
# Arguments are supported in the Terraform Telmate Proxmox 
# ** Resource Block **
#########################################################################################
variable "create_vm" {
  type        = bool
  description = "Check for VM Creation"
  default     = true
  sensitive   = false
}

variable "name" {
  type        = string
  description = "The name of the VM within Proxmox. (REQUIRED)"
  default     = null
  sensitive   = false
}

variable "target_node" {
  type        = string
  description = "The name of the Proxmox Node on which to place the VM. (REQUIRED)"
  default     = null
  sensitive   = false
}

variable "vmid" {
  type        = number
  description = "The ID of the VM in Proxmox. The default value of 0 indicates it should use the next available ID in the sequence."
  default     = null
  sensitive   = false
}

variable "desc" {
  type        = string
  description = "The description of the VM. Shows as the 'Notes' field in the Proxmox GUI."
  default     = null
  sensitive   = false
}

variable "define_connection_info" {
  type        = bool
  description = "Whether to let terraform define the (SSH) connection parameters for preprovisioners, see config block below."
  default     = true
  sensitive   = false
}

variable "bios" {
  type        = string
  description = "Select BIOS implementation(ovmf | seabios). Default: seabios"
  default     = "seabios"
  sensitive   = false
}

variable "onboot" {
  type        = bool
  description = "Whether to have the VM startup after the PVE node starts."
  default     = true
  sensitive   = false
}

variable "oncreate" {
  type        = bool
  description = "Whether to have the VM startup after the VM is created."
  default     = true
  sensitive   = false
}

variable "tablet" {
  type        = bool
  description = "Enable/disable the USB tablet device. This device is usually needed to allow absolute mouse positioning with VNC."
  default     = true
  sensitive   = false
}

variable "boot" {
  type        = string
  description = "	The boot order for the VM. Ordered string of characters denoting boot order. Options: floppy (a), hard disk (c), CD-ROM (d), or network (n)."
  default     = "cdn"
  sensitive   = false
}

variable "bootdisk" {
  type        = string
  description = "Enable booting from specified disk(ide|sata|scsi|virtio). Sample: scsi0 or virtio0"
  default     = "scsi0"
  sensitive   = false
}

variable "agent" {
  type        = number
  description = "Set to 1 to enable the QEMU Guest Agent. Note, you must run the qemu-guest-agent daemon in the quest for this to have any effect."
  default     = 0
  sensitive   = false
}

variable "iso" {
  type        = string
  description = "The name of the ISO image to mount to the VM. Only applies when clone is not set. Either clone or iso needs to be set. Note that iso is mutually exclussive with clone and pxe modes."
  default     = null
  sensitive   = false
}

variable "pxe" {
  type        = bool
  description = "	If set to true, enable PXE boot of the VM. Also requires a boot order be set with Network first (eg boot = 'net0;scsi0'). Note that pxe is mutually exclussive with iso and clone modes."
  default     = false
  sensitive   = false
}

variable "clone" {
  type        = string
  description = "The base VM from which to clone to create the new VM. Note that clone is mutually exclussive with pxe and iso modes."
  default     = null
  sensitive   = false
}

variable "full_clone" {
  type        = bool
  description = "Set to true to create a full clone, or false to create a linked clone. Only applies when clone is set."
  default     = true
  sensitive   = false
}

variable "hastate" {
  type        = string
  description = "HA, you need to use a shared disk for this feature (ex: rbd)"
  default     = null
  sensitive   = false
}

variable "hagroup" {
  type        = string
  description = "	The HA group identifier the resource belongs to (requires hastate to be set!)."
  default     = null
  sensitive   = false
}

variable "qemu_os" {
  type        = string
  description = "Specify guest operating system. This is used to enable special optimization/features for specific operating systems. Default: l26"
  default     = "l26"
  sensitive   = false
}

variable "memory" {
  type        = number
  description = "Amount of RAM for the VM in MB. This is the maximum available memory when you use the balloon device. Default: 512"
  default     = 512
  sensitive   = false
}

variable "balloon" {
  type        = number
  description = "The minimum amount of memory to allocate to the VM in Megabytes, when Automatic Memory Allocation is desired. Proxmox will enable a balloon device on the guest to manage dynamic allocation."
  default     = 0
  sensitive   = false
}

variable "sockets" {
  type        = number
  description = "The number of CPU sockets to allocate to the VM."
  default     = 1
  sensitive   = false
}

variable "cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM."
  type        = number
  default     = 1
  sensitive   = false
}

variable "vcpus" {
  type        = number
  description = "The number of vCPUs plugged into the VM when it starts. If 0, this is set automatically by Proxmox to sockets * cores."
  default     = 0
  sensitive   = false
}

variable "cpu" {
  type        = string
  description = "Emulated CPU type. For best performance(homogeneous cluster where all nodes have the same CPU), set this to host. Default: host"
  default     = "host"
  sensitive   = false
}

variable "numa" {
  type        = bool
  description = "Enable/disable NUMA. Default: false"
  default     = true
  sensitive   = false
}

variable "hotplug" {
  type        = string
  description = "Selectively enable hotplug features. This is a comma separated list of hotplug features: network, disk, cpu, memory and usb. Default: network,disk,usb"
  default     = "disk,network,usb"
  sensitive   = false
}

variable "scsihw" {
  type        = string
  description = "SCSI controller model. (lsi | lsi53c810 | megasas | pvscsi | virtio-scsi-pci | virtio-scsi-single)"
  default     = "lsi"
  sensitive   = false
}

variable "pool" {
  type        = string
  description = "The resource pool to which the VM will be added."
  default     = null
  sensitive   = false
}

variable "tags" {
  type        = string
  description = "	Tags of the VM. This is only meta information."
  default     = null
  sensitive   = false
}

variable "force_create" {
  type        = bool
  description = "If false, and a vm of the same name, on the same node exists, terraform will attempt to reconfigure that VM with these settings. Set to true to always create a new VM (note, the name of the VM must still be unique, otherwise an error will be produced.)"
  default     = false
  sensitive   = false
}

variable "os_type" {
  type        = string
  description = "Which provisioning method to use, based on the OS type. Possible values: ubuntu, centos, cloud-init. For more detail Telmate vm_qemu.md"
  default     = "cloud-init"
  sensitive   = false
}

variable "force_recreate_on_change_of" {
  type        = string
  description = "Allows this to depend on another resource, that when changed, needs to re-create this vm. An example where this is useful is a cloudinit configuration (as the cicustom attribute points to a file not the content)"
  default     = null
  sensitive   = false
}

variable "os_network_config" {
  type        = string
  description = "Linux provisioning specific, /etc/network/interfaces for Ubuntu and /etc/sysconfig/network-scripts/ifcfg-eth0 for CentOS"
  default     = null
  sensitive   = false
}

variable "ssh_forward_ip" {
  type        = string
  description = "Address used to connect to the VM"
  default     = null
  sensitive   = false
}

variable "ssh_user" {
  type        = string
  description = "Username to login in the VM when preprovisioning"
  default     = null
  sensitive   = false
}

variable "ssh_private_key" {
  type        = string
  description = "Private key to login in the VM when preprovisioning"
  default     = null
  sensitive   = false
}

variable "ci_wait" {
  type        = number
  description = "Cloud-init specific, how to long to wait for preprovisioning. Default: 30"
  default     = 30
  sensitive   = false
}

variable "ciuser" {
  type        = string
  description = "Cloud-init specific, Overwrite image Default User"
  default     = null
  sensitive   = false
}

variable "cipassword" {
  type        = string
  description = "Cloud-init specific, Password to assign the user. Using this is generally not recommended. Use ssh keys instead"
  default     = null
  sensitive   = false
}

variable "cicustom" {
  type        = string
  description = "Cloud-init specific, location of the custom cloud-config files"
  default     = null
  sensitive   = false
}

variable "cloudinit_cdrom_storage" {
  type        = string
  description = "Set the storage location for the cloud-init drive. Required when specifying cicustom."
  default     = null
  sensitive   = false
}

variable "searchdomain" {
  type        = string
  description = "Cloud-init specific, sets DNS search domains for a container"
  default     = null
  sensitive   = false
}

variable "nameserver" {
  type        = string
  description = "Cloud-init specific, sets DNS server IP address for a container"
  default     = null
  sensitive   = false
}

variable "sshkeys" {
  type        = string
  description = "Setup public SSH keys (one key per line, OpenSSH format)"
  default     = null
  sensitive   = false
}

variable "ipconfig0" {
  type        = string
  description = "Cloud-init specific, Specify IP addresses and gateways for the corresponding interface. [gw=] [,gw6=] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]"
  default     = "ip=dhcp"
  sensitive   = false
}

variable "ipconfig1" {
  type        = string
  description = "Cloud-init specific, Specify IP addresses and gateways for the corresponding interface. [gw=] [,gw6=] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]"
  default     = "ip=dhcp"
  sensitive   = false
}

variable "ipconfig2" {
  type        = string
  description = "Cloud-init specific, Specify IP addresses and gateways for the corresponding interface. [gw=] [,gw6=] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]"
  default     = "ip=dhcp"
  sensitive   = false
}

variable "ipconfig3" {
  type        = string
  description = "Cloud-init specific, Specify IP addresses and gateways for the corresponding interface. [gw=] [,gw6=] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]"
  default     = "ip=dhcp"
  sensitive   = false
}

variable "ipconfig4" {
  type        = string
  description = "Cloud-init specific, Specify IP addresses and gateways for the corresponding interface. [gw=] [,gw6=] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]"
  default     = "ip=dhcp"
  sensitive   = false
}

variable "ipconfig5" {
  type        = string
  description = "Cloud-init specific, Specify IP addresses and gateways for the corresponding interface. [gw=] [,gw6=] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]"
  default     = "ip=dhcp"
  sensitive   = false
}

variable "automatic_reboot" {
  type        = bool
  description = "Automatically reboot the VM when parameter changes require this. If disabled the provider will emit a warning when the VM needs to be rebooted."
  default     = true
  sensitive   = false
}

/*
 ** memory :                - Sets the VGA memory (in MiB). Has no effect with serial display. (4 - 512)
 ** type   : Default: "std" - Set the VGA type (cirrus | none | qxl | qxl2 | qxl3 | qxl4 | serial0 | serial1 | serial2 | serial3 | std | virtio | vmware)
*/
variable "vga" {
  description = "Configure the VGA Hardware. Default(for type): std"
  type = list(object({
    type   = string
    memory = number
  }))
  default = [
    {
      type   = "std"
      memory = null
    }
  ]
}

/*
  ** model     : REQUIRED       - Network Card Model. The virtio model provides the best performance with very low CPU overhead
                                  If your guest does not support this driver, it is usually best to use e1000
                                  (e1000 | e1000-82540em | e1000-82544gc | e1000-82545em | i82551 | i82557b | i82559er | ne2k_isa |
                                   ne2k_pci | pcnet | rtl8139 | virtio | vmxnet3)
  ** macaddr   :                - A common MAC address with the I/G (Individual/Group) bit not set
  ** bridge    : Default: "nat" - However; The Proxmox VE standard bridge is called vmbr0. Bridge to attach the network device to
  ** tag       : Default: -1    - VLAN tag to apply to packets on this interface. (1 - 4094)
  ** firewall  : Default: false - Whether this interface should be protected by the firewall
  ** rate      :                - Rate limit in mbps (megabytes per second) as floating point number. (0 - N)
  ** queues    :                - Number of packet queues to be used on the device. (0 - 16)
  ** link_down :                - Whether this interface should be disconnected (like pulling the plug)
*/
variable "network" {
  description = "Specify network devices"
  type = list(object({
    model     = string
    macaddr   = string
    bridge    = string
    tag       = number
    firewall  = bool
    rate      = number
    queues    = number
    link_down = bool
  }))
  default = [
    {
      model     = "virtio"
      macaddr   = null
      bridge    = "vmbr0"
      tag       = -1
      firewall  = false
      rate      = 0
      queues    = 1
      link_down = false
    }
  ]
}

/*
  ** type        : REQUIRED        - Disk Type - (ide|sata|scsi|virtio)
  ** storage     : REQUIRED        - Target storage
  ** size        : REQUIRED        - Disk size. This is purely informational and has no effect
  ** format      :                 - Set the drive’s backing file’s data format (cloop | cow | qcow | qcow2 | qed | raw | vmdk)
  ** cache       : Default: "none" - Set the drive’s cache mode (directsync | none | unsafe | writeback | writethrough)
  ** backup      : Default: false  - Whether the drive should be included when making backups
  ** iothread    : Default: false  - Whether to use iothreads for this drive
  ** replicate   : Default: false  - Whether the drive should considered for replication jobs
  ** ssd         :                 - Whether to expose this drive as an SSD, rather than a rotational hard disk
  ** discard     :                 - Controls whether to pass discard/trim requests to the underlying storage
  ** mbps        : Default: 0      - Maximum r/w speed in megabytes per second
  ** mbps_rd     : Default: 0      - Maximum read speed in megabytes per second
  ** mbps_rd_max : Default: 0      - Maximum unthrottled read pool in megabytes per second
  ** mbps_wr     : Default: 0      - Maximum write speed in megabytes per second
  ** mbps_wr_max : Default: 0      - Maximum unthrottled write pool in megabytes per second
  ** file        :                 - The drive’s backing volume
  ** media       :                 - Set the drive’s media type (cdrom | disk)
  ** volume      :                 -
  ** slot        :                 -
*/
variable "disk" {
  description = "Specify disk variables"
  type = list(object({
    type        = string
    storage     = string
    size        = string
    format      = string
    cache       = string
    backup      = number
    iothread    = number
    replicate   = number
    ssd         = number
    discard     = string
    mbps        = number
    mbps_rd     = number
    mbps_rd_max = number
    mbps_wr     = number
    mbps_wr_max = number
    file        = string
    media       = string
    volume      = string
    slot        = number
  }))
  default = [
    {
      type        = "scsi"
      storage     = "standard-ssd"
      size        = "32G"
      format      = "qcow2"
      cache       = "none"
      backup      = 0
      iothread    = 0
      replicate   = 0
      ssd         = 0
      discard     = null
      mbps        = 0
      mbps_rd     = 0
      mbps_rd_max = 0
      mbps_wr     = 0
      mbps_wr_max = 0
      file        = null
      media       = "disk"
      volume      = null
      slot        = null
    }
  ]
}

/*
 ** id     : REQUIRED - ID is 0 to 3
 ** type   : REQUIRED - socket
*/
variable "serial" {
  description = "Create a serial device inside the VM. Serial interface of type socket is used by xterm.js. Using a serial device as terminal"
  type = object({
    id   = number
    type = string
  })
  default = {
    id   = 0
    type = "socket"
  }
}

variable "proxmox_vm_depends_on" {
  type    = any
  default = []
  description = "Depends_on variable"
}