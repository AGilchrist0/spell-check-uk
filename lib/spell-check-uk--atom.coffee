SpellCheckUkAtomView = require './spell-check-uk--atom-view'
{CompositeDisposable} = require 'atom'

module.exports = SpellCheckUkAtom =
  spellCheckUkAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @spellCheckUkAtomView = new SpellCheckUkAtomView(state.spellCheckUkAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @spellCheckUkAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'spell-check-uk--atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @spellCheckUkAtomView.destroy()

  serialize: ->
    spellCheckUkAtomViewState: @spellCheckUkAtomView.serialize()

  toggle: ->
    console.log 'SpellCheckUkAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
