class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(creatad_at: :desc)
  end

  def about
  end
end
