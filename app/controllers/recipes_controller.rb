class RecipesController < ApplicationController
  before_action :set_recipe, only: [:destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    if Rails.env.production?
      seed_val = Recipe.connection.quote(cookies[:rand_seed])
      Recipe.connection.execute("select setseed(#{seed_val})")
    end
    if params[:q] && params[:q].length > 0
      @queries = create_search_queries(params[:q].split.map { |string| "%" + string + "%" })
      if Rails.env.production?
        @recipes = Recipe.where(@queries[0]).or(Recipe.where(@queries[1])).order('random()').page(params[:page])
      else
        @recipes = Recipe.where(@queries[0]).or(Recipe.where(@queries[1])).page(params[:page])
      end
    elsif params[:q] && params[:q].length == 0
      redirect_to root_path
    else
      if Rails.env.production?
        @recipes = Recipe.all.order('random()').page(params[:page])
      else
        @recipes = Recipe.all.page(params[:page])
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def create_search_queries(array)
      name_query = ""
      description_query = ""
      array.each_with_index do |q, index|
        name_query << "name LIKE " << "'#{q}'"
        name_query << " OR " unless index == array.length - 1
        description_query << "description LIKE " << "'#{q}'"
        description_query << " OR " unless index == array.length - 1
      end
      [name_query, description_query]
    end
end
