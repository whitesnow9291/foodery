# $.fn.timify = (e) ->
  # this.each ->
    # item = $(this)
    # clone = $(item.clone())
    # currentTime = moment(item.val())
    # clone.val currentTime.format('HH:mm')
    # clone.prop
      # type: 'time'

    # item.parent().prepend(clone)
    # item.css
      # display: 'none'
    # clone.on 'input', ->
      # time = moment(clone.val(), 'HH:mm a')
      # currentTime.hours(time.hours())
      # currentTime.minutes(time.minutes())
      # val = currentTime.utc().format()
      # item.val(val)
      # console.log val
  # return this
# $ ->
    # $('#restaurant_hours_open').timify()
