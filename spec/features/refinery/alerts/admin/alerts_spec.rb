# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Alerts" do
    describe "Admin" do
      describe "alerts" do
        refinery_login_with :refinery_user

        describe "alerts list" do
          before do
            FactoryGirl.create(:alert, :title => "UniqueTitleOne")
            FactoryGirl.create(:alert, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.alerts_admin_alerts_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.alerts_admin_alerts_path

            click_link "Add New Alert"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Alerts::Alert.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Alerts::Alert.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:alert, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.alerts_admin_alerts_path

              click_link "Add New Alert"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Alerts::Alert.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:alert, :title => "A title") }

          it "should succeed" do
            visit refinery.alerts_admin_alerts_path

            within ".actions" do
              click_link "Edit this alert"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:alert, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.alerts_admin_alerts_path

            click_link "Remove this alert forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Alerts::Alert.count.should == 0
          end
        end

      end
    end
  end
end
