<script>
  import Dropzone from "./Dropzone.svelte";
  import ImageThumbnail from "./ImageThumbnail.svelte";
  import Download from "./Download.svelte";

  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  let filesLoaded = 0;
  let filesProcessed = 0;
  let filesVisible = 0;
  let filesProcessedPercentage = 100;

  let columns = [[], [], [], []]; // 4 columns
  let images = {};

  let filters = [
    {name: 'face', label: 'Has Face', image: 'images/face.svg'},
    {name: 'text', label: 'Has Text', image: 'images/text.svg'},
    {name: 'adult', label: 'Has Adult Content', image: 'images/adult.svg'},
    {name: 'racy', label: 'Has Racy Content', image: 'images/racy.svg'},
    {name: 'violent', label: 'Has Violent Content', image: 'images/violence.svg'}
  ];
  let activeFilters = [];
  
  let beforeFirstUpload = true;

  function getProcessedProgress() {
    if (filesLoaded === 0) {
      return 100;
    }

    return Math.floor(100 * filesProcessed / filesLoaded);
  }

  export function handleAddImage(e) {
    beforeFirstUpload = false;

    const {id, file} = e.detail;

    let reader = new FileReader();
    reader.onload = function(loadedFile) {
      let col = Math.floor(filesLoaded % columns.length);
      
      columns[col].push({
        id: id,
        name: file.name,
        src: loadedFile.target.result,
        hidden: activeFilters.length != 0 // Hide if there are filters
      });

      // Self assignment to tell svelte to update DOM
      columns = columns;
      filesLoaded += 1;
      filesVisible += 1;
      filesProcessedPercentage = getProcessedProgress();
    }
    reader.readAsDataURL(file);
  };

  function checkImageHidden(image) {
    // If there are no filters, image shouldn't be hidden
    if (activeFilters.length == 0) {
      return false;
    }

    let hide = true;
    activeFilters.forEach(filter => {
      if (filter == "face" && image.hasFace()) {
        hide = false;
      }
      else if (filter == "text" && image.hasText()) {
        hide = false;
      }
      else if (filter == "adult" && image.hasAdultContent()) {
        hide = false;
      }
      else if (filter == "racy" && image.hasRacyContent()) {
        hide = false;
      }
      else if (filter == "violent" && image.hasViolentContent()) {
        hide = false;
      }
    });
    
    return hide;
  }

  export function handleApiResponseReady(id) {
    images[id].addResponse();
    images[id].setHidden(checkImageHidden(images[id]));
    images[id] = images[id];
    
    if (images[id].hidden) {
      filesVisible -= 1;
    }
    filesProcessed += 1;
    filesProcessedPercentage = getProcessedProgress();
  };

  function handleFilter(e) {
    if (e.target.checked) {
      activeFilters.push(e.target.value);
    } else {
      activeFilters = activeFilters.filter(item => item != e.target.value);
    }

    filesVisible = 0;
    for (const id in images) {
      images[id].setHidden(checkImageHidden(images[id]));
      if (!images[id].hidden) {
        filesVisible += 1;
      }
    }
    filesProcessedPercentage = getProcessedProgress();

    images = images;
  };
</script>

<div class="flex flex-row flex-wrap h-12">
  <label class="flex-none py-2 pr-4">
    <p class="self-center font-bold">Filters:</p>
  </label>
  {#each Object.values(filters) as filter}
    <label class="flex flex-row flex-none pr-4 py-2">
      <input type=checkbox class="flex-none self-center" value={filter.name} on:input={handleFilter}>
      <p class="px-2 self-center">{filter.label}</p>
      <img class="flex-none" src={filter.image} alt="{filter.name} indicator" height="24" width="24"/>
    </label>
  {/each}
  <div class="flex-grow"/>
  <div class="float-right items-center h-10 w-10 p-2">
    <Download filename="gforce_dump" data={images}/>
  </div>
</div>

<div class="flex flex-row flex-wrap">
  <label class="flex-none pr-4 self-center">
    <p class="float-left font-bold pr-2">Total images: </p> {filesLoaded}
  </label>
  <label class="flex-none pr-4 self-center">
    <p class="float-left font-bold pr-2">Filtered images: </p> {filesVisible}
  </label>
  <label class="flex-none pr-4 self-center">
    <p class="float-left font-bold pr-2">Processed images: </p> {filesProcessed} / {filesLoaded} ({filesProcessedPercentage}%)
  </label>
  <div class="relative flex-grow shadow bg-gray-400 w-56 p-2 my-2">
    <div class="absolute top-0 left-0 bg-blue-700 leading-none" style="height: 100%; width: {filesProcessedPercentage}%"></div>
    <p class="absolute top-0 left-0 w-full h-full text-xs text-center text-white text-center">{filesProcessedPercentage}%</p>
  </div>
</div>

<Dropzone on:addedFile>
  <div class="flex flex-wrap px-1 py-2 border border-black rounded-md min-h-body overflow-y-scroll">
    <p class="self-center text-center flex-grow text-3xl" class:hidden={!beforeFirstUpload}>Drag and Drop files to upload</p>
    
    {#each columns as column}
      {#if column.length != 0}
        <div class="flex-100 sm:flex-50 md:flex-25 max-w-100 sm:max-w-50 md:max-w-25 px-1">
          {#each column as image}
            <ImageThumbnail id={image.id} src={image.src} name={image.name} hidden={image.hidden} on:thumbnailClicked bind:this={images[image.id]}/>
          {/each}
        </div>
      {/if}
    {/each}
  </div>
</Dropzone>
