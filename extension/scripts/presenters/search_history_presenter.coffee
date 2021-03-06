class BH.Presenters.SearchHistoryPresenter extends BH.Presenters.Base
  constructor: (@visits, @query) ->

  history: (start, end) ->
    out = []
    if start? && end?
      for i in [start...end]
        out.push @markMatches(@visits[i]) if @visits[i]?
    out

  markMatches: (visit) ->
    for term in @query.split(' ')
      regExp = new RegExp(term, "i")
      visit.name = wrapMatchInProperty(regExp, visit.name)
      visit.location = wrapMatchInProperty(regExp, visit.location)
      visit.time = wrapMatchInProperty(regExp, visit.time)
      visit.extendedDate = wrapMatchInProperty(regExp, visit.extendedDate)
    visit

wrapMatchInProperty = (regExp, property) ->
  return unless property
  match = property.match(regExp)
  if match
    property.replace(regExp, '<span class="match">' + match + '</span>')
  else
    property
