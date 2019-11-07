class Oystercard
attr_reader :balance, :status, :entry_station
MAXBALANCE = 90
MINBALANCE = 1

  def initialize
    @balance = 0
    @status = false
  end

  def topup(amount)
    fail "Over limit of £#{MAXBALANCE}" unless @balance < MAXBALANCE
    @balance += amount
  end

  def touch_in(station)
   fail "Balance must be over £#{MINBALANCE}" unless @balance > MINBALANCE
   @entry_station = station
    @status = true
  end

  def touch_out
    @entry_station = nil
    deduct(1)
    @status = false
  end

  def in_journey?
    @status
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
