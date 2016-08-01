require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_foo
    items = [Item.new("foo", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
  end

  def test_general_items_before_expiration
    items = [Item.new("Dexterity Vest", 10, 20)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 19
  end

  def test_general_items_after_expiration
    items = [Item.new("Dexterity Vest", 10, 20)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 19
  end

  def test_general_items_min_quality
    items = [Item.new("Dexterity Vest", -100, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -101
    assert_equal items[0].quality, 0
  end

  def test_brie_before_expire
    items = [Item.new("Aged Brie", 2, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 1
    assert_equal items[0].quality, 1
  end

  def test_brie_after_expire
    items = [Item.new("Aged Brie", -1, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -2
    assert_equal items[0].quality, 1
  end

  def test_Sulfuras
    items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 0
    assert_equal items[0].quality, 80
  end

  def test_Sulfuras_after_expiration
    items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 80)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 80
  end

  def test_passes_15_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 14
    assert_equal items[0].quality, 21
  end

  def test_passes_10_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 22
  end

  def test_passes_5_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 4
    assert_equal items[0].quality, 23
  end

  def test_passes_after_expiration
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 0
  end

  def test_conjured_before_expiration
    items = [Item.new("Conjured Mana Cake", 3, 6)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 2
    assert_equal items[0].quality, 4
  end

  def test_conjured_after_expiration
    items = [Item.new("Conjured Mana Cake", 0, 6)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 2
  end

  def test_specialty_min
    items = [Item.new("Conjured Mana Cake", 1, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 0
    assert_equal items[0].quality, 0
  end

  def test_specialty_max
    items = [Item.new("Aged Brie", -100, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -101
    assert_equal items[0].quality, 50
  end
end
