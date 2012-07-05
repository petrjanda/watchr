module Watchr
  module Paths
    def self.files_by_dirs *dirs
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
