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

  def initialize(attributes={})
    super
    @expiry ||= 3600
    @min_final_cltv_expiry ||= 9
  end

  def timestamp_as_string
    Time.at(@timestamp) if @timestamp
  end

  def encode
    return if invalid?
    message = Lightning::Invoice::Message.new
    message.prefix = @prefix
    message.amount = @amount.to_i if @amount.present?
    message.multiplier = @multiplier
    message.timestamp = @timestamp.to_i if @timestamp.present?
    message.signature = @signature
    message.payment_hash = @payment_hash
    message.description = @description
    message.pubkey = @pubkey
    message.description_hash = @description_hash
    message.expiry = @expiry.to_i if @expiry.present?
    message.min_final_cltv_expiry = @min_final_cltv_expiry.to_i if @min_final_cltv_expiry.present?
    message.fallback_address = @fallback_address if @fallback_address
    @decoded = Form::Decode.new(value: message.to_bech32)
  end

  def signature_r
    signature[0...64]
  end

  def signature_s
    signature[64...128]
  end

  def signature_flag
    signature[128..-1]
  end
end
