require 'rspec'
require 'rspec-parameterized'
require_relative '../lib/fbcifs/message_handler'

describe Fbcifs::MessageHandler, '#handle_message' do
  address = 'cifs-01.nas-01-int.pld2.root4.net'
  where(:message, :response) do
    [
      ['NT_STATUS_LOGON_FAILURE',Fbcifs::AuthenticationFailed],
      ['NT_STATUS_ACCESS_DENIED',Fbcifs::AuthenticationFailed],
      ['NT_STATUS_UNSUCCESSFUL',Fbcifs::HostUnreachable],
      ['NT_STATUS_HOST_UNREACHABLE',Fbcifs::HostUnreachable],
      ['NT_STATUS_BAD_NETWORK_NAME',Fbcifs::BadNetworkName],
      ['NT_STATUS_CONNECTION_REFUSED',Fbcifs::ConnectionRefused],
      ["Receiving SMB: Server #{address} stopped responding",Fbcifs::ConnectionRefused],
      ['NT_STATUS_NETWORK_UNREACHABLE',Fbcifs::NetworkUnreachable],
      ['NT_STATUS_OBJECT_PATH_NOT_FOUND',Fbcifs::NoSuchFileOrDirectory],
      ['NT_STATUS_OBJECT_NAME_NOT_FOUND',Fbcifs::NoSuchFileOrDirectory],
      ['NT_STATUS_NO_SUCH_FILE',Fbcifs::NoSuchFileOrDirectory],
      ['NT_STATUS_CANNOT_DELETE',Fbcifs::PermissionDenied],
      ['NT_STATUS_ACCOUNT_DISABLED',Fbcifs::PermissionDenied],
      ['NT_STATUS_ACCOUNT_LOCKED',Fbcifs::PermissionDenied],
      ['session setup failed',Fbcifs::PermissionDenied],
      ['not a directory',Fbcifs::PermissionDenied]
    ]
  end

  with_them do
     it 'given status message of smb connection failure should retry action on a file ' do
      handler = Fbcifs::MessageHandler.new
      expect{handler.handle_message(message)}.to raise_error(response)
    end
  end
end