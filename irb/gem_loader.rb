module IRB
  module GemLoader
    def self.setup
      if defined?(Bundler)
        # if using RBENV, use the next two lines
        gempath = `gem env gempath`
        global_gemset = nil

        if gempath && (/rbenv/ =~ gempath)
          # for RBENV user
          global_gemset = gempath.split(":").first
        else
          # for RVM user
          global_gemset = ( ENV["GEM_PATH"] || `rvm $(rvm current) do gem env path`.chop ).split(':').grep(/ruby.*@global/).first
        end

        # We make everything in the global gemset available, bypassing Bundler
        Dir["#{global_gemset}/gems/*"].each { |path| $LOAD_PATH << "#{path}/lib" } if global_gemset
      end
    end
    setup
  end

  def self.try_require(file)
    begin
      require file
      true
    rescue LoadError
      warn "=> Unable to load #{file}"
      false
    end
  end

end
