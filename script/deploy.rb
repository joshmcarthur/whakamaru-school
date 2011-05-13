require 'net/ftp'
require 'pp'

class FtpDeployer

  attr_accessor :host, :username, :password, :remote_dir, :deploy_dir
  attr_accessor :file_permission, :dir_permission

  def initialize(host, username, password = nil)
    self.host = host
    self.username = username
    self.password = password || ENV['PASSWORD']
    self.remote_dir = "/www"
    self.deploy_dir = Dir.pwd
    self.file_permission = 0644
    self.dir_permission = 0755
  end

  def deploy
    begin
      puts "Connecting to #{self.host}...\n"
      ftp =  Net::FTP.new(self.host)
      puts "Logging in...\n"
      ftp.login(self.username, self.password)
      ftp.chdir(self.remote_dir)
      Dir.foreach(self.deploy_dir) do |file|
        if File.directory?(local_file(file))
          find_or_create_remote_directory(file, ftp)
          next
        end
        puts file
        puts ftp.mtime(file)
        ftp.put(remote_file(file)) if File.stat(local_file(file)).mtime > ftp.mtime(remote_file(file))
      end
      ftp.close
    #rescue Exception => exp
     # puts "ERROR: #{exp.message}\nAborting..."
    end
  end

  def local_file(file)
    File.join(self.deploy_dir, file)
  end

  def remote_file(file)
    self.remote_dir + local_file(file).gsub(self.deploy_dir, '')
  end

  #If we hit an exception, assume the directory does not exist and create it
  def find_or_create_remote_directory(file, ftp_connection)
    begin
      return unless File.directory?(local_file(file))
      ftp_connection.chdir(remote_file(file))
    rescue
      ftp_connection.mkdir(remote_file(file))
    end
  end
end

FtpDeployer.new(ARGV[0], ARGV[1]).deploy

