module Fbcifs

  class CIFS
    attr_reader :address,:port,:share,:credentials
    def initialize(address,port,share,credentials)
      @address=address
      @port=port
      @share=share
      @credentials=credentials
    end
  end

  class Credentials
    attr_reader :login, :password
    def initialize(login, password)
      @login = login
      @password = password
    end
    def authfile
      filename = Digest::MD5.hexdigest("#{login}_#{password}" + rand(Time.now().to_i).to_s)
      "tmp/#{filename}.pwd"
    end
    def make_credentials_file
      begin
        File.open(authfile, 'w', 0600) { |fd| fd.puts "username = #{login}\npassword = #{password}\n" }
        authfile
      rescue
        raise FileOperationException,"failed to create file: #{authfile}"
      end
    end
    def drop_credentials_file
      begin
        File.delete(authfile) if File.exist?(authfile)
      rescue
        raise FileOperationException,"failed to delete file: #{authfile}"
      end
    end
  end

end
