class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def frontend_index_html
    render file: 'public/index.html'
  end

  def render_404
    render json: { error: "Not Found" }, status: 404
  end
end
