<script>
  import { onMount, afterUpdate } from "svelte";

  export let filename = "";
  export let data = {};

  let sanitizedFilename = "";
  let downloadButton;

  function sanitizeFilename(filename) {
    return filename.replace('.', '_')
  };

  function prepDownload() {
    sanitizedFilename = sanitizeFilename(filename);

    let blob = new Blob([JSON.stringify(data)], {type: 'application/json'});
    let url = window.URL.createObjectURL(blob);
    downloadButton.href = url;
  }

  onMount(() => {
    prepDownload()
  })

  afterUpdate(() => {
    prepDownload()
  })
</script>

<a class="cursor-pointer" download="{sanitizedFilename}.json" href=”” bind:this={downloadButton}>
  <img src="images/download.svg" alt="Download file"/>
</a>