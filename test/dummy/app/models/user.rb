class User < ApplicationRecord
  has_identifier "{4}:{4}", alphabet: :letters, case: :mix
end
