<script>
  import Download from "./Download.svelte";
  import FaceAnnotation from "./FaceAnnotation.svelte";
  import SceneAnnotation from "./SceneAnnotation.svelte";
  import NSFWAnnotation from "./NSFWAnnotation.svelte";

  import { onMount, createEventDispatcher } from "svelte";

  export let id = -1;
  export let src = "";
  export let name = "";
  export let response = {};

  const dispatch = createEventDispatcher();

  // DOM references
  let image;
  let annotations;

  // Use for drawing
  let imageRatio = 1.0;

  // Label collections
  let faceAnnotations = [];
  let sceneAnnotations = null;
  let nsfwAnnotations = [];

  // Dynamically resize the SVG based on the loaded image size
  onMount(() => {
    image.onload = () => {
      annotations.setAttribute("width", image.width.toString());
      annotations.setAttribute("height", image.height.toString());

      imageRatio = image.width / image.naturalWidth;

      if (response.faceAnnotations != null) {
        response.faceAnnotations.forEach(face => {
          faceAnnotations = [...faceAnnotations, {content: face, imageRatio: imageRatio}];
        })
      }

      sceneAnnotations = response.labelAnnotations;
      nsfwAnnotations = response.safeSearchAnnotation;
    }
  });

  function handleCloseButtonClick(e) {
    dispatch('modalClosed', {});
  }
</script>

<div class="flex flex-col justify-center p-4 overflow-y-scroll">
  <div class="flex-grow-0 justify-center p-2">
    <p class="float-left">File name: {name}</p>
    <div class="float-right cursor-pointer items-center h-8 w-8 p-2" on:click={handleCloseButtonClick}>
      <img class="w-full h-auto" src="images/close.svg" alt="Close modal"/>
    </div>
    <div class="float-right items-center h-8 w-8 p-2">
      <Download filename={name} data={response}/>
    </div>
  </div>
  <div class="flex flex-row flex-wrap p-2">
    <div class="relative flex-grow-0 max-w-100 lg:max-w-50 self-center">
      <img src={src} alt="Uploaded image {name}" bind:this={image}>
      <svg class="absolute top-0 left-0" bind:this={annotations}>
        {#each faceAnnotations as faceAnnotation}
          <FaceAnnotation content={faceAnnotation.content} imageRatio={faceAnnotation.imageRatio}/>
        {/each}
      </svg>
    </div>
    <div class="flex-grow-0 px-6 py-4">
      <SceneAnnotation content={sceneAnnotations}/>
    </div>
    <div class="flex-grow-0 px-6 py-4">
      <NSFWAnnotation content={nsfwAnnotations}/>
    </div>
  </div>
</div>