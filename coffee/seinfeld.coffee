setMonthTitle: (date) ->
  $('h2').text date.toString("MMMM")

calcDaysInMonth: (day) ->
  day: day.moveToFirstDayOfMonth()
  month: day.getMonth()
  if not day.is().sunday()
      day.last().sunday()
  $('td.day').each () ->
    block: $ this
    block.text day.toString "d"
    if day.getMonth() != month
      block.addClass "other"
    day.addDays 1

$(()->
  date: Date.today()
  setMonthTitle date
  calcDaysInMonth date.clone()
)
