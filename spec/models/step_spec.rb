# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  issue_id   :bigint
#
# Indexes
#
#  index_steps_on_issue_id  (issue_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#

require 'rails_helper'

RSpec.describe Step, type: :model do
  describe 'Stepのバリデーション' do
    let(:step) { build(:step, title: title) }
    subject { step.valid? }
    context 'タイトルが入力されている場合' do
      let(:title) { 'ステップ' }
      it { is_expected. to eq true }
    end
    context 'タイトルが入力されていない場合' do
      let(:title) { '' }
      it { is_expected. to eq false }
    end
  end
end
