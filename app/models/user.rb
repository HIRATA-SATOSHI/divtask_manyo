class User < ApplicationRecord
    before_destroy :admin_user_destroy_action
    before_update :admin_user_update_action
    has_many :tasks, dependent: :destroy
    has_secure_password
    before_save { email.downcase! }
    before_validation { email.downcase! }
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true, length: { minimum: 6 }


    private

    def admin_user_destroy_action
      if User.where(admin: true).count == 1 && self.admin
        throw(:abort)
      end
    end   

    def admin_user_update_action
      @admin_user = User.where(admin: true)
      if (@admin_user.count == 1 && @admin_user.first == self) && !(self.admin)      
        throw :abort        

      end
    end

end
