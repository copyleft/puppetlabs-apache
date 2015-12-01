require 'spec_helper_acceptance'

case fact('osfamily')
when 'RedHat'
  servicename = 'httpd'
when 'Debian'
  servicename = 'apache2'
when 'FreeBSD'
  servicename = 'apache24'
when 'Gentoo'
  servicename = 'apache2'
end

case fact('osfamily')
when 'FreeBSD'
  describe 'apache::mod::event class' do
    describe 'running puppet code' do
      # Using puppet_apply as a helper
      it 'should work with no errors' do
        pp = <<-EOS
          class { 'apache':
            mpm_module => 'event',
          }
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
      end
    end

    describe service(servicename) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
end

describe 'apache::mod::worker class' do
  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'apache':
          mpm_module => 'worker',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

  describe service(servicename) do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end

describe 'apache::mod::prefork class' do
  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'apache':
          mpm_module => 'prefork',
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

  describe service(servicename) do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
