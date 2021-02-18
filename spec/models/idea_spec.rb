require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:category).with_prefix }
  end
end
