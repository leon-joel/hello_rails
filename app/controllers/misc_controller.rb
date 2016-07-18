class MiscController < ApplicationController
  before_action :set_title

  def charactor
  end

  def find_mistake
  end

  private
  def set_title
    @title = __method__
  end

end
