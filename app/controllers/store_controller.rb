class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:index]
  def index
    @products = Product.order('popularity DESC')

    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] = session[:counter] + 1

    if (session[:counter] >=6)
      flash[:notice]= "You\'ve been on this page " +
      ActionController::Base.helpers.pluralize(session[:counter], 'time') +
      " without purchasing anything ... Come on!"
    end

  end
end
