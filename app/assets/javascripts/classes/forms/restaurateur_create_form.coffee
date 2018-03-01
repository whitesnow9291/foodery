class @RestaurateurCreateForm
  constructor: (@form) ->
    #@submit_btn = @form.find '.js-submit'
    #@file_text_field = @form.find 'input.js-file-text-field'
    @hours_open = @form.find ".hours_open input[type='text']"
    @hours_close = @form.find ".hours_close input[type='text']"
    @image_input = @form.find ".input-image"
    @pdf_input = @form.find ".input-pdf"

    @hours_open.datetimepicker
      format: 'HH:mm'
      useCurrent: true

    @hours_close.datetimepicker
      format: 'HH:mm'
      useCurrent: false

    @image_input.fileinput
      showPreview: false
      showUpload: false
      allowedFileTypes: 'image'
      allowedFileExtensions: ["jpg", "gif", "png", "jpeg"]

    @pdf_input.fileinput
      showPreview: false
      showUpload: false
      allowedFileExtensions: ["pdf"]

    @hours_open.on 'dp.change', (e) =>
      @hours_close.data('DateTimePicker').minDate(e.Date)

    @hours_close.on 'dp.change', (e) =>
      @hours_open.data('DateTimePicker').maxDate(e.Date)
