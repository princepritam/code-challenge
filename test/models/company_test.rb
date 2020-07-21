require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  def setup
    @company = Company.new(name: "Dummy Company", zip_code: "10024")
  end

  test "should save company object when email is valid" do
    @company.email = "test@getmainstreet.com"
    assert @company.save
  end

  test "should not save company when email is invaild" do
    @company.email = "test@invalid.com"
    assert_not @company.save
  end
  
  test "should create city and state" do
    @company.save
    assert_not_nil @company.city
    assert_not_nil @company.state
  end

  test "should not validate email field when its empty" do
    @company.email = ""
    assert @company.save
  end

  test "city and state should change when zip is changed" do
    @company.save
    old_city = @company.city
    old_state = @company.state

    @company.zip_code = "99501"
    @company.save

    assert_not_equal  old_city, @company.city
    assert_not_equal  old_state, @company.city
  end

  test "should not update city, state and zipcode if zipcode is invalid" do
    @company.save
    old_city = @company.city
    old_state = @company.state

    @company.zip_code = "invalid123333code"
    @company.save
    assert_equal old_city, @company.city
    assert_equal old_state, @company.state
  end

end