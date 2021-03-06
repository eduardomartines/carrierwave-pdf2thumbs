module CarrierWave
  module Pdf2thumbs
    class Collector
      def initialize(input_path)
        @input_path = input_path
      end

      def thumbs
        fetch_thumbs
      end

      private

      THUMBS_FOLDER_REGEX = /\d+x\d*/

      def fetch_thumbs
        result = {}
        thumbs_folders.each do |folder|
          thumbs      = Dir[File.join(folder, "*")].sort_by { |item| item.to_s.split(/(\d+)/).map { |e| [e.to_i, e] } }
          key         = File.basename(folder)
          result[key] = thumbs
        end
        result
      end

      def thumbs_folders
        folders = Dir[File.join(dirname, "*")].select { |f| f =~ THUMBS_FOLDER_REGEX }
        folders.sort_by { |item| item.to_s.split(/(\d+)/).map { |e| [e.to_i, e] } }
      end

      def dirname
        Pathname.new(@input_path).dirname
      end
    end
  end
end
