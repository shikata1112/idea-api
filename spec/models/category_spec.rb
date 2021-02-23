require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '.hoge' do
    before do
      category1 = Category.create!(name: 'アプリ')
      category2 = Category.create!(name: 'スポーツ')
      Idea.create!(category_id: category1.id, body: 'タスク管理アプリ')
      Idea.create!(category_id: category1.id, body: '家計簿アプリ')
      Idea.create!(category_id: category2.id, body: '野球')
    end

    context 'category_nameが存在するとき' do
      context 'category_nameをもつcategoryデータが存在するとき' do
        it 'categoryに紐づくideaを全て返すこと' do
          expect(Category.hoge('アプリ').size).to eq 2
        end
      end

      context 'category_nameをもつcategoryデータが存在しないとき' do
        it 'falseを返すこと' do
          expect(Category.hoge('健康')).to eq []
        end
      end
    end

    context 'category_nameが存在しないとき' do
      it 'ideaを全て返すこと' do
        expect(Category.hoge(' ').size).to eq 3
      end
    end
  end

  describe '.create_ideas!' do
    before do
      @category1 = Category.create!(name: 'アプリ')
    end

    describe 'categoryのnameが存在する場合' do
      it 'categoryに紐づくideaを作成できること' do
        Category.create_ideas!(@category1.name, 'test')

        expect(@category1.ideas.last.body).to eq 'test'
      end

      it '例外が発生すること' do
        expect { Category.create_ideas!(@category1.name, ' ') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    describe 'categoryのnameが存在しない場合' do
      it '新たなcategoryとideaが保存されること' do
        Category.create_ideas!('スポーツ', 'test')

        category = Category.find_by(name: 'スポーツ')
        expect(category.name).to eq 'スポーツ'
        expect(category.ideas.last.body).to eq 'test'
      end

      context 'nameが空の場合' do
        it '例外が発生すること' do
          expect { Category.create_ideas!(' ', 'test') }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'bodyが空の場合' do
        it '例外が発生すること' do
          expect { Category.create_ideas!('アプリ', ' ') }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'nameとbodyどちらも空の場合' do
        it '例外が発生すること' do
          expect { Category.create_ideas!(' ', ' ') }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end