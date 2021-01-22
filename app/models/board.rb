class Board < ApplicationRecord
  belongs_to :surfer
  enum size: [:small, :medium, :large]
end
