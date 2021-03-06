# == Schema Information
#
# Table name: surveys
#
#  id                        :integer          not null, primary key
#  instrument_id             :integer
#  created_at                :datetime
#  updated_at                :datetime
#  uuid                      :string
#  device_id                 :integer
#  instrument_version_number :integer
#  instrument_title          :string
#  device_uuid               :string
#  latitude                  :string
#  longitude                 :string
#  metadata                  :text
#  completion_rate           :string
#  device_label              :string
#  deleted_at                :datetime
#  roster_uuid               :string
#  language                  :string
#  skipped_questions         :text
#  completed_responses_count :integer
#

require "spec_helper"

describe Survey do
  it { should respond_to(:instrument) }
  it { should respond_to(:device) }
  it { should respond_to(:responses) }

  before :each do
    @survey = build(:survey) 
  end

  it "should be valid" do
    @survey.should be_valid
  end
  
  it "should return the correct responses" do
    response = create(:response)
    response.survey.responses.should == [response]
  end

  describe "validations" do
    it "should require a device id" do
      @survey.device_id = nil
      @survey.should_not be_valid
    end

    it "should not allow a blank device id" do
      @survey.device_id = " "
      @survey.should_not be_valid
    end

    it "should require a uuid" do
      @survey.uuid = nil
      @survey.should_not be_valid
    end

    it "should not allow a blank uuid" do
      @survey.uuid = " "
      @survey.should_not be_valid
    end

    it "should require a instrument id" do
      @survey.instrument_id = nil
      @survey.should_not be_valid
    end

    it "should not allow a blank instrument id" do
      @survey.instrument_id = " "
      @survey.should_not be_valid
    end

    it "should require a instrument version number" do
      @survey.instrument_version_number = nil
      @survey.should_not be_valid
    end

    it "should not allow a blank instrument version number" do
      @survey.instrument_version_number = " "
      @survey.should_not be_valid
    end
  end
end
