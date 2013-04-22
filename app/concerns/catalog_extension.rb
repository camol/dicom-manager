module CatalogExtension
  extend ActiveSupport::Concern

  def create_root_catalog
    catalog_name = self.class.to_s == "User" ? full_name : name
    catalog_description = "Root catalog for #{catalog_name} (#{self.class.to_s})"
    id_of_creator = self.class.to_s == "User" ? self.id : current_user.id
    catalogs.create(name: catalog_name, description: catalog_description, creator_id: id_of_creator, updater_id: id_of_creator)
  end

  def root_catalog_id
    self.root_catalog.id
  end

  def label
    "#{name} (#{self.class.to_s})"
  end
end
