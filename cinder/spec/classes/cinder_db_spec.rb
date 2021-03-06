require 'spec_helper'

describe 'cinder::db' do

  shared_examples 'cinder::db' do

    context 'with default parameters' do

      it { is_expected.to contain_cinder_config('database/connection').with_value('sqlite:////var/lib/cinder/cinder.sqlite').with_secret(true) }
      it { is_expected.to contain_cinder_config('database/idle_timeout').with_value('<SERVICE DEFAULT>') }
      it { is_expected.to contain_cinder_config('database/min_pool_size').with_value('<SERVICE DEFAULT>') }
      it { is_expected.to contain_cinder_config('database/max_retries').with_value('<SERVICE DEFAULT>') }
      it { is_expected.to contain_cinder_config('database/retry_interval').with_value('<SERVICE DEFAULT>') }

    end

    context 'with specific parameters' do
      let :params do
        { :database_connection     => 'mysql://cinder:cinder@localhost/cinder',
          :database_idle_timeout   => '3601',
          :database_min_pool_size  => '2',
          :database_max_retries    => '11',
          :database_retry_interval => '11', }
      end

      it { is_expected.to contain_cinder_config('database/connection').with_value('mysql://cinder:cinder@localhost/cinder').with_secret(true) }
      it { is_expected.to contain_cinder_config('database/idle_timeout').with_value('3601') }
      it { is_expected.to contain_cinder_config('database/min_pool_size').with_value('2') }
      it { is_expected.to contain_cinder_config('database/max_retries').with_value('11') }
      it { is_expected.to contain_cinder_config('database/retry_interval').with_value('11') }

    end

    context 'with incorrect database_connection string' do
      let :params do
        { :database_connection     => 'redis://cinder:cinder@localhost/cinder', }
      end

      it_raises 'a Puppet::Error', /validate_re/
    end

  end

  context 'on Debian platforms' do
    let :facts do
      @default_facts.merge!({ :osfamily => 'Debian' })
    end

    it_configures 'cinder::db'
  end

  context 'on Redhat platforms' do
    let :facts do
      @default_facts.merge!({ :osfamily => 'RedHat' })
    end

    it_configures 'cinder::db'
  end

end
