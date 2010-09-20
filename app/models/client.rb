class Client < ActiveRecord::Base
  has_many :galleries,  :dependent => :delete_all
  has_many :folders,    :dependent => :delete_all
  has_many :pages,      :dependent => :delete_all
  has_many :parts,      :dependent => :delete_all
  has_many :groups,     :dependent => :delete_all
  accepts_nested_attributes_for :parts, :allow_destroy => true
  
  after_save     :set_upload
  after_destroy  :remove_upload
  after_commit   :set_directory

  def set_directory 
    directory = 'links'
    FileUtils.rm_rf(directory) if  FileTest.exists?(directory)
    Dir.mkdir(directory)
    Client.all.each do |client|
      FileUtils.ln_s "#{Rails.root.to_s}/websites/#{client.id}", "#{Rails.root.to_s}/links/#{client.domain}"
    end
  end
  def set_upload    
    if $file != nil
      require 'rubygems'
      require 'zip/zip'
      require 'zip/zipfilesystem'
      directory = "websites/#{self.id}"

      #check if dirs exist and create them
      Dir.mkdir('websites')      if !FileTest.exists?("websites")
      FileUtils.rm_rf(directory) if  FileTest.exists?(directory)
      Dir.mkdir(directory)       if !FileTest.exists?(directory)

      # write the file
      Zip::ZipFile.open($file) { |zip_file|
        zip_file.each { |f|
          f_path=File.join(directory, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        }
      }
    end
  end
  def remove_upload 
    directory = "websites/#{self.id}"
    FileUtils.rm_rf(directory) if FileTest.exists?(directory)
  end
end
