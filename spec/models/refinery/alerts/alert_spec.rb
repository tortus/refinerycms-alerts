require 'spec_helper'

module Refinery
  module Alerts
    describe Alert do

      subject do
        FactoryGirl.build(:alert)
      end

      it "saves" do
        expect(subject.save!).to be_truthy
      end

      describe "validations" do
        it { should be_valid }
        its(:errors) { should be_empty }
      end

      describe "#live?" do
        context "when #live_at is before the current time" do
          context "and #down_at is nil" do
            it "returns true" do
              alert = FactoryGirl.build(:alert, :live_at => 1.hour.ago, :down_at => nil)
              expect(alert.live?).to eq(true)
            end
          end
          context "and #down_at is after the current time" do
            it "returns true" do
              alert = FactoryGirl.build(:alert, :live_at => 1.hour.ago, :down_at => Time.zone.now + 1.hour)
              expect(alert.live?).to eq(true)
            end
          end
          context "and #down_at is after the current time" do
            it "returns true" do
              alert = FactoryGirl.build(:alert, :live_at => 1.hour.ago, :down_at => Time.zone.now + 1.hour)
              expect(alert.live?).to eq(true)
            end
          end
          context "and #down_at is equal to the current time" do
            it "returns false" do
              alert = FactoryGirl.build(:alert, :live_at => 1.hour.ago, :down_at => Time.zone.now)
              expect(alert.live?).to eq(false)
            end
          end
        end
      end

    end
  end
end
