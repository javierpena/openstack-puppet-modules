Puppet::Type.type(:neutron_agent_linuxbridge).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def file_path
    if Facter['operatingsystem'].value == 'Ubuntu'
      '/etc/neutron/plugins/ml2/ml2_conf.ini'
    else
      '/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini'
    end
  end

end
