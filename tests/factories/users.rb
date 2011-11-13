# Read about factories at http://github.com/thoughtbot/factory_girl

# key :first_name,        String, :required=> true
# key :last_name,         String, :required=> true
# key :email,             String, :required=> true
# key :phone,             String
# key :zip,               String
# key :activated_at,      DateTime
# key :timezone,          String  
# key :crypted_password,  String  
# key :salt,              String  

FactoryGirl.define do
  
  factory :user do
    first_name  "Jim"
    last_name   "Smith"
    email       "jim@example.com"
  end
    
end