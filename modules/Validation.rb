# Validation module that check if a given variable is of a class

module Validation
  def is_a_boolean?(var)
    var.class == TrueClass || var.class == FalseClass
  end

  def is_a_string?(var)
    var.class == String
  end

  def are_strings?(*vars)
    vars.each do |var|
      return false if ( var.class != String )
    end
    return true
  end

  def is_a_number?(var)
    var.class == Integer || var.class == Float
  end

  def are_numbers?(*vars)
    vars.each do |var|
      return false if ( var.class != Integer && var.class != Float)
    end
    return true
  end

  def is_in_array?(var, array)
    array.include?(var)
  end

  def is_date_ISO3166?(var)
    #ISO3166 are country tag like 'FRA', so it must be 3 letters length and containing only letters
    var.class == String && var.length == 3 && is_containing_only_letters?(var)
  end

  def is_containing_only_letters?(var)
    # Regexp that match 3 lenght letters
    var.match("[a-zA-Z]{3}") ? true : false
  end
end
