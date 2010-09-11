# Let's set the month title
setMonthTitle: (date) ->
  $('h2').text date.toString("MMMM")

$(()->
  date = Date.today()
  setMonthTitle(date)
)
