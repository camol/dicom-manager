class DicomInfo < ActiveRecord::Base
  attr_protected

  belongs_to :dicom_file

  INFO_HASH = {
    instance_creation_date:   '0008,0012',
    instance_creation_time:   '0008,0013',
    study_date:               '0008,0020',
    study_time:               '0008,0030',
    institution_name:         '0008,0080',
    referring_physician_name: '0008,0090',
    patients_name:            '0010,0010',
    patient_id:               '0010,0020',
    patient_birth_date:       '0010,0030',
    patient_sex:              '0010,0040',
    image_comments:           '0020,4000',
    sop_instance_uid:         '0008,0018'
  }
end
