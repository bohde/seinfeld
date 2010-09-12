(function(){
  $(function() {
    var calcDaysInMonth, changePage, date, populatePage, setMonthTitle, store, toggleMarked;
    date = Date.today();
    store = new Lawnchair("seinfeld");
    setMonthTitle = function(date) {
      return $('.current').text(date.toString("MMMM"));
    };
    calcDaysInMonth = function(day) {
      var month;
      day = day.clone().moveToFirstDayOfMonth();
      month = day.getMonth();
      !day.is().sunday() ? day.last().sunday() : null;
      return $('td.day').each(function() {
        var block, blockDate;
        block = $(this);
        block.removeClass("marked other");
        block.text(day.toString("d"));
        blockDate = day.toString("MMM-d");
        block.attr('data-date', blockDate);
        store.get(blockDate, function(r) {
          return (typeof r !== "undefined" && r !== null) ? block.addClass("marked") : null;
        });
        day.getMonth() !== month ? block.addClass("other") : null;
        return day.addDays(1);
      });
    };
    populatePage = function() {
      setMonthTitle(date);
      return calcDaysInMonth(date);
    };
    changePage = function(num) {
      return function() {
        date.addMonths(num);
        return populatePage();
      };
    };
    toggleMarked = function() {
      var block;
      block = $(this);
      block.toggleClass("marked");
      return block.hasClass("marked") ? store.save({
        key: block.attr('data-date'),
        value: true
      }) : store.remove(block.attr('data-date'));
    };
    $('a.explanation').click(function() {
      $(this).hide();
      $('ol.help').show("fast");
      return false;
    });
    $('td.day').click(toggleMarked);
    $('a.next').click(changePage(1));
    $('a.previous').click(changePage(-1));
    return populatePage();
  });
})();
