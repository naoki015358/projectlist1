class Project < ApplicationRecord
    validates :product, presence: true, length: { maximum: 50 }
    validates :status, presence: true, length: { maximum: 50 }
end
