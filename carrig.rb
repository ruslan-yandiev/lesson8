# frozen_string_literal: true

# rubocop get the f..k out
class Carrig
  include TrainCarrige

  NUMBER_FORMAT = /^[0-9a-zа-я]{3}-?[0-9a-zа-я]{2}$/i.freeze
  NAME_FORMAT = /^[а-яa-z]+\D/i.freeze

  attr_reader :number, :amount

  def initialize(number, amount)
    @number = number
    @amount = amount
    @amount_now = 0
    @status = false
    name_manufacturer!
    validate!
  end

  def increase_amount(amount)
    if @amount_now + amount >  @amount
      puts 'Недостаточно места в вагоне!!!'
    elsif amount <= @amount
      @amount_now += amount
      free_amount
    else
      puts "Вагон может вместить только #{@amount} !!!"
    end
  end

  def free_amount
    @amount - @amount_now
  end

  def show_amount_now
    @amount_now
  end

  def show_free_amount
    free_amount
  end

  def valid?
    !!validate!
  end

  def validate!
    raise 'Number can`t be nil' unless @number
    raise 'Name manufacturer can`t be nil' unless @name_manufacturer
    raise 'Name manufacturer can`t be empty string' if @name_manufacturer == ''
    raise 'Number has invalid format' if @number !~ NUMBER_FORMAT
    if @name_manufacturer !~ NAME_FORMAT
      raise 'Name manufacturer has invalid format'
    end
  end

  def change_status(train)
    train.carrig.include?(self) ? connect : disconnect
  end

  def connect
    @status = true
  end

  def disconnect
    @status = false
  end

  def to_s
    "Тип вагона: #{self.class}, номер: #{number},
    \r\nсоединен ли с поездом: #{@status}, производитель #{name_manufacturer} "
  end

  protected :connect, :disconnect, :validate!
end
