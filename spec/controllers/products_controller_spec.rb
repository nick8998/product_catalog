require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'Non autheticated user' do
    it 'returns 302 status' do
      get :index
      expect(response.code).to eq '302'
    end
  end

  describe 'Autheticated admin' do
    let(:user) { create(:user, admin: true) }
    let(:product) { create(:product) }
    before { login(user) }

    describe 'GET #index' do
      it 'returns 200 status' do
        get :index
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: product.id } }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns all public fields' do
        %w[id title created_at updated_at image_url description details hand].each do |attr|
          expect(JSON.parse(response.body)[attr]).to eq product.send(attr).as_json
        end
      end
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: product.id } }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'assigns the requested product to @product' do
        expect(assigns(:product)).to eq product
      end

      it 'returns all public fields' do
        %w[id title created_at updated_at image_url description details hand].each do |attr|
          expect(JSON.parse(response.body)[attr]).to eq product.send(attr).as_json
        end
      end
    end

    describe 'POST #create' do
      it 'save a new product in db with valid attributes' do
        expect { post :create, params: { product: attributes_for(:product) } }.to change(Product.all, :count).by(1)
      end

      it 'doesnt save a new product in db with invalid attributes' do
        expect { post :create, params: { product: attributes_for(:product, :invalid) } }.to_not change(Product, :count)
      end
    end

    describe 'PATCH #update' do
      it 'update product in db with valid attributes' do
        patch :update, params: { id: product.id, product: { title: 'new title', description: 'new desc' } }
        product.reload

        expect(product.title).to eq 'new title'
        expect(product.description).to eq 'new desc'
      end

      it 'doesnt save a new product in db with invalid attributes' do
        patch :update, params: { id: product.id, product: attributes_for(:product, :invalid) }
        product.reload

        expect(product.title).to eq product.title
        expect(product.description).to eq product.description
      end
    end

    describe 'DELETE #destroy' do
      let!(:product) { create(:product) }

      it 'deletes product' do
        expect { delete :destroy, params: { id: product } }.to change(Product.all, :count).by(-1)
      end
    end
  end

  describe 'Autheticated user' do
    let(:user) { create(:user) }
    let(:product) { create(:product) }
    let(:create_favorite) { post :add_to_favorite, params: { id: product.id } }
    before { login(user) }

    describe 'GET #index' do
      it 'returns 200 status' do
        get :index
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: product.id } }

      it 'returns 302 status' do
        expect(response.code).to eq '302'
      end
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: product.id } }

      it 'returns 302 status' do
        expect(response.code).to eq '302'
      end
    end

    describe 'POST #add_to_favorite' do
      it 'create product to favorite list' do
        expect { create_favorite }.to change(FavoriteProduct.all, :count).by(1)
      end
    end

    describe 'DELETE #delete_from_favorite' do
      before { create_favorite }
      it 'delete product from favorite list' do
        expect { delete :delete_from_favorite, params: { id: product.id } }.to change(FavoriteProduct.all, :count).by(-1)
      end
    end
  end
end
