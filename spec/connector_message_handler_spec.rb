require 'rspec'
require_relative '../lib/fbcifs/connector_message_handler'

describe ConnectorMessageHandler, '#handle_message' do
  address = 'cifs-01.nas-01-int.pld2.root4.net'
  path = '/lorem/ipsum'
  file = 'dolor'
  where(:message, :response) do
    [
      ['NT_STATUS_LOGON_FAILURE',AuthenticationFailed],
      ['NT_STATUS_ACCESS_DENIED',AuthenticationFailed],
      ['NT_STATUS_UNSUCCESSFUL',HostUnreachable],
      ['NT_STATUS_HOST_UNREACHABLE',HostUnreachable],
      ['NT_STATUS_BAD_NETWORK_NAME',BadNetworkName],
      ['NT_STATUS_CONNECTION_REFUSED',ConnectionRefused],
      ["Receiving SMB: Server #{address} stopped responding",ConnectionRefused],
      ['NT_STATUS_NETWORK_UNREACHABLE',NetworkUnreachable],
      ['NT_STATUS_OBJECT_PATH_NOT_FOUND',NoSuchFileOrDirectory],
      ['NT_STATUS_OBJECT_NAME_NOT_FOUND',NoSuchFileOrDirectory],
      ['NT_STATUS_NO_SUCH_FILE',NoSuchFileOrDirectory],
      ['NT_STATUS_CANNOT_DELETE',PermissionDenied],
      ['NT_STATUS_ACCOUNT_DISABLED',PermissionDenied],
      ['NT_STATUS_ACCOUNT_LOCKED',PermissionDenied],
      ['session setup failed',PermissionDenied],
      ['not a directory',PermissionDenied]
    ]
  end

  with_them do
     it 'given status message of smb connection failure should retry action on a file ' do
      handler = ConnectorMessageHandler.new(address,path,file)
      expect{handler.handle_message(message)}.to raise_error(response)
    end
  end
end