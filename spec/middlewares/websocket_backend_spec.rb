require 'spec_helper'

describe WebsocketBackend do

  let(:subject) do
    WebsocketBackend.new(double.as_null_object)
  end

  describe '#on_open' do
    it 'registers client with valid token' do
      WebsocketUri.create(socket_id: 'foobar')
      ws = double.as_null_object
      req = double.as_null_object
      allow(req.params).to receive(:[]).with('token').and_return('foobar')
      expect {
        subject.on_open(ws, req)
      }.to change{ subject.clients.size }.by(1)
    end

    it 'closes connection with invalid token' do
      WebsocketUri.create(socket_id: 'foobar')
      ws = double.as_null_object
      req = double.as_null_object
      allow(req.params).to receive(:[]).with('token').and_return('invalid')
      expect(ws).to receive(:close).once
      expect {
        subject.on_open(ws, req)
      }.to change{ subject.clients.size }.by(0)
    end
  end

  describe '#on_close' do
    it 'closes websocket connection' do
      WebsocketUri.create(socket_id: 'foobar')
      ws = double.as_null_object
      req = double.as_null_object
      allow(req.params).to receive(:[]).with('token').and_return('foobar')
      expect(ws).to receive(:close).once
      subject.on_open(ws, req)
      expect {
        subject.on_close(ws)
      }.to change{ subject.clients.size }.by(-1)
    end
  end
end