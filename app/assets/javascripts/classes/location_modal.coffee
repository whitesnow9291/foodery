class @LocationModal
  constructor: (@container) ->
    @modal = @container.find '.modal'
    @modal.modal
      backdrop: 'static'
      keyboard: false
      show: true
