module JobsHelper

  def time_spent_hours seconds
    time_words = ""

    return "0" if seconds < 1.minute

    if seconds >= 1.hour
      hour_done = (seconds / 1.hour).floor
      time_words += hour_done.to_s + (seconds/1.hour > 1 ? " hrs " : " hr ")
     
    end

    minutes_done = (seconds % 1.hour) / 1.minutes
    time_words += minutes_done.to_s + (minutes_done > 1 ? " mins" : " min ")

    time_words

  end

end
