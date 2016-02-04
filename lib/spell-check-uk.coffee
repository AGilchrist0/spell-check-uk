SpellCheckUkView = require './spell-check-uk-view'
{CompositeDisposable} = require 'atom'

module.exports = SpellCheckUk =
  spellCheckUkView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @spellCheckUkView = new SpellCheckUkView(state.spellCheckUkViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @spellCheckUkView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'spell-check-uk:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @spellCheckUkView.destroy()

  serialize: ->
    spellCheckUkViewState: @spellCheckUkView.serialize()

  toggle: ->
    console.log 'SpellCheckUk was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
