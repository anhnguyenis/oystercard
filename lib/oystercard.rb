class Oystercard
attr_reader :balance, :entry_station, :journey_history
MAXBALANCE = 90
MINBALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def topup(amount)
    fail "Over limit of £#{MAXBALANCE}" unless @balance < MAXBALANCE
    @balance += amount
  end

  def touch_in(station)
   fail "Balance must be over £#{MINBALANCE}" unless @balance > MINBALANCE
   @entry_station = station
   @journey_history << station
  end

  def touch_out(station)
    @entry_station = nil
    deduct(1)
    @journey_history << station
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
