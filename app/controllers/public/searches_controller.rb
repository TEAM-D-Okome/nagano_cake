class Public::SearchesController < ApplicationController
  def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
  end
end
