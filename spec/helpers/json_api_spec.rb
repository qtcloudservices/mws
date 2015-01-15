require 'spec_helper'

describe JsonApi do

  klass = Class.new(Cuba) do
    include JsonApi
  end

  let(:subject) do
    subject = klass.new
    subject.stub(:res).and_return(double.as_null_object)
    subject.stub(:req).and_return(double.as_null_object)
    subject
  end

  describe '#parse_json' do
    it 'retuns parsed request json body' do
      body = {'hello' => 'world'}
      allow(subject.req).to receive(:body).and_return(StringIO.new(JSON.dump(body)))
      expect(subject.parse_json).to eq(body)
    end

    it 'throws :halt with invalid request body' do
      allow(subject.req).to receive(:body).and_return(StringIO.new('invalid json}'))
      expect {
        subject.parse_json
      }.to throw_symbol(:halt)
    end
  end

  describe '#respond_json' do
    it 'sets res status' do
      allow(subject.res).to receive(:status=).with(201)
      subject.respond_json(201, {})
    end

    it 'calls res.write with json' do
      body = {'hello' => 'world'}
      allow(subject.res).to receive(:write).with(JSON.dump(body))
      subject.respond_json(201, body)
    end
  end
end