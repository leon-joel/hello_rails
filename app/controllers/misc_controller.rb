class MiscController < ApplicationController
  before_action :set_title

  def charactor
  end

  def find_mistake
  end

  def slideshow
  end

  private
  def set_title
    @title = action_name
  end

end
