$(()->
  date: Date.today()
  store: new Lawnchair "seinfeld"

  setMonthTitle: (date) ->
    $('.current').text date.toString("MMMM")

  calcDaysInMonth: (day) ->
    day: day.clone().moveToFirstDayOfMonth()
    month: day.getMonth()
    if not day.is().sunday()
        day.last().sunday()
    $('td.day').each () ->
      block: $ this
      block.removeClass "marked other"
      block.text day.toString "d"
      blockDate: day.toString "MMM-d"
      block.attr 'data-date', blockDate
      store.get blockDate, (r) ->
        if r?
          block.addClass "marked"
      if day.getMonth() != month
        block.addClass "other"
      day.addDays 1

  populatePage: () ->
    setMonthTitle date
    calcDaysInMonth date

  changePage: (num) ->
    ()->
      date.addMonths num
      populatePage()

  toggleMarked: ->
    block: $ this
    block.toggleClass "marked"
    if block.hasClass "marked"
      store.save {key: block.attr('data-date'), value: true}
    else
      store.remove block.attr 'data-date'

  $('a.explanation').click ->
    $(this).hide()
    $('ol.help').show "fast"
    false

  $('td.day').click toggleMarked
  $('a.next').click changePage 1
  $('a.previous').click changePage(-1)
  populatePage()
)
