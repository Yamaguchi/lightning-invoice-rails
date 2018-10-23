# frozen_string_literal: true

class Form::Encode
  include ActiveModel::Model

  attr_accessor :prefix, :amount, :multiplier, :timestamp, :signature, :payment_hash, :description, :pubkey, :description_hash, :expiry, :min_final_cltv_expiry, :fallback_address, :routing_info
  attr_accessor :decoded
  attr_accessor :timestamp_as_string

  validates :amount, numericality: { only_integer: true, greater_than_or_equal: 0 }, allow_blank: true
  validates :timestamp, numericality: { only_integer: true, greater_than_or_equal: 0}, allow_blank: true
  validates :expiry, numericality: { only_integer: true, greater_than_or_equal: 0 }, allow_blank: true
  validates :min_final_cltv_expiry, numericality: { only_integer: true, greater_than_or_equal: 0 }, allow_blank: true

  def initialize(args)
    super
    @routing_info = []
  end

  def timestamp_as_string
    Time.at(@timestamp) if @timestamp
  end

  def encode
    return if invalid?
    message = Lightning::Invoice::Message.new
    message.prefix = @prefix
    message.amount = @amount.to_i if @amount.present?
    message.multiplier = @multiplier  if @multiplier.present?
    message.timestamp = @timestamp.to_i if @timestamp.present?
    message.signature = @signature  if @signature.present?
    message.payment_hash = @payment_hash  if @payment_hash.present?
    message.description = @description  if @description.present?
    message.pubkey = @pubkey  if @pubkey.present?
    message.description_hash = @description_hash if @description_hash.present?
    message.expiry = @expiry.to_i if @expiry.present?
    message.min_final_cltv_expiry = @min_final_cltv_expiry.to_i if @min_final_cltv_expiry.present?
    message.fallback_address = @fallback_address if @fallback_address.present?
    message.routing_info = @routing_info.map do |r|
      Lightning::Invoice::RoutingInfo.new(
        r[0].pubkey,
        r[0].short_channel_id,
        r[0].fee_base_msat.to_i,
        r[0].fee_proportional_millionths.to_i,
        r[0].cltv_expiry_delta.to_i
      )
    end if @routing_info && !@routing_info.empty?
    @decoded = Form::Decode.new(value: message.to_bech32)
  end

  def signature_r
    return '' if signature.nil? || signature.empty?
    signature[0...64]
  end

  def signature_s
    return '' if signature.nil? || signature.empty?
    signature[64...128]
  end

  def signature_flag
    return '' if signature.nil? || signature.empty?
    signature[128..-1]
  end
end
