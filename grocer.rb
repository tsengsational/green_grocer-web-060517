require 'pry'

def consolidate_cart(cart)
  # code here
  consolidated = Hash.new
  cart.each do |hash|
    hash.each do |item, attribute|
      if !consolidated.include?(item)
        consolidated[item] = attribute
        consolidated[item][:count] = 1
      else
        consolidated[item][:count] += 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
		item = coupon[:item]
    if cart.include?(item) && cart[item][:count] >= coupon[:num]
			if cart.include?("#{item} W/COUPON")
				cart["#{item} W/COUPON"][:count] += 1
			else
				cart["#{item} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[item][:clearance],
          :count => 1
        }
			end
			new_item_count = cart[item][:count] - coupon[:num]
			cart[item][:count] = new_item_count
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
	cart.each do |item, attribute|
		if attribute[:clearance] == true
			new_price = attribute[:price] * 0.8
			attribute[:price] = new_price.round(2)
		end
	end
end

def checkout(cart, coupons)
  # code here
	cartNew = consolidate_cart(cart)
	cartNew = apply_coupons(cartNew, coupons)
  cartNew = apply_clearance(cartNew)

  total = 0
  cartNew.each do |item, attribute|
    subtotal = 0
    subtotal = cartNew[item][:price] * cartNew[item][:count]
    total += subtotal
  end

  if total > 100
    total *= 0.9
  end
  total
end
