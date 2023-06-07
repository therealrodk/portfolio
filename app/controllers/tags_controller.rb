class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_all_tags, only: [:index, :destroy]
  before_action :set_tag, only: [:show, :destroy, :update]

  def index
  end

  def show
  end

  def update
    new_tag_name = params[:name]
    if @tag.update(name: new_tag_name)
      redirect_to tag_path(@tag), notice: 'Tag was successfully updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    if @all_tags.find_by(name: @tag.name)&.destroy
      redirect_to tags_path, notice: 'Tag was successfully removed.'
    else
      redirect_back fallback_location: tags_path, alert: 'Tag was not removed.'
    end
  end

  private

  def set_tag
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def set_all_tags
    @all_tags = ActsAsTaggableOn::Tag.all.order(name: :asc)
  end
end
