
Gem::Specification.new do |spec|
  spec.name          = "kitchen-kvm-custom"
  spec.version       = "0.1.0"
  spec.authors       = ["Ankit Soni"]
  spec.email         = ["ankit.soni@progress.com"]

  spec.summary       = "A custom Test Kitchen driver for KVM"
  spec.description   = "This driver enables Test Kitchen to create and manage KVM-based VMs."
  spec.homepage      = "https://github.com/your-repo/kitchen-kvm-custom"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "test-kitchen", ">= 3.0"
  spec.add_dependency "chef"
  spec.add_dependency "chef-config"
  spec.add_dependency "kitchen-sync"
end

