class TimeZoneDateSelectInput < Formtastic::Inputs::TimeSelectInput
  def value
     super.in_time_zone
   end

  def as
    'time_select'
  end
end
