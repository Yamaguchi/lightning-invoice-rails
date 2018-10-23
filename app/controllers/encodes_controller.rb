# frozen_string_literal: true

class EncodesController < ApplicationController
  def index
    redirect_to new_decode_path
  end

  def new
    @encode = Form::Encode.new({})
  end

  def create
    @encode = Form::Encode.new(encode_params)
    params['routing_info'] && params['routing_info'].each do |routing_info|
      @encode.routing_info << [Lightning::Invoice::RoutingInfo.new(
        routing_info['pubkey'],
        routing_info['short_channel_id'],
        routing_info['fee_base_msat'],
        routing_info['fee_proportional_millionths'],
        routing_info['cltv_expiry_delta']
      ), @encode.routing_info.size]
    end
    @encode.encode
    render :new
  rescue => e
    puts e.message
    puts e.backtrace
    @encode.errors.add(:base, 'An error has occurred') if @encode
    render :new, notice: 'An error has occurred'
  end

  def routing_info
    @routing = Lightning::Invoice::RoutingInfo.new(
      "",
      "",
      0,
      0,
      0
    )
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