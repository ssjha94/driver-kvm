require "kitchen"
require "kitchen/driver/base"
require "open3"

module Kitchen
  module Driver
    class KvmCustom < Kitchen::Driver::Base
      default_config :memory, 1024
      default_config :cpus, 1
      default_config :image, "/var/lib/libvirt/images/ubuntu-vm1.qcow2"
      default_config :cdrom, "/var/lib/libvirt/images/ubuntu-20.04.iso"
      default_config :network, "default"
      default_config :graphics, "vnc"

      def create(state)
        vm_name = config[:instance_name] || instance.name
        cmd = <<-EOC
          sudo virt-install --name=#{vm_name} \
          --memory=#{config[:memory]} \
          --vcpus=#{config[:cpus]} \
          --disk path=#{config[:image]},size=10 \
          --os-variant=ubuntu20.04 \
          --cdrom=#{config[:cdrom]} \
          --network=#{config[:network]} \
          --graphics=#{config[:graphics]} \
          --noautoconsole
        EOC

        run_command(cmd)
        state[:hostname] = vm_name
      end

      def destroy(state)
        vm_name = state[:hostname]
        return if vm_name.nil?

        run_command("virsh destroy #{vm_name}")
        run_command("virsh undefine #{vm_name}")
      end
    end
  end
end

