class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_item(item)
    end
  end

  private

  def update_item(item)
    if item.name == "Aged Brie"
      update_aged_brie(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      update_backstage_passes(item)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      # Sulfuras is a legendary item and does not change
    elsif item.name.include?("Conjured")
      update_conjured(item)
    else
      update_normal_item(item)
    end
  end

  def update_aged_brie(item)
    item.quality = [item.quality + 1, 50].min
    item.sell_in -= 1
  end

  def update_backstage_passes(item)
    item.sell_in -= 1
    if item.sell_in >= 10
      item.quality = [item.quality + 1, 50].min
    elsif item.sell_in >= 5
      item.quality = [item.quality + 2, 50].min
    elsif item.sell_in >= 0
      item.quality = [item.quality + 3, 50].min
    else
      item.quality = 0
    end
  end

  def update_conjured(item)
    item.sell_in -= 1
    item.quality = [item.quality - 2, 0].max
  end

  def update_normal_item(item)
    item.sell_in -= 1
    item.quality = [item.quality - (item.sell_in >= 0 ? 1 : 2), 0].max
  end
end


class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
