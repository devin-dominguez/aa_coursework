# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean          default(TRUE), not null
#

module GoalsHelper
end
