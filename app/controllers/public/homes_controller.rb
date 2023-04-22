class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(creatad_at: :desc)
    @genres = Genre.all
  end

  def about
  end
end
