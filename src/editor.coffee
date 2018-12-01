module.exports =
class Editor
    editorWidthPercentage = 30;
    constructor: (@loaderFunc, loader) ->
        $editorBox = $($.parseHTML '<div id="edit-column" class="column"></div>')
        $editorBox.width(editorWidthPercentage+'%')
        $('#net-column').width((100-editorWidthPercentage)+'%')
        $('#table-container').width((100-editorWidthPercentage)+'%')
        #$('#master-container').prepend $editorBox
        $editorBox.insertBefore('#net-column')
        preset = loader.dataLoaded ? '# Enter your network definition here.\n# Use Shift+Enter to update the visualization.'
        @editor = CodeMirror $editorBox[0],
            value: preset
            lineNumbers : true
            lineWrapping : true
        @editor.on 'keydown', (cm, e) => @onKeyDown(e)

    reload: (@loaderFunc, loader) ->
        preset = loader.dataLoaded ? '# Enter your network definition here.\n# Use Shift+Enter to update the visualization.'
        @editor.setValue(preset)
        $('#edit-column').width(editorWidthPercentage+'%')
        $('#net-column').width((100-editorWidthPercentage)+'%')
        $('#table-container').width((100-editorWidthPercentage)+'%')
        #alert(preset)

    onKeyDown: (e) ->
        if (e.shiftKey && e.keyCode==13)
            # Using onKeyDown lets us prevent the default action,
            # even if an error is encountered (say, due to parsing).
            # This would not be possible with keymaps.
            e.preventDefault()
            @loaderFunc @editor.getValue()
