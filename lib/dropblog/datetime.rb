Time::DATE_FORMATS[:article] ||= "%A, %B %d, %Y at %H:%M%p"

module RFC3339
  def rfc3339
    strftime('%Y-%m-%dT%H:%M:%S%z')
  end
end

class DateTime; include RFC3339; end
module ActiveSupport; class TimeWithZone; include RFC3339; end; end