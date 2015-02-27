Pod::Spec.new do |s|
  s.name     = 'DTFUpgrader'
  s.version  = '1.0.1'
  s.ios.deployment_target   = '7.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'iOS Library to assist with application upgrades'
  s.homepage = 'https://github.com/darren102/DTFUpgrader'
  s.author   = { 'Darren Ferguson' => 'darren102@gmail.com' }
  s.requires_arc = true
  s.source   = {
    :git => 'https://github.com/darren102/DTFUpgrader.git',
    :branch => 'master',
    :tag => s.version.to_s
  }
  s.source_files = 'DTFUpgrader/*.{h,m}'
  s.public_header_files = 'DTFUpgrader/DTFUpgrader.h', 'DTFUpgrader/DTFUpgraderManager.h', 'DTFUpgrader/DTFUpgraderError.h'
end
