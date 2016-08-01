class GildedRose
  SPECIALTY_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros", "Conjured Mana Cake"]
  STATIC_ITEMS = ["Sulfuras, Hand of Ragnaros"]
  GENERAL_QUALITY_RATE = 1

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if SPECIALTY_ITEMS.include?(item.name)
        specialty_quality_rules(item)
      else
        general_quality_rules(item)
      end

      validate_min_max_quality(item)
      decrement_sell_in(item)
    end
  end

  def general_quality_rules(item)
    if item.sell_in >= 1
      item.quality -= GENERAL_QUALITY_RATE
    else
      item.quality -= GENERAL_QUALITY_RATE * 2
    end
  end

  def specialty_quality_rules(item)
    #given more time I'd build a method to dynamically look at names and route to methods
    case item.name
    when "Aged Brie"
      brie(item)
    when "Sulfuras, Hand of Ragnaros"
      sulfuras(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      backstage_passes(item)
    when "Conjured Mana Cake" #need to actually make this a regex for 'Conjured' + anything
      conjured(item)
    else
      puts "Not sure what the item is"
    end
  end

  def validate_min_max_quality(item)
    # never let quality drop below 0, except for static values
    if STATIC_ITEMS.include? item.name
      return
    elsif item.quality < 0
      item.quality = 0
    elsif item.quality > 50
      item.quality = 50
    end
  end

  def decrement_sell_in(item)
    item.sell_in -= 1 unless STATIC_ITEMS.include? item.name
  end

  def brie(item)
    item.quality += GENERAL_QUALITY_RATE
  end

  def conjured(item)
    item.sell_in >= 1 ? item.quality -= GENERAL_QUALITY_RATE * 2 : item.quality -= GENERAL_QUALITY_RATE * 4
  end

  def backstage_passes(item)
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5
      item.quality += GENERAL_QUALITY_RATE * 3
    elsif item.sell_in <= 10
      item.quality += GENERAL_QUALITY_RATE * 2
    else
      item.quality += GENERAL_QUALITY_RATE * 1
    end
  end

  def sulfuras(item)
    "I shall not be changed"
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
