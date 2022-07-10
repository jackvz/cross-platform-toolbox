Vagrant.require_version ">= 1.1.0"

Vagrant.configure(2) do |config|
  config.ssh.shell = "sh"

  # Disable the base shared folder, Guest Tools supporting this feature are
  # unavailable for all providers.
  config.vm.synced_folder ".", "/vagrant", disabled: true
end
