require 'puppet/provider/package'

Puppet::Type.type(:package).provide(:brew, :parent => Puppet::Provider::Package) do
  desc "Package management using HomeBrew on OS X"

  confine  :operatingsystem => :darwin

  has_feature :versionable
  has_feature :install_options

  commands :brew => "/usr/local/bin/brew"

  def brew *args
    uid = `stat -f '%u %Su' /dev/console`.split(' ').first
    Puppet::Util::Execution.execute args.unshift('/usr/local/bin/brew'), :uid => uid, :gid => 20
  end

  # Install packages, known as formulas, using brew.
  def install
    should = @resource[:ensure]
    opts = @resource[:install_options] ? @resource[:install_options].flatten.first : {}

    package_name = @resource[:name]
    case should
    when true, false, Symbol
      # pass
    else
      package_name += "-#{should}"
    end

    if opts['flags']
      output = brew :install, opts['flags'], package_name
    else
      output = brew :install, package_name
    end

    # Fail hard if there is no formula available.
    if output =~ /Error: No available formula/i
      raise Puppet::ExecutionFailure, "Could not find package #{@resource[:name]}"
    end
  end

  def uninstall
    brew(:uninstall, @resource[:name])
  end

  def update
    self.install
  end

  def query
    self.class.package_list(:justme => resource[:name])
  end

  def latest
    hash = self.class.package_list(:justme => resource[:name])
    hash[:ensure]
  end

  def self.package_list(options={})
    brew_list_command = [command(:brew), "list", "--versions"]

    if name = options[:justme]
      brew_list_command << name
    end

    begin
      # command = brew_list_command.flatten.map(&:to_s).join(' ')
      # list = `#{command}`.lines.map {|line| name_version_split(line) }

      list = execute(brew_list_command).lines.map {|line| name_version_split(line) }
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list packages: #{detail}"
    end

    if options[:justme]
      return list.shift
    else
      return list
    end
  end

  def self.name_version_split(line)
    if line =~ (/^(\S+)\s+(.+)/)
      name = $1
      version = $2
      {
        :name     => name,
        :ensure   => version,
        :provider => :brew
      }
    else
      Puppet.warning "Could not match #{line}"
      nil
    end
  end

  def self.instances(justme = false)
    package_list.collect { |hash| new(hash) }
  end
end
