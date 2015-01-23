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
              alert = FactoryGirl.build(:alert, :live_at => 1.minute.ago, :down_at => nil)
              expect(alert.live?).to eq(true)
            end
          end
          context "and #down_at is after the current time" do
            it "returns true" do
              alert = FactoryGirl.build(:alert, :live_at => 1.minute.ago, :down_at => 1.minute.from_now)
              expect(alert.live?).to eq(true)
            end
          end
          context "and #down_at is after the current time" do
            it "returns true" do
              alert = FactoryGirl.build(:alert, :live_at => 1.minute.ago, :down_at => 1.minute.from_now)
              expect(alert.live?).to eq(true)
            end
          end
          context "and #down_at is equal to the current time" do
            it "returns false" do
              alert = FactoryGirl.build(:alert, :live_at => 1.minute.ago, :down_at => Time.zone.now)
              expect(alert.live?).to eq(false)
            end
          end
        end
        context "when #live_at is after the current time" do
          it "returns false" do
            alert = FactoryGirl.build(:alert, :live_at => 1.minute.from_now)
            expect(alert.live?).to eq(false)
          end
        end
      end

      describe "Alert.live scope" do
        it "returns alerts where live_at is before the current time, and down_at is nil" do
          alert = FactoryGirl.create(:alert, :live_at => 1.minute.ago, :down_at => nil)
          expect(Alert.live).to include(alert)
        end
        it "returns alerts where live_at is before the current time and down_at is after the current time" do
          alert = FactoryGirl.create(:alert, :live_at => 1.minute.ago, :down_at => 1.minute.from_now)
          expect(Alert.live).to include(alert)
        end
        it "doesn't return alerts where live_at is after the current time" do
          alert = FactoryGirl.create(:alert, :live_at => 1.minute.from_now)
          expect(Alert.live).not_to include(alert)
        end
        it "doesn't return alerts where down_at is before the current time" do
          alert = FactoryGirl.create(:alert, :down_at => Time.zone.now)
          expect(Alert.live).not_to include(alert)
        end
      end

      describe "Alert.ordered scope" do
        it "sorts by live_at" do
          older = FactoryGirl.create(:alert, :live_at => 1.hour.ago)
          recent = FactoryGirl.create(:alert, :live_at => Time.zone.now)
          Alert.ordered.should eq([recent, older])
        end
      end

    end
  end
end
