$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module MsisdnGem
  VERSION = "0.0.6"
end

class Msisdn
  attr_accessor :original, :msisdn, :national_number, :dialing_code, :network, :country_code

  INTERNATIONAL_COUNTRY_CODE = /^\+(1|2[1-689]\d|2[07]|3[0-469]|3[578]\d|4[0-13-9]|42\d|5[09]\d|5[1-8]|6[0-6]|6[7-9]\d|7|8[035789]\d|8[1246]|9[0-58]|9[679]\d)(\d+)/
  INTERNATIONAL_COUNTRY_CODE_NO_PREFIX =   /(1|2[1-689]\d|2[07]|3[0-469]|3[578]\d|4[0-13-9]|42\d|5[09]\d|5[1-8]|6[0-6]|6[7-9]\d|7|8[035789]\d|8[1246]|9[0-58]|9[679]\d)(\d+)/
  EXACTLY_10_DIGITS = /^(\d{10})$/
  
  # Some countries with trunk code requirement for local dialling
  # See http://en.wikipedia.org/wiki/Telephone_numbering_plan
  # TODO: Special case until I need another country which don't
  # use trunk code and/or 10 digit number plan
  SPECIAL_CASES = {
    "995" => [9, '0']
  }

  def initialize(msisdn, default_country_code = nil)
    msisdn.gsub!( /[\s()\-a-zA-Z]/, '')
    @default_country_code = default_country_code

    @original = @msisdn = msisdn
    unless match_local(msisdn)
      match_international
    end
  end

  def international
    return nil if @country_code.nil?
    "#{@country_code}#{@network}#{@subscriber}"
  end
  
  def valid?
    return true if @network and @subscriber.length >= 7
    false
  end

  private
  def match_local(number)
    # Temp fix to get number working
    if(special_case = SPECIAL_CASES[@default_country_code])
      local_number_match = eval("/^(\\d{#{special_case[0]}})$/")
    else
      local_number_match = EXACTLY_10_DIGITS
    end
    
    if (number =~ local_number_match)
      @national_number = number
      @country_code ||= @default_country_code
      if @national_number =~ INTERNATIONAL_COUNTRY_CODE_NO_PREFIX # this also works for matching local numbers
        @network, @subscriber = $1, $2
      end
      return true
    end
    false
  end

  def match_international
    if @msisdn =~ INTERNATIONAL_COUNTRY_CODE
      @country_code, @national_number = $1, $2
      unless @national_number =~ /^0/
        params = SPECIAL_CASES[@country_code] || [10, '0']
        @national_number = @national_number.rjust(*params)
      end
      match_local @national_number
    else
      match_international_no_prefix
    end
  end

  def match_international_no_prefix
    if @msisdn =~ INTERNATIONAL_COUNTRY_CODE_NO_PREFIX
      @country_code, @national_number = $1, $2
      unless @national_number =~ /^0/
        params = SPECIAL_CASES[@country_code] || [10, '0']
        @national_number = @national_number.rjust(*params)
      end
      match_local @national_number
    end
  end

end