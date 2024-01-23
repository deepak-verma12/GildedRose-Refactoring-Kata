require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  it "does not change the name" do
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    expect(items[0].name).to eq "foo"
  end
end

describe '#update_quality' do
  context 'when updating quality for a Conjured item' do
    it 'decreases quality by 2 and decreases sell-in by 1' do
      conjured_item = Item.new("Conjured Mana Cake", 5, 20)
      gilded_rose = GildedRose.new([conjured_item])

      gilded_rose.update_quality()

       expect(conjured_item.sell_in).to eq(4)
       expect(conjured_item.quality).to eq(18)
    end
  
    it 'does not decrease quality below 0' do
      conjured_item = Item.new("Conjured Mana Cake", 0, 1)
      gilded_rose = GildedRose.new([conjured_item])

      gilded_rose.update_quality()

      expect(conjured_item.quality).to eq(0)
    end
  end
end