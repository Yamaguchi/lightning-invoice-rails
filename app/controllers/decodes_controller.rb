# frozen_string_literal: true

class DecodesController < ApplicationController
  def index
    redirect_to new_decode_path
  end

  def new
    @decode = Form::Decode.new
  end

  def create
    @decode = Form::Decode.new(decode_params)
    @decode.decode
    render :new
  rescue => e
    puts e.message
    puts e.backtrace
    @decode.errors.add(:base, 'An error has occurred') if @decode
    render :new, notice: 'An error has occurred'
  end

  def decode_params
    params.require(:decode).permit(:value)
  end
end
