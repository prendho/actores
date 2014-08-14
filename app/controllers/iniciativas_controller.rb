class IniciativasController < ApplicationController
  include Answerable

  before_action :require_login
  before_action :find_iniciativa, only: [:show, :edit, :update, :destroy]

  def new
    @iniciativa = actor.iniciativas.new
  end

  def edit
  end
  alias_method :show, :edit

  def create
    @iniciativa = actor.iniciativas.new(iniciativa_params)
    if @iniciativa.save
      @iniciativa.create_activity :create, owner: current_user, params: iniciativa_params
      flash.now[:notice] = "Iniciativa creada"
      redirect_to action: :show, id: @iniciativa.id
    else
      render :new
    end
  end

  def update
    if @iniciativa.update(iniciativa_params)
      @iniciativa.create_activity :update, owner: current_user, params: iniciativa_params
      flash.now[:notice] = "Iniciativa actualizada"
      redirect_to action: :show, id: @iniciativa.id
    else
      render :edit
    end
  end

  def destroy
    @iniciativa.create_activity :destroy, owner: current_user, params: @iniciativa.attributes.slice("nombre", "descripcion")
    @iniciativa.destroy
    flash.now[:notice] = "Iniciativa eliminada"
    redirect_to actor_path(actor)
  end

  protected

  def iniciativa
    @iniciativa ||= Iniciativa.find(params[:id])
  end
  helper_method :iniciativa
  alias_method :resource, :iniciativa
  helper_method :resource

  def actor
    @actor ||= Actor.find(params[:actor_id])
  end
  helper_method :actor

  private

  def find_iniciativa
    @iniciativa = Iniciativa.find(params[:id])
  end

  def iniciativa_params
    params.require(:iniciativa).permit :nombre, :descripcion
  end

  def set_active_item
    @active_item = :actores
  end

  def grupo_preguntas_kind
    :iniciativa
  end
end
