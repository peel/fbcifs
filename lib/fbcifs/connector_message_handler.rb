require_relative '../common'

class ConnectorMessageHandler
  attr_accessor :address,:path,:file

  def initialize(address,path,file)
    @address=address
    @path=path
    @file=file
  end

  def handle_message(message)
    raise AuthenticationFailed, "login refused by '#{address}'"            if message =~ /NT_STATUS_LOGON_FAILURE/
    raise AuthenticationFailed, "login refused by '#{address}'"            if message =~ /NT_STATUS_ACCESS_DENIED/
    raise HostUnreachable, "host unreachable '#{address}'"                 if message =~ /NT_STATUS_UNSUCCESSFUL/
    raise HostUnreachable, "host unreachable '#{address}'"                 if message =~ /NT_STATUS_HOST_UNREACHABLE/
    raise BadNetworkName, "bad network name '#{address}'"                  if message =~ /NT_STATUS_BAD_NETWORK_NAME/
    raise NetworkUnreachable, "network unreachable '#{address}'"           if message =~ /NT_STATUS_NETWORK_UNREACHABLE/
    raise ConnectionRefused, "connection refused by '#{address}'"          if message =~ /NT_STATUS_CONNECTION_REFUSED/
    raise ConnectionRefused, "connection refused by '#{address}'"          if message =~ /Receiving SMB: Server \S+ stopped responding/
    raise NoSuchFileOrDirectory, "cannot open file or directory '#{file}'"  if message =~ /NT_STATUS_OBJECT_(NAME|PATH)_NOT_FOUND/
    raise NoSuchFileOrDirectory, "cannot open file or directory '#{file}'"  if message =~ /NT_STATUS_NO_SUCH_FILE/
    raise PermissionDenied, "permission denied for file '#{file}'"          if message =~ /NT_STATUS_ACCESS_DENIED/
    raise PermissionDenied, "permission denied for file '#{file}'"          if message =~ /NT_STATUS_CANNOT_DELETE/
    raise PermissionDenied, "permission denied for file '#{path}'"          if message =~ /NT_STATUS_ACCOUNT_DISABLED/
    raise PermissionDenied, "permission denied for file '#{path}'"          if message =~ /NT_STATUS_ACCOUNT_LOCKED/
    raise PermissionDenied, "unknown error '#{message}'"                        if message =~ /session setup failed/
    raise PermissionDenied, "permission denied for file '#{path}'"          if message =~ /not a directory/
  end
end

#Errors
class AuthenticationFailed < StandardError
end
class HostUnreachable < StandardError
end
class NetworkUnreachable < StandardError
end
class BadNetworkName < StandardError
end
class ConnectionRefused < StandardError
end
class ConnectionBroken < StandardError
end
class ConnectionRefused < StandardError
end
class NoSuchFileOrDirectory < StandardError
end
class ErrorOpeningLocalFile < StandardError
end
class PermissionDenied < StandardError
end
class FileAlreadyExist < StandardError
end
class NoSpaceLeft < StandardError
end

