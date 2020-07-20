require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "#{@company.city}, #{@company.state}"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "10024")
      click_button "Update Company"
    end

    assert_text "Changes Saved"
    assert_equal "Ventura", @company.city
    assert_equal "CA", @company.state
    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "10024", @company.zip_code
    assert_equal "New York City", @company.city
    assert_equal "NY", @company.state
  end
  
  test "Create" do
    visit new_company_path
    
    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end
    
    assert_text "Saved"
    
    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
    assert_equal "Waxhaw", last_company.city
    assert_equal "NC", last_company.state
  end

  test "Failure for invalid zipcode and email format" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "222221111")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@invalid.com")
      click_button "Create Company"
    end

    assert_text "Validation failed: Zip code is invalid, Email should only be a @getmainstreet.com domain"

    assert_not_equal "New Test Company", Company.last.name
  end

  test "No validation for email field if none is given in params" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "10024")
      fill_in("company_phone", with: "5553335555")
      click_button "Create Company"
    end

    assert_text "Saved"

    new_company = Company.last
    assert_equal "New Test Company", new_company.name
    assert_equal "10024", new_company.zip_code
    assert_equal "New York City", new_company.city
    assert_equal "NY", new_company.state
  end

end
