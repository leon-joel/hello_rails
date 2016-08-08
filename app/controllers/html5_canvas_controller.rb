class Html5CanvasController < ApplicationController
  def stroke
    @title = "HTML5 Canvas - path, arc, stroke"
  end
  def drag_and_drop_image
    render :layout => false
  end


end
