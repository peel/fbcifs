module Fbcifs
  class MessageHandler

    def handle_message(message)
      raise AuthenticationFailed if message =~ /(NT_STATUS_LOGON_FAILURE)|(NT_STATUS_ACCESS_DENIED)/
      raise HostUnreachable if message =~ /(NT_STATUS_UNSUCCESSFUL)|(NT_STATUS_HOST_UNREACHABLE)/
      raise BadNetworkName if message =~ /NT_STATUS_BAD_NETWORK_NAME/
      raise NetworkUnreachable if message =~ /NT_STATUS_NETWORK_UNREACHABLE/
      raise ConnectionRefused if message =~ /(NT_STATUS_CONNECTION_REFUSED)|(Receiving SMB: Server \S+ stopped responding)/
      raise NoSuchFileOrDirectory if message =~ /(NT_STATUS_OBJECT_(NAME|PATH)_NOT_FOUND)|(NT_STATUS_NO_SUCH_FILE)/
      raise PermissionDenied if message =~ /(NT_STATUS_ACCESS_DENIED)|(NT_STATUS_CANNOT_DELETE)|(NT_STATUS_ACCOUNT_DISABLED)|(NT_STATUS_ACCOUNT_LOCKED)|(not a directory)|(session setup failed)/
    end
  end

  class AuthenticationFailed < StandardError; end
  class HostUnreachable < StandardError; end
  class NetworkUnreachable < StandardError; end
  class BadNetworkName < StandardError; end
  class ConnectionRefused < StandardError; end
  class ConnectionBroken < StandardError; end
  class ConnectionRefused < StandardError; end
  class NoSuchFileOrDirectory < StandardError; end
  class ErrorOpeningLocalFile < StandardError; end
  class PermissionDenied < StandardError; end
  class FileAlreadyExist < StandardError; end
  class NoSpaceLeft < StandardError; end

end

