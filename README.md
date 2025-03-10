# Driver KVM
# Kitchen-QEMU Driver for Test Kitchen 

This repository provides a **QEMU driver** for **Test Kitchen**, allowing you to create and manage virtual machines using **KVM/QEMU**.

Note: We assume you are installing this on an Ubuntu machine. If you are using a different OS, please adjust the commands and download the appropriate images accordingly.

## Prerequisites

Ensure you have a **Chef Workstation** machine or install **chef-workstation**.

### Install Required Packages
Run the following commands to install necessary packages for KVM/QEMU:

sudo apt update && sudo apt upgrade
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils


Check if your system supports KVM:

kvm-ok

Add your user to the `libvirt` group:

sudo usermod -aG libvirt $(whoami)
newgrp libvirt


Enable and start the libvirt service:

sudo systemctl enable --now libvirtd


## Download Ubuntu ISO
Download the Ubuntu Server ISO and move it to the required location:


wget -O ubuntu-20.04.iso https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso
sudo mv /home/ubuntu/ubuntu-20.04.iso /var/lib/libvirt/images/


## Create a VM Disk Image
Create a **qcow2** disk image for your VM:


sudo qemu-img create -f qcow2 /var/lib/libvirt/images/ubuntu-vm.qcow2 10G


## Configure Cloud-Init
Cloud-Init allows us to automate initial VM configuration (user creation, SSH setup, etc.).

### Create "user-data"
This file contains user credentials and SSH key configuration:


#cloud-config
users:
  - name: ubuntu
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    groups: sudo
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC  # Replace with your id_rsa.pub
chpasswd:
  list: |
    ubuntu:{password}
  expire: false


### Create "meta-data"
This file contains VM metadata:

instance-id: ubuntu-vm
local-hostname: ubuntu-vm


### Generate Cloud-Init ISO
Combine "user-data" and "meta-data" into an ISO image:


genisoimage -output cloud-init.iso -volid cidata -joliet -rock user-data meta-data


Move the ISO to the correct location:

sudo mv cloud-init.iso /var/lib/libvirt/images/


## Running the Kitchen-QEMU Driver
Once the above setup is complete, you can use **Test Kitchen** with the QEMU driver to create and manage your virtual machines.

---

This guide provides a structured approach to setting up KVM/QEMU for Test Kitchen, ensuring smooth VM provisioning and configuration using **Cloud-Init**.



