require 'spec_helper'

describe AuthFilters do

  klass = Class.new(Cuba) do
    include AuthFilters
  end

  let(:subject) do
    subject = klass.new
    subject.stub(:res).and_return(double.as_null_object)
    subject.stub(:logger).and_return(double.as_null_object)
    subject
  end

  describe '#access_control_mode' do
    it 'returns ENV[ACCESS_CONTROL] value' do
      expect(subject.access_control_mode).to eq(ENV['ACCESS_CONTROL'])
    end

    it 'returns none by default if ENV is not set' do
      ENV.stub(:[]).with('ACCESS_CONTROL').and_return(nil)
      expect(subject.access_control_mode).to eq('none')
    end
  end

  describe '#restricted_access?' do
    it 'returns true if access control mode is eds' do
      ENV.stub(:[]).with('ACCESS_CONTROL').and_return('eds')
      expect(subject.restricted_access?).to be_true
    end

    it 'returns true if access control mode is custom' do
      ENV.stub(:[]).with('ACCESS_CONTROL').and_return('custom')
      expect(subject.restricted_access?).to be_true
    end

    it 'returns false if access control mode is none' do
      ENV.stub(:[]).with('ACCESS_CONTROL').and_return('none')
      expect(subject.restricted_access?).to be_false
    end
  end

  describe '#require_valid_token!' do
    it 'throws :halt without valid auth token' do
      allow(subject).to receive(:env).and_return({})
      expect {
        subject.require_valid_token!
      }.to throw_symbol(:halt)
    end

    it 'returns true with valid auth token' do
      allow(subject).to receive(:env).and_return({'HTTP_AUTHORIZATION' => "Bearer #{ENV['SECURITY_TOKEN']}"})
      expect {
        expect(subject.require_valid_token!).to be_true
      }.not_to throw_symbol(:halt)
    end

    it 'calls require_eds_token if access control mode is eds' do
      ENV.stub(:[]).and_return(nil)
      ENV.stub(:[]).with('ACCESS_CONTROL').and_return('eds')
      allow(subject).to receive(:env).and_return({'HTTP_AUTHORIZATION' => "Bearer eds_token"})

      expect(subject).to receive(:require_eds_token)
      expect {
        subject.require_valid_token!
      }.to throw_symbol(:halt)
    end
  end
end