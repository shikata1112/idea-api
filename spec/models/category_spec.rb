require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '.fetch_ideas' do
    before do
      category1 = Category.create!(name: 'アプリ')
      category2 = Category.create!(name: 'スポーツ')
      idea1 = Idea.create!(category_id: category1.id, body: 'タスク管理アプリ')
      idea2 = Idea.create!(category_id: category1.id, body: '家計簿アプリ')
      idea3 = Idea.create!(category_id: category2.id, body: '野球')
    end

    context 'category_nameが存在するとき' do
      context 'category_nameをもつcategoryデータが存在するとき' do
        it 'categoryに紐づくideaを全て返すこと' do
          expect(Category.fetch_ideas('アプリ').size).to eq 2
        end
      end

      context 'category_nameをもつcategoryデータが存在しないとき' do
        it 'falseを返すこと' do
          expect(Category.fetch_ideas('健康')).to eq []
        end
      end
    end

    context 'category_nameが存在しないとき' do
      it 'ideaを全て返すこと' do
        expect(Category.fetch_ideas(' ').size).to eq 3
      end
    end
  end
end