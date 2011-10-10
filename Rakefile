require 'rake'

desc 'Build and install gem'
task :install => :build do
  sh "gem install #{Dir.glob('*.gem').join(' ')} --no-ri --no-rdoc"
end

desc 'Uninstall gem'
task :uninstall do
  sh "gem uninstall -x ruby-processing"
end

task :build do
  sh "cd vendors && rake"
  sh "gem build ruby-processing.gemspec"
end

desc "compile wrapper .java class"
task :compile do
  sh "javac -cp lib/vendor/processing/core.jar lib/templates/MP5Applet.java"
end

task :default => [:build, :compile]
