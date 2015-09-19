{CompositeDisposable} = require 'atom'

module.exports = SensibleTab =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'sensible-tab:show-prev-tab': => @showPrevTab()

  deactivate: ->
    @subscriptions.dispose()

  showPrevTab: ->
    active = atom.workspace.getActiveTextEditor();
    editors = atom.workspace.getTextEditors();
    editors = editors.sort (a, b) -> b.lastOpened - a.lastOpened

    if editors.length > 1
      prev = editors[1]
      for pane in atom.workspace.getPanes()
        index = pane.getItems().indexOf(prev)
        pane.activateItemAtIndex(index) if index?
