#!/usr/bin/env ruby

basedir = File.expand_path(File.dirname(__FILE__) + "/../")

require "tempfile"
require "find"

ENV["GEM_HOME"] = basedir + "/lib/vendor/gems/"
require "rubygems"

gem "mirah"
require 'mirah'

case ARGV.shift
  when "run"
    body = File.read(ARGV[0])
    imports = ""
    body.gsub!(/^\s*import .*/)  do |m| 
      imports << m+"\n"
      ""
    end
    template = File.read("#{basedir}/lib/templates/app.mr.template")
    content = template.sub(/@@BODY@@/, body).sub(/@@IMPORTS@@/, imports)

    classpath = ["#{basedir}/lib/templates"]
    Find.find(basedir + "/lib/vendor/processing") do |f|
      next unless test(?f, f) && f =~ /.jar$/
      classpath << f
    end

    Tempfile.open(%w{mp5 .mr}) do |tf|
      tf.write(content)
      tf.close
      system("cat #{tf.path}")
      Mirah.run("-c", classpath.join(":"), tf.path)
    end

  else
    puts "usage: mr5 run FILE"
    exit!
end
