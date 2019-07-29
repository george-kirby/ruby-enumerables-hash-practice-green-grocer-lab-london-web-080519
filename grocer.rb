def consolidate_cart(cart)
  # code here
  
  cart_hash = {}
  
  for item in cart
    item.reduce(cart_hash) do |cart_hash, (key, value)|
      if cart_hash.include?(key) #if >=1 item already in cart
        cart_hash[key][:count] += 1 
      else
        #create new pair, with count of 1
        cart_hash[key] = value
        cart_hash[key][:count] = 1
      end
    cart_hash
    end
  end
  
  cart_hash
end



def apply_coupons(cart, coupons)
  # code here
  
  cart_after_coupons_applied = cart.reduce({}) do |memo, (key, value)|
    if coupons.find {|i| i[:item] == key} 
    # if coupons contains a coupon for that item
      active_coupon = coupons.find {|i| i[:item] == key}
      p "Active coupon is #{active_coupon}"
      if value[:count] >= active_coupon[:num] 
      #if enough of item to use coupon
        # add couponed items to memo
        p memo
        memo["#{key} W/COUPON"] = {
          price: (active_coupon[:cost]/active_coupon[:num]),
          clearance: cart[key][:clearance],
          count: active_coupon[:num]
        }
        p memo

        #remove that coupon from coupons array - it's been used!
        p coupons
        coupons.delete_at(coupons.index(coupons.find {|i| i[:item] == key}))
        p coupons
        memo

        # how any items left after using coupon?
        num_items_left_after_coupon = (value[:count] - active_coupon[:num])
        if num_items_left_after_coupon >= active_coupon[:num] 
          # potentially another coupon could be used
          if coupons.find {|i| i[:item] == key}
            another_coupon = coupons.find {|i| i[:item] == key}
            p "Another coupon found: #{another_coupon}"
            # increase :count of this item W/COUPON
            p memo
            memo["#{key} W/COUPON"][:count] += another_coupon[:num]
            p memo
          end

        else 
          # add items left after applying coupons to memo
          p memo
          memo[key] = {
            price: value[:price],
            clearance: value[:clearance],
            count: num_items_left_after_coupon
          }
          p memo
        end

      
      else # not enough of that item for coupon to apply
      # add item pair to cart_after_coupons_applied, as is
          p memo
          memo[key] = value
          p memo
      end
      
    else # no coupon for that item
    # add item pair to cart_after_coupons_applied as is
      p "No coupon found"
      p memo
      memo[key] = value
      p memo

    end  

  end
  cart_after_coupons_applied
end


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
