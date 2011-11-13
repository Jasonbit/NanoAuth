# NanoAuth
# 
# 

require 'bcrypt'

module NanoAuth
  
  def self.included(base)

    # Virtual attributes
    attr_accessor :password

    # AR Callbacks
    base.before_save :encrypt_password
    
    # Password validation
    base.validates_presence_of     :password, :if => Proc.new { |u| u.password_required? }
    base.validates_confirmation_of :password, :if => Proc.new { |u| u.password_required? }, :allow_nil => true
    base.validates_length_of       :password, :minimum => 6, :if => Proc.new { |u| u.password_required? }, :allow_nil => true

    # Class methods
    base.class_eval do

      # Authenticates a user by their email name and unencrypted password.  Returns the user or nil.
      def self.authenticate(email, password)
        return nil unless email && password
        u = find_by_email(email)
        u && u.authenticated?(password) ? u : nil
      end

    end
    
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    BCrypt::Engine.hash_secret(password,password_salt)
  end

  # The big question - are we equivalent?
  def authenticated?(password)
    password_hash == encrypt(password)
  end

  # Tell us if there's a password to work with
  def password_required?
    password_hash.blank? || !password.blank?
  end
    
  protected
  
  # Encrypts the password with the user salt
  def encrypt_password
   
    if password.present?  
      self.password_salt = BCrypt::Engine.generate_salt  
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)  
    end
    
  end
  
end