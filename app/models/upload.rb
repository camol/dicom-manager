require 'zip/zip'

class Upload

  def self.zip(files, name)
    archive = File.join(name) + ".zip"
    unless File.exist? archive
      Zip::ZipFile.open(archive, 'w') do |zip_file|
        files.each do |file|
          zip_file.add(file.dicom_file_name,file.dicom.path)
        end
      end
    end
    archive
  end

  def self.unzip(file)

  end

end
