desc "Install script for irbconfig using rbenv"
task :default do

  GEMS = %w(pry
            pry-doc
            pry-debugger
            pry-stack_explorer
            awesome_print
            gnuplot
            coderay
            colorize
            commands
            rails-env-switcher
            rspec-console
            cucumber-console
            mongoid-colors)

  status = system("which rbenv")
  unless status
    puts "You need to have a valid rbenv installation"
    exit
  end

  system("rbenv rehash")
  install_gems
  puts "Gems succesfully installed, enjoy!"
  link_files
end

private

def install_gems
  rubies.each do |ruby|
    # remove the extra './' prefix
    ruby.gsub!(/^\.\//,"")
    puts "run 'rbenv local #{ruby}'"
    system("rbenv local  #{ruby}")
    system("rbenv rehash")
    puts "Install rake gems for #{ruby}"
    gem_install("rake")
    gem_install(GEMS)
  end
end

def rubies
  rubies = []
  rbenv_root_dir = `env | grep RBENV_ROOT`.split('=')[1]
  unless rbenv_root_dir.nil? || rbenv_root_dir.strip!.empty?
    rubies = (`cd #{rbenv_root_dir}/versions; find . -type d -depth 1`).split("\n")
  end
  rubies
end

# install multiple gems
def gem_install(gems)
  gems.each do |gem|
    system("gem install #{gem}")
  end
end

require 'fileutils'

def link_files
  FileUtils.ln_sf("#{ENV['HOME']}/.irb/irbrc", "#{ENV['HOME']}/.irbrc")
  FileUtils.ln_sf("#{ENV['HOME']}/.irb/pryrc", "#{ENV['HOME']}/.pryrc")
end
