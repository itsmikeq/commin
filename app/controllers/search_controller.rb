class SearchController < ApplicationController

  def search
    render json: Search.search(params[:query])
  end

  def autocomplete
    results = {}
    if search_params[:query]
      results = Search.autocomplete(search_params[:query], search_params[:per_page], @country_code)
    end

    api_response data: {terms: results}
  end

  private
  def search_params
    params.permit(:query, :genre, :per_page)
  end

end
