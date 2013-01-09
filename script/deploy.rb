#!/usr/bin/env ruby

class FtpDeployer

  require 'net/ftp'
  require 'yaml'

  attr_accessor :host, :username, :password, :remote_dir, :deploy_dir
  attr_accessor :file_permission, :dir_permission
  attr_accessor :ftp_connection
  attr_accessor :config
  def load_config
    self.config = YAML.load(File.read(File.join(File.dirname(__FILE__), "config.yml")))
  end

  def initialize(password = nil, environment = :production)
    load_config
    puts self.config
    self.host = self.config[environment.to_s]["host"]
    self.username = self.config[environment.to_s]["username"]
    self.password = password || ENV['PASSWORD']
    self.remote_dir = self.config[environment.to_s]["remote_dir"] || "/www"
    self.deploy_dir = self.config[environment.to_s]["local_dir"] || File.join(Dir.pwd, '_site')
    self.file_permission = 0644
    self.dir_permission = 0755
  end

  def deploy
    begin
      puts "Connecting to #{self.host}...\n"
      self.ftp_connection =  Net::FTP.new(self.host)
      puts "Logging in...\n"
      self.ftp_connection.login(self.username, self.password)
      self.ftp_connection.chdir(self.remote_dir)
      recursively_upload_from(self.deploy_dir)
      self.ftp_connection.close
    rescue Exception => exp
      puts "ERROR: #{exp.message}\nAborting..."
    end
  end

  def recursively_upload_from(dir)
    Dir.foreach(dir) do |file|
      next if file == "." || file == ".." || file == ".git" || file =~ /\.yml\Z/
      if File.directory?(File.join(dir, file))
        find_or_create_remote_directory(remote_path(File.join(dir, file)))
        recursively_upload_from(File.join(dir,file))
      else
        puts "Uploading #{remote_path(File.join(dir, file))}\n"
        self.ftp_connection.chdir(remote_path(dir))
        self.ftp_connection.put(File.join(dir, file), file)
      end
    end
  end

  def local_path(file)
    File.join(self.deploy_dir, file)
  end

  def remote_path(file)
    self.remote_dir + local_path(file).gsub(self.deploy_dir, '')
  end

  #If we hit an exception, assume the directory does not exist and create it
  def find_or_create_remote_directory(file)
    begin
      return unless File.directory?(local_path(file))
      self.ftp_connection.chdir(remote_path(file))
    rescue
      puts "Creating directory: #{file}"
      self.ftp_connection.mkdir(remote_path(file))
    end
  end
end

FtpDeployer.new(ARGV[0]).deploy

