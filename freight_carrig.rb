# frozen_string_literal: true

class FreightCarrig < Carrig
  def to_s
    super + "грузоподъемность: #{@amount}, загружен на #{@amount_now}кг., недогруз #{free_amount}кг."
  end
end
