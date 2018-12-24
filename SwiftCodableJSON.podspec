Pod::Spec.new do |s|
  s.name = 'SwiftCodableJSON'
  s.version = '0.0.1'
  s.summary = 'JSON in Swift - the way it should be'
  s.description = <<-DESC
  Simplify the way that you use JSON objects.
                   DESC

  s.homepage = 'https://github.com/guykogus/SwiftCodableJSON'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { 'Guy Kogus' => 'guy.kogus@gmail.com' }
  s.documentation_url = 'http://www.json.org'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.swift_version = '4.2'
  s.source = { git: 'https://github.com/guykogus/SwiftCodableJSON', tag: s.version.to_s }
  s.source_files = 'SwiftCodableJSON/*.swift'
end
