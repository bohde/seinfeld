setMonthTitle: (date) ->
  $('.current').text date.toString("MMMM")

calcDaysInMonth: (day) ->
  day: day.clone().moveToFirstDayOfMonth()
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
  populatePage: () ->
    setMonthTitle date
    calcDaysInMonth date
  changePage: (num) ->
    ()->
      date.addMonths num
      populatePage()
  $('a.next').click changePage 1
  $('a.previous').click changePage(-1)
  populatePage()
)
