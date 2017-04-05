require 'grape-entity'

class Session < Grape::Entity
  expose :title
  expose :facilitator
  expose :datetime
  expose :place
  expose :description
end
