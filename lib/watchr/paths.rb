module Watchr
  module Paths
    def self.expand_dirs_to_files *dirs
      extensions = ['rb']

      dirs.flatten.map { |p|
        if File.directory? p then
          Dir[File.join(p, '**', "*.{#{extensions.join(',')}}")]
        else
          p
        end
      }.flatten.sort
    end
  end
end
