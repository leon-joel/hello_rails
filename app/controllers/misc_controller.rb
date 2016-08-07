class MiscController < ApplicationController
  before_action :set_title

  def charactor
  end

  def find_mistake
    render :layout => false
  end

  def google_bar_chart
    render :layout => false
  end


  private
  def set_title
    @title = action_name
  end

end
