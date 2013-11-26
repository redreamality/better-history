class BH.Views.SignUpInfoView extends BH.Views.ModalView
  @include BH.Modules.I18n

  className: 'sign_up_info_view'
  template: BH.Templates['sign_up_info']

  events:
    'click .continue': 'continueClicked'
    'click .cancel': 'cancelClicked'

  initialize: ->
    @chromeAPI = chrome
    @tracker = @options.tracker
    @attachGeneralEvents()

  render: ->
    @$el.html(@renderTemplate(@getI18nValues()))

    $.ajax
      url: "http://#{apiHost}/purchase"
      contentType: 'application/json'
      dataType: 'json'
      success: (data) =>
        if data.open
          # Registration is open!
        else
          @closeRegistration()
      error: =>
          @closeRegistration()

    return this

  closeRegistration: ->
    @$('.continue').remove()
    @$('.cancel').remove()
    @$('.action-area').text @t('sign_up_temporarily_closed')
    @$('.action-area').css color: 'red'

  cancelClicked: (ev) ->
    ev.preventDefault()
    @close()

  continueClicked: (ev) ->
    ev.preventDefault()
    @close()

    userProcessor = new BH.Lib.UserProcessor()
    userProcessor.start()

  getI18nValues: ->
    properties = @t ['prompt_cancel_button', 'continue_button', 'sign_up_info_title', 'sign_up_info_description', 'sign_up_info_price']
    properties.i18n_sign_up_info_bullets = @t 'sign_up_info_bullets', ['<li>','</li>', '<a href="http://better-history.com">', '</a>']
    properties
