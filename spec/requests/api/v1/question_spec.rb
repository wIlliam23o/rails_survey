require 'spec_helper'

describe "Questions API" do
  before :each do
    @questions = FactoryGirl.create_list(:question, 5)
    get '/api/v1/questions'
    @json = JSON.parse(response.body)
  end

  it 'returns a successful response' do
    expect(response).to be_success
  end

  it 'receives the correct number of questions' do
    expect(@json.length).to eq(5)
  end

  it 'has a text attribute' do
    @json.first.should have_key('text')
  end

  it 'has a translations attribute' do
    @json.first.should have_key('translations')
    @json.first['translations'].should be_a Array
  end

  it "has a question_identifier" do
    @json.first.should have_key('question_identifier')
    @json.first['question_identifier'].should == @questions.first.question_identifier
  end

  describe "translation text" do
    before :each do
      @translation = create(:question_translation)
      get '/api/v1/questions'
      @json = JSON.parse(response.body)
    end

    it "should add a new question for the translation" do
      expect(@json.length).to eq(6)
    end

    it "has the correct translation text" do
      @json.last['translations'].first['text'].should == @translation.text
    end

    it "has the correct translation text" do
      @json.last['translations'].first['language'].should == @translation.language
    end
  end
end