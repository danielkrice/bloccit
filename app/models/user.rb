class User < ActiveRecord::Base
    before_save { self.email = email.downcase if email.present? }
    before_save {
        name_array = []
        name.to_s.split.each do |part|
            name_array << part.capitalize
        end
        self.name = name_array.join(" ")
    }
    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
    validates :password, length: { minimum: 6 }, allow_blank: true
    validates :email,
        presence: true,
        uniqueness: { case_sensitive: false },
        length: { minimum: 3, maximum: 254 }
    has_secure_password
end