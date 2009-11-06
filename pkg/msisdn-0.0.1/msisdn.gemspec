# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{msisdn}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Armand du Plessis"]
  s.date = %q{2009-11-06}
  s.description = %q{Basic msisdn processing and parsing}
  s.email = ["armanddp@agilisto.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "config/hoe.rb", "lib/msisdn.rb", "msisdn.gemspec", "script/console", "script/destroy", "script/generate", "test/test_helper.rb", "test/test_msisdn.rb"]
  s.homepage = %q{http://github.com/armanddp/msisdn}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{msisdn}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Basic msisdn processing and parsing}
  s.test_files = ["test/test_helper.rb", "test/test_msisdn.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
