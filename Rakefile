require File.dirname(__FILE__) + '/lib/maitre_d/gems'

MaitreD::Gems.activate %w(rake rspec)

require 'rake'

begin
  require 'spec/rake/spectask'
rescue Exception => e
end

def gemspec
  @gemspec ||= begin
    file = File.expand_path('../maitre_d.gemspec', __FILE__)
    eval(File.read(file), binding, file)
  end
end

if defined?(ActiveWrapper::Tasks)
  ActiveWrapper::Tasks.new(
    :base => File.dirname(__FILE__),
    :env => ENV['ENV']
  )
end

if defined?(Spec::Rake::SpecTask)
  desc "Run specs"
  Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts = %w(-fs --color)
    t.warning = true
  end
  task :spec
  task :default => :spec
end

desc "Build gem(s)"
task :gem do
  old_gemset = ENV['GEMSET']
  root = File.expand_path('../', __FILE__)
  pkg = "#{root}/pkg"
  system "rm -Rf #{pkg}"
  MaitreD::Gems.gemset_names.each do |gemset|
    ENV['GEMSET'] = gemset.to_s
    system "cd #{root} && gem build maitre_d.gemspec"
    system "mkdir -p #{pkg} && mv *.gem pkg"
  end
  ENV['GEMSET'] = old_gemset
end

namespace :gem do
  desc "Install gem(s)"
  task :install do
    Rake::Task['gem'].invoke
    Dir["#{File.dirname(__FILE__)}/pkg/*.gem"].each do |pkg|
      system "gem install #{pkg} --no-ri --no-rdoc"
    end
  end
  
  desc "Push gem(s)"
  task :push do
    Rake::Task['gem'].invoke
    Dir["#{File.dirname(__FILE__)}/pkg/*.gem"].each do |pkg|
      system "gem push #{pkg}"
    end
  end
end

namespace :gems do
  desc "Install gem dependencies (DEV=0 DOCS=0 GEMSPEC=default SUDO=0)"
  task :install do
    dev = ENV['DEV'] == '1'
    docs = ENV['DOCS'] == '1' ? '' : '--no-ri --no-rdoc'
    gemset = ENV['GEMSET']
    sudo = ENV['SUDO'] == '1' ? 'sudo' : ''
    
    MaitreD::Gems.gemset = gemset if gemset
    
    if dev
      gems = MaitreD::Gems.gemspec.development_dependencies
    else
      gems = MaitreD::Gems.gemspec.dependencies
    end
    
    gems.each do |name|
      name = name.to_s
      version = MaitreD::Gems.versions[name.to_sym]
      if Gem.source_index.find_name(name, version).empty?
        version = version ? "-v #{version}" : ''
        system "#{sudo} gem install #{name} #{version} #{docs}"
      else
        puts "already installed: #{name} #{version}"
      end
    end
  end
end

desc "Validate the gemspec"
task :gemspec do
  gemspec.validate
end