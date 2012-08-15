module Watchr
  module Paths
    def self.files_by_dirs(extensions, *dirs)
      dirs.flatten.map { |dir|
        if File.directory?(dir) then
          Dir[File.join(dir, '**', "*.{#{extensions.join(',')}}")]
        else
          dir
        end
      }.flatten.sort
    end
  end
end
