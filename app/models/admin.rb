class Admin < ApplicationRecord
  def self.create_secret
    ('0'..'~').to_a.shuffle[0, 20].join
  end
end
