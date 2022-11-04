class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: %i[edit show update destroy add_to_favorite delete_from_favorite]
  before_action :catch_products, only: %i[index sort_by]

  def index
    @products = Product.paginate(page: params[:page], per_page: 5)
    authorize @products, :index?
    render json: @products
  end

  def edit
    authorize :product, :update?
    render json: @product
  end

  def show
    authorize :product, :update?
    render json: @product
  end

  def create
    authorize :product, :create?
    @product = Product.new(product_params)
    if @product.save
      render json: @product
    else
      head :ok
    end
  end

  def update
    authorize :product, :update?
    if @product.update(product_params)
      render json: @product
    else
      render json: { status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize :product, :destroy?
    @product.destroy
    if @product.errors.any?
      render json: { status: :unprocessable_entity }, status: :unprocessable_entity
    else
      head :ok
    end
  end

  def add_to_favorite
    favorite_p = new_favorite(@product)
    if favorite_p.save
      render json: favorite_p
    else
      head :ok
    end
  end

  def delete_from_favorite
    @product.favorite_products.delete(find_favorite(@product).first.id) if find_favorite(@product).present?
    if @product.errors.any?
      render json: { status: :unprocessable_entity }, status: :unprocessable_entity
    else
      head :ok
    end
  end

  def sort_by
    case params[:sort]
    when 'hand'
      render json: @products.order_by_hand
    when 'update'
      render json: @products.order_by_update
    else
      render json: { status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def new_favorite(product_i)
    FavoriteProduct.new(user: current_user, product: product_i)
  end

  def find_favorite(product_i)
    FavoriteProduct.where(product: product_i).where(user: current_user)
  end

  def product_params
    params.require(:product).permit(:title, :description, :details, :hand, :image_url)
  end

  def catch_products
    @products = Product.paginate(page: params[:page], per_page: 5)
  end
end
