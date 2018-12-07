"use strict";

function removeDragData(ev) {
    console.log('Removing drag data');

    if (ev.dataTransfer.items) {
        // Use DataTransferItemList interface to remove the drag data
        ev.dataTransfer.items.clear();
    } else {
        // Use DataTransfer interface to remove the drag data
        ev.dataTransfer.clearData();
    }
}

function dropHandler(ev) {
    console.log('File(s) dropped');

    // Prevent default behavior (Prevent file from being opened)
    ev.preventDefault();

    var form = new FormData();
    var xhr = new XMLHttpRequest();
    form.set('dir_path', document.getElementById("sima-magic").value);

    if (ev.dataTransfer.items) {
        // Use DataTransferItemList interface to access the file(s)
        for (var i = 0; i < ev.dataTransfer.items.length; i++) {
            // If dropped items aren't files, reject them
            if (ev.dataTransfer.items[i].kind === 'file') {
                var file = ev.dataTransfer.items[i].getAsFile();
                form.append('file', file);
                console.log('... file[' + i + '].name = ' + file.name);
            }
        }
    } else {
        // Use DataTransfer interface to access the file(s)
        for (var i = 0; i < ev.dataTransfer.files.length; i++) {
            console.log('... file[' + i + '].name = ' + ev.dataTransfer.files[i].name);
            form.append('file', files[i]);
        }
    }

    xhr.open('POST', '/upload_file');

    xhr.onprogress = function (e) {
        if (e.lengthComputable) {
            var percentComplete = e.loaded / e.total * 100;
            document.getElementById("drag_upload_progress").value = percentComplete;
        } else {
            if (document.getElementById("drag_upload_progress").value < 100)
                document.getElementById("drag_upload_progress").value = document.getElementById("drag_upload_progress").value + 1;
        }
    }

    xhr.onload = function () {
        // Request finished. Do processing here.
        location.reload();
    }

    console.log("Start sending file...");
    xhr.send(form);

    // Pass event to removeDragData for cleanup
    removeDragData(ev)
}


function dragOverHandler(ev) {
    console.log('File(s) in drop zone');

    // Prevent default behavior (Prevent file from being opened)
    ev.preventDefault();
}

// Add event listeners
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('drop_zone').addEventListener('drop', dropHandler);
    document.getElementById('drop_zone').addEventListener('dragover', dragOverHandler);
});