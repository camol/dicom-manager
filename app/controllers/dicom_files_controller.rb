class DicomFilesController < ApplicationController
  before_filter :load_dicom, except: [:create, :move]

  def create
    @dicom_file = current_catalog.dicom_files.new(params[:dicom_file])
    @dicom_file.save
    render json: [@dicom_file].to_json and return
  end

  def edit
  end

  def update
  end

  def move
    flash[:success] = params
    redirect_to current_catalog
  end

  def load_dicom
    @dicom = DicomFile.find(params[:id])
  end
end
