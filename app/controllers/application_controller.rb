class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # ※実践RoR4 p.110～
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  # 継承関係のあるエラーは親を上に書かないといけない
  # 例）Forbidden < ActionControllerError < StandardError < Exception
  #     の場合は、Exceptionを上に、Forbiddenを下に書く。
  rescue_from Exception, with: :rescue500
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  rescue_from Forbidden, with: :rescue403
  rescue_from IpAddressRejected, with: :rescue403


  private
  def rescue403(e)
    @exception = e
    @title = '403 Forbidden'
    # デフォルトのlayoutではなくerror専用のlayoutを明示 ※nilを指定するとlayoutが適用されない
    render template: 'errors/forbidden', layout: 'errors', status: 403
  end
  def rescue404(e)
    @exception = e
    @title = '404 Not Found'
    # デフォルトのlayoutが適用されないように layout: nil を明示
    render template: 'errors/not_found', layout: 'errors', status: 404
  end
  def rescue500(e)
    @exception = e
    @title = '500 Internal Server Error'
    # デフォルトのlayoutが適用されないように layout: nil を明示 ※ページ全てのhtmlをtemplateが持っている場合
    render template: 'errors/internal_server_error', layout: nil, status: 500
  end
end
