require 'spec_helper'
describe 'check_mk::install', type: :class do
  context 'with necessary parameters set' do
    let :params do
      {
        filestore: false,
        package: 'package',
        site: 'site',
        workspace: 'workspace'
      }
    end

    it { is_expected.to contain_class('check_mk::install') }
    it { is_expected.to contain_package('package').with_ensure('installed').that_comes_before('Exec[omd-create-site]') }
    it {
      is_expected.to contain_exec('omd-create-site').with(command: '/usr/bin/omd create site',
                                                          creates: '/omd/sites/site/etc')
    }
  end
end
