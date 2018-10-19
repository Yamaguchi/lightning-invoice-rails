# frozen_string_literal: true

class EncodesController < ApplicationController
  def index
    redirect_to new_decode_path
  end

  def new
    @encode = Form::Encode.new
  end

  def create
    @encode = Form::Encode.new(encode_params)
    @encode.encode
    render :new
  rescue => e
    puts e.backtrace
    @encode.errors.add(:base, 'An error has occurred')
    render :new, notice: 'An error has occurred'
  end

  def encode_params
    params.require(:encode).permit(
      :prefix,
      :amount,
      :multiplier,
      :timestamp,
      :signature,
      :payment_hash,
      :description,
      :pubkey,
      :description_hash,
      :expiry,
      :min_final_cltv_expiry,
      :fallback_address,
      :routing_info
    )
  end
end