require 'spec_helper'

module Refinery
  module Alerts
    describe Alert do
      subject do
        FactoryGirl.build(:alert)
      end

      describe "validations" do
        subject do
          FactoryGirl.build(:alert)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end

      it "saves" do
        expect(subject.save!).to be_truthy
      end
    end
  end
end
