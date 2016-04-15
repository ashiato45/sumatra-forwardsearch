SumatraForwardsearchView = require './sumatra-forwardsearch-view'
{CompositeDisposable} = require 'atom'
{BufferedProcess} = require 'atom'

module.exports = SumatraForwardsearch =
  sumatraForwardsearchView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @sumatraForwardsearchView = new SumatraForwardsearchView(state.sumatraForwardsearchViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @sumatraForwardsearchView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sumatra-forwardsearch:forwardseach': => @forwardsearch()

    this.forwardsearch()


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @sumatraForwardsearchView.destroy()

  serialize: ->
    sumatraForwardsearchViewState: @sumatraForwardsearchView.serialize()

  forwardsearch: ->
    path = require("path")
    command = path.join(__dirname, 'calldde.exe');
    editor = atom.workspace.getActiveTextEditor();
    filename = editor.getPath()
    args = [filename, (editor.cursors[0].getBufferRow() + 1).toString()]
    stdout = (output) ->
    exit = (code) ->
    process = new BufferedProcess({command, args, stdout, exit})
