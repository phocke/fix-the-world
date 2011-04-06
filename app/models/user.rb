class User
  include Mongoid::Document
  #include Mongoid::Timestamps
    
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable

  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation 
  validates_format_of     :email, :with => %r{.+@.+\..+}
  
  #field :name,                :type => String
  #field :email,               :type => String
  #field :encrypted_password,  :type => String
  #field :password_salt,       :type => String
  field :admin,               :type => Boolean  

  has_many_related :wishes
  has_many_related :votes
  has_many_related :issues

  #validates_presence_of   :email, :name
  #validates_uniqueness_of :email
  
  #validates_presence_of     :password, :if => :password_required?
  #validates_confirmation_of :password, :if => :password_required?
  
  #before_save :initialize_salt, :encrypt_password
  
  #attr_accessor :password, :password_confirmation

  #class << self
    #def authenticate(email, password)
      #return nil  unless user = criteria.where(:email => email).first
      #return user if     user.authenticated?(password)
    #end    
  #end
  
  #def authenticated?(password)
    #encrypted_password == encrypt(password)
  #end

  #def self.to_sym
    #User.inspect
  #end

  def guest?
    new_record?
  end

  def not_guest?
    !guest?
  end

  def admin?
    self.admin
  end
  
  #protected
    
    #def encrypt_password
      #self.encrypted_password = encrypt(password)
    #end
    
    #def generate_hash(string)
      #Digest::SHA1.hexdigest(string)
    #end
    
    #def initialize_salt
      #if new_record?
        #self.password_salt = generate_hash("--#{Time.now.utc}--#{password}--")
      #end
    #end
    
    #def encrypt(string)
      #generate_hash("--#{password_salt}--#{string}--")
    #end
    
    #def password_required?
      #encrypted_password.blank? || !password.blank?
    #end
  
end
