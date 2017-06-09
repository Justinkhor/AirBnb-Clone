class StaticController < ApplicationController
  def index
    # unless signed_in?
    #   redirect_to sign_in_path
    # end
    @listings = Listing.all.order('created_at DESC').paginate(:page => params[:page]).per_page(20)
    get_pokemon_url
  end
  def get_pokemon_url
    response = RestClient.get("http://pokeapi.co/api/v2/pokemon/#{rand(1..201)}/")
    result = JSON.parse(response.body)

    @pokemon_url = result["sprites"]["front_default"]
    @pokemon_name = result["name"]
    @pokemon_no = result["id"]
    @pokemon_type = result["types"][0]["type"]["name"]
  end
end
