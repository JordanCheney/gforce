<script>
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();
  
  export let id = -1;
  export let src = "";
  export let name = "";
  export let hidden = false;
  let response = {}

  let showAdultIcon = false;
  let showViolenceIcon = false;
  let showRacyIcon = false;
  let showFaceIcon = false;
  let showTextIcon = false;
  
  export function addResponse() {
    response = JSON.parse(window.sessionStorage.getItem(id));
    
    const positiveClasses = ["POSSIBLE", "LIKELY", "VERY_LIKELY"];
    showAdultIcon = positiveClasses.includes(response.safeSearchAnnotation.adult);
    showViolenceIcon = positiveClasses.includes(response.safeSearchAnnotation.violence);
    showRacyIcon = positiveClasses.includes(response.safeSearchAnnotation.racy);

    showFaceIcon = response.faceAnnotations != null && response.faceAnnotations.length > 0;
    showTextIcon = response.fullTextAnnotation != null;
  }

  export function hasFace() {
    return showFaceIcon;
  };
  export function hasText() {
    return showTextIcon;
  }
  export function hasAdultContent() {
    return showAdultIcon;
  }
  export function hasRacyContent() {
    return showRacyIcon;
  }
  export function hasViolentContent() {
    return showViolenceIcon;
  }

  export function setHidden(hide) {
    hidden = hide;
  }

  export function toJSON() {
    if (hidden) {
      return undefined;
    }

    return {
      id: id,
      filename: name,
      response: response
    }
  }
  
  function handleClick(e) {
    dispatch('thumbnailClicked', {
      id: id,
      src: src,
      name: name
    });
  };
</script>

<div class="flex flex-col border border-black mb-2" class:hidden={hidden} on:click={handleClick}>
  <img class="flex-grow-1 w-full h-auto border border-black" src={src} alt="Uploaded image {name}"/>
  <div class="flex-grow-0 flex flex-row flex-wrap w-full">
    <img class="p-2 w-12" class:invisible={!showFaceIcon} src=images/face.svg alt="Image has faces"/>
    <img class="p-2 w-12" class:invisible={!showTextIcon} src=images/text.svg alt="Image has text"/>
    <img class="p-2 w-12" class:invisible={!showAdultIcon} src=images/adult.svg alt="Image has adult content"/>
    <img class="p-2 w-12" class:invisible={!showRacyIcon} src=images/racy.svg alt="Image has racy content"/>
    <img class="p-2 w-12" class:invisible={!showViolenceIcon} src=images/violence.svg alt="Image has violent content"/>
  </div>
</div>