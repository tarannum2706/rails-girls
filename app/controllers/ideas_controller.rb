class IdeasController < ApplicationController
  before_action :set_idea, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except:[:index,:show,:search]

  # GET /ideas or /ideas.json
  def index
    if user_signed_in?
      @pagy, @ideas = pagy(Idea.where(user_id: current_user),items:4)
    else
      @pagy, @ideas = pagy(Idea.order("created_at asc"), items:3)
    end
  end

  # GET /ideas/1 or /ideas/1.json
  def show
  end

  def search
    @ideas = Idea.where("name LIKE?", "%" + params[:q] + "%")
  end

  # GET /ideas/new
  def new
    @idea = current_user.ideas.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas or /ideas.json
  def create
    @idea = current_user.ideas.new(idea_params)
    respond_to do |format|
      if @idea.save
        format.html { redirect_to idea_url(@idea), notice: "Idea was successfully created." }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to idea_url(@idea), notice: "Idea was successfully updated." }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1 or /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: "Idea was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
       @idea = Idea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idea_params
      params.require(:idea).permit(:name, :description, :picture, :user_id)
    end
end
