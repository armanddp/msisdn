require File.dirname(__FILE__) + '/test_helper'

class MsisdnTest < Test::Unit::TestCase

  def test_international_dial_code
    msisdn = Msisdn.new('+27825559629') 
    assert_equal '27', msisdn.country_code
  end

  def test_national_number_converter_with_default_code
    msisdn = Msisdn.new('0825559629', '27') 
    assert_equal '27', msisdn.country_code
    assert_equal '27825559629', msisdn.international
  end
  
  def test_national_number_converter_with_no_default_code
    msisdn = Msisdn.new('0825559629') 
    assert_nil msisdn.country_code
  end

  def test_international_number_without_plus
    msisdn = Msisdn.new('27825559629') 
    assert_equal '27', msisdn.country_code
    assert_equal '27825559629', msisdn.international
  end
  
  def test_three_digit_international_code
    msisdn = Msisdn.new('+994825559629')
    assert_equal '994', msisdn.country_code
    assert_equal '0825559629', msisdn.national_number
  end
  
  def test_american_international_number
    msisdn = Msisdn.new '718-258-5200'
    assert_equal '7182585200', msisdn.national_number
    assert_nil msisdn.country_code
    assert_nil msisdn.international
  end

  def test_russian_international_number_with_country_code
    msisdn = Msisdn.new '79261234567'
    assert_equal '9261234567', msisdn.national_number
    assert_equal '7', msisdn.country_code
    assert_equal '79261234567', msisdn.international
  end
  
  def test_russian_international_number_without_country_code_but_with_default
    msisdn = Msisdn.new '926-123-4567', '7'
    assert_equal '9261234567', msisdn.national_number
    assert_equal '7', msisdn.country_code
    assert_equal '79261234567', msisdn.international
  end
  
  def test_georgian_international_number
    msisdn = Msisdn.new('99577100060')
    assert_equal '995', msisdn.country_code
    assert_equal '077100060', msisdn.national_number
  end
  
  def test_georgian_national_number
    msisdn = Msisdn.new('077100060', '995')
    assert_equal '995', msisdn.country_code
    assert_equal '077100060', msisdn.national_number
  end
  
  def test_valid_national_number
    msisdn = Msisdn.new '0825559629'
    assert msisdn.valid?
  end
  
  def test_invalid_national_number
    msisdn = Msisdn.new '082555'
    assert false == msisdn.valid?
  end
  
  def test_valid_international_number
    msisdn = Msisdn.new('27825559629')
    assert msisdn.valid?
  end
  
  def test_invalid_international_number
    msisdn = Msisdn.new('278259629')
    assert false == msisdn.valid?
  end

end