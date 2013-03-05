class DicomFilesController < ApplicationController

  def create
    @dicom_file = current_catalog.dicom_files.new(params[:dicom_file])
    @dicom_file.save
    render json: [@dicom_file].to_json and return
  end

  def show
    @dicom = DicomFile.find(params[:id])
  end
end
