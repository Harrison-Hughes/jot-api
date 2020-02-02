class Point < ApplicationRecord
  belongs_to :pad

  validates :text, presence: true
end
