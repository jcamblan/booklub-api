# frozen_string_literal: true

class ClubsController < ApplicationController
  def index; end

  def create
    @club = Club.new(club_params.merge(manager: current_user))

    if @club.save
      redirect_to @club, notice: 'Club was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @club = Club.new
  end

  def show
    @club = Club.find(params[:id])
  end

  private

  def club_params
    params.require(:club).permit(:name)
  end
end
