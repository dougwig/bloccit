class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new()
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "you need to be an admin to do that."
  end



  def create
    #@topic = Topic.new(params[:topic])
      @topic = Topic.new(post_params)
      authorize! :create, @topic, message: "you need to be an admin to do that"
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update 
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it."

     if @topic.update_attributes(post_params)
        redirect_to @topic, notice: "Topic was saved successfully."
      else
        flash[:error] = "Error saving topic. Please try again"
        render :edit
      end
    end


  private

  def post_params
       params.require(:topic).permit(:description, :name, :public, :topic)

    end

end
