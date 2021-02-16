require 'rails_helper'

describe 'index アクション' do
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
        get api_v1_ideas_path, params: { category_name: @category2.name }

        expect(response.status).to eq 200
        expect(json['data'].size).to eq 2
      end
    end

    context 'パラメータのcategory_nameをもつcategoryデータが存在しないとき' do
      it 'ステータスコード404を返すこと' do
        get api_v1_ideas_path, params: { category_name: 'hogehoge' }

        expect(response.response_code).to eq 404
      end
    end
  end

  context 'パラメータにcategory_nameが存在しないとき' do
    it 'ideaを全て返すこと' do
      get api_v1_ideas_path
      
      expect(response.status).to eq 200
      expect(json['data'].size).to eq 3
    end
  end

  context 'category_name以外のパラメータがリクエストされたとき' do
    it 'ideaを全て返すこと' do
      get api_v1_ideas_path, params: { hoge: 'hogehuga' }
      
      expect(response.status).to eq 200
      expect(json['data'].size).to eq 3
    end
  end
end

describe 'create アクション' do
  before do
    @category1 = Category.create!(name: 'アプリ')
  end

  context 'パラメータのcategory_nameをもつcategoryデータが存在するとき' do
    context 'リクエストが正常であるとき' do
      it '既存のcategoryをcategory_idとしてideaを保存すること' do
        expect { post api_v1_ideas_path, params: { category_name: @category1.name, body: '家計簿アプリ' } }.to change(Idea, :count).by(+1)
        expect(response.status).to eq 201
      end
    end

    context 'リクエストが正常でないとき' do
      it 'ステータスコード422を返し、保存に失敗すること' do
        post api_v1_ideas_path, params: { category_name: @category1.name, body: ' ' }
        
        expect(response.status).to eq 422
      end
    end
  end
  
  context 'パラメータのcategory_nameをもつcategoryデータが存在しないとき' do
    context 'リクエストが正常であるとき' do
      it '新たなcategoryとして保存し、ideaを保存すること' do
        expect { post api_v1_ideas_path, params: { category_name: 'スポーツ', body: 'テニス' } }.to change(Idea, :count).by(+1)
        expect(response.status).to eq 201
      end
    end

    context 'category_nameが空であるとき' do
      it 'ステータスコード422を返し、保存に失敗すること' do
        post api_v1_ideas_path, params: { category_name: ' ', body: 'バスケットボール' }

        expect(response.status).to eq 422
      end
    end

    context '新たなcategory_nameが存在し、bodyが空であるとき' do
      it 'ステータスコード422を返し、保存に失敗すること' do
        post api_v1_ideas_path, params: { category_name: '健康', body: ' ' }
        # TODO: categoryだけ保存されることを修正予定

        expect(response.status).to eq 422
      end
    end
  end
end