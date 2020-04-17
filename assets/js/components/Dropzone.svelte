<script>
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  let fileId = 0;
  
  function getFilesFromDropEvent(e) {
    let files = []
    if (e.dataTransfer.items) {
      for (var i = 0; i < e.dataTransfer.items.length; i++) {
        if (e.dataTransfer.items[i].kind === 'file') {
          files.push(e.dataTransfer.items[i].getAsFile());
        }
      }
    } else {
      for (var i = 0; i < e.dataTransfer.files.length; i++) {
        files = e.dataTransfer.files;
      }
    }

    return files;
  }

  function handleDragDrop(e) {
    e.preventDefault();

    let files = getFilesFromDropEvent(e);
    files.forEach(file => {
      dispatch('addedFile', {
        id: fileId,
        file: file
      });
        
      fileId += 1;
    })
  }
</script>

<div
  on:drop={handleDragDrop} 
  ondragover="return false">
  <slot></slot>
</div>