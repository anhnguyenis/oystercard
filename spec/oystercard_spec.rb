require './lib/oystercard'

describe Oystercard do
  it 'checks that the oystercard has a balance' do
    oyster = Oystercard.new
    expect(oyster.balance).to eq(0)
  end

  it 'tops up balance of oystercard' do
    oyster = Oystercard.new
    amount = 10
    oyster.topup(amount)
    expect(oyster.balance).to eq(amount)
  end

  it 'raises an error if topped up beyond £90' do
    oyster = Oystercard.new
    amount = 10
    9.times { oyster.topup(amount) }
    expect { oyster.topup(amount) }.to raise_error "Over limit of £#{Oystercard::MAXBALANCE}"
  end


  it 'touches in if over minimum fare' do
    oyster = Oystercard.new
    oyster.topup(10)
    expect { oyster.touch_in}.to change{ oyster.status }.from(false).to(true)
  end

  it 'touches out' do
    oyster = Oystercard.new
    oyster.topup(10)
    oyster.touch_in
    expect { oyster.touch_out}.to change{ oyster.status }.from(true).to(false)
  end

  it 'knows it is in journey' do
     oyster = Oystercard.new
     oyster.topup(10)
     oyster.touch_in
     expect(oyster.in_journey?).to be(true)
  end

  it 'raises an error if touched in below minimum fare' do
    oyster = Oystercard.new
    expect { oyster.touch_in }.to raise_error "Balance must be over £#{Oystercard::MINBALANCE}"
  end

 it 'reduces balance by minimum fare when touches out' do
   oyster = Oystercard.new
   oyster.topup(10)
   expect { oyster.touch_out }.to change { oyster.balance }.by(-1)
 end
end
