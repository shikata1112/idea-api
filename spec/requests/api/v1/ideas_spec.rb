require 'rails_helper'

describe 'IndexApi' do
  before do
    @category1 = Category.create!(name: 'アプリ')
    @category2 = Category.create!(name: 'スポーツ')
    @category3 = Category.create!(name: '会議')
    @idea1 = Idea.create!(category_id: @category1.id, body: 'タスク管理アプリ')
    @idea2 = Idea.create!(category_id: @category2.id, body: '野球')
    @idea3 = Idea.create!(category_id: @category2.id, body: 'サッカー')
  end

  context 'パラメータにcategory_nameが存在するとき' do
    context 'パラメータのcategory_nameをもつcategoryデータが存在するとき' do
      it 'categoryデータに紐づくideasを返すこと' do
        get "/api/v1/ideas?category_name=#{CGI.escape @category2.name}"

        expect(response.status).to eq 200
        expect(json['data'].size).to eq 2
      end
    end

    context 'パラメータのcategory_nameをもつcategoryデータが存在しないとき' do
      it 'ステータスコード404を返すこと' do
        get '/api/v1/ideas?category_name=hogehoge'

        expect(response.response_code).to eq 404
      end
    end
  end

  context 'パラメータにcategory_nameが存在しないとき' do
    it 'ideaを全て返すこと' do
      get '/api/v1/ideas'
      
      expect(response.status).to eq 200
      expect(json['data'].size).to eq 3
    end
  end
end
