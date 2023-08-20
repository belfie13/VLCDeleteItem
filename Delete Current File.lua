function descriptor()
    return {
        title = "Delete Current File";
        version = "0.9";
        author = "CIIDMike";
        shortdesc = "Delete file from disk and playlist";
        description = [[
<h1>Delete Current File</h1>"
Delete Current File from disk and remove from playlist.
When the extension is run, a persistent button will show that runs the delete action.
Please use at your own discretion, the author is not responsible for any damage or lost files.
        ]];
   }
end

function click_delete()
    local item = vlc.input.item()
    local uri = item:uri()
    uri = string.gsub(uri, '^file:///', '')
    uri = vlc.strings.decode_uri(uri)
    vlc.msg.info("[Delete Current File] deleting: " .. uri)
    os.execute("rm -f \"" .. uri .. "\"")
    removeItem()
end

function removeItem()
    local id = vlc.playlist.current()
    vlc.playlist.delete(id)
    vlc.playlist.gotoitem(id + 1)
    -- vlc.deactivate()
end

function activate()
    d = vlc.dialog( "Delete Current File" )
    d:add_button( "DEL", click_delete, 1, 1, 1, 1)
    d:show()
end

function deactivate()
    vlc.deactivate()
end

function close()
    deactivate()
end

function meta_changed()
end
