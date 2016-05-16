# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             default("No description given"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image_html  :string
#

module CatsHelper
end
