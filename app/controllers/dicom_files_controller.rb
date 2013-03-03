class DicomFilesController < ApplicationController

  def create
    debugger
    @dicom_file = current_catalog.dicom_files.new(params[:dicom_file])
    if @dicom_file.save
      redirect_to catalogs_path
    else
      redirect_to root_path
    end
  end
end
