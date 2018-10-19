# frozen_string_literal: true

class Form::Decode
  include ActiveModel::Model

  attr_accessor :value
  attr_accessor :encoded

  def decode
    return if invalid?
    @encoded = Form::Encode.new(Lightning::Invoice.parse(value).to_h)
  end
end
