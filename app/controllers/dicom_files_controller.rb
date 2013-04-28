class DicomFilesController < ApplicationController
  before_filter :load_dicom, except: [:create, :manage]

  def create
    p params
    @dicom_file = current_catalog.dicom_files.new(params[:dicom_file])
    @dicom_file.save
    render json: [@dicom_file].to_json and return
  end

  def edit
  end

  def update
  end

  def manage
    files_ids = params[:dicom_files][:files].split(',')
    target = params[:dicom_files][:target_catalog]
    dicoms = DicomFile.where(id: files_ids)

    case params[:commit]
    when "Delete"
      if dicoms.destroy_all
        message_type = :success
        message = "Files deleted"
      else
        message_type = :error
        message = "Error on deleting files"
      end
    when "Move"
      if dicoms.update_all(catalog_id: target)
        message_type = :success
        message = "Files moved"
      else
        message_type = :error
        message = "Error on moving files"
      end
    when "Download"
      unless dicoms.empty?
        file_name = current_catalog.name.squish.downcase.tr(" ","_")
        send_file Upload.zip(dicoms, file_name), type: "application/zip", disposition: "attachement", filename: file_name
      end
    end

    unless params[:commit] == "Download"
      flash[message_type] = message
      redirect_to current_catalog
    end
  end

  def load_dicom
    @dicom = DicomFile.find(params[:id])
  end
end
