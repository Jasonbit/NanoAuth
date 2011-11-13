require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup

     # Returns a saved User instance
     @jim = FactoryGirl.create(:user, :password=>"123456")

   end
   
  # Make sure Jim exists in the system
  test "jim is valid" do
    
    assert_equal "Jim",               @jim.first_name
    assert_equal "Smith",             @jim.last_name
    assert_equal "jim@example.com",   @jim.email
    
    assert @jim.persisted?
    
  end
  
  # Can Jim authenticate?
  test "jim can authenticate" do
    password = "my_password"
    
    @jim.password = password
    @jim.save
    
    assert_not_nil @jim.password_hash
    assert_not_nil @jim.password_salt
    
    assert_equal @jim.encrypt(password), @jim.password_hash
    
  end
  
  # Is Jim authenticated?
  test "jim is authenticated" do
    
    u = User.authenticate("jim@example.com","123456")

    assert_not_nil u
    
  end
  
  
end
