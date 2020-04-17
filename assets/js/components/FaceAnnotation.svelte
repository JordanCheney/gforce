<script>
  import { onMount } from "svelte";

  export let content = {};
  export let imageRatio = 1.0;

  let rect;
  
  function handleMouseEnter(e) {
    console.log("Rect mouse entered");
  };

  function handleMouseLeave(e) {
    console.log("Rect mouse leave");
  };

  onMount(() => {
    let vertices = content.boundingPoly.vertices;

    let minX = 1000000;
    let maxX = -1000000;
    let minY = 1000000;
    let maxY = -1000000;
    vertices.forEach(pt => {
      // X and Y are not defined if they fall outside the minimum bounds of the 
      // rectangle. For drawing purposes we set them to 0 here
      if (!pt.x) {
        pt.x = 0;
      }
      if (!pt.y) {
        pt.y = 0;
      }
      
      if (pt.x < minX) {
        minX = pt.x;
      }
      if (pt.x > maxX) {
        maxX = pt.x;
      }
      if (pt.y < minY) {
        minY = pt.y;
      }
      if (pt.y > maxY) {
        maxY = pt.y;
      }
    })

    let x = Math.ceil(minX * imageRatio).toString();
    let y = Math.ceil(minY * imageRatio).toString();
    let width = Math.ceil((maxX - minX) * imageRatio).toString();
    let height = Math.ceil((maxY - minY) * imageRatio).toString();

    rect.setAttribute("x", x);
    rect.setAttribute("y", y);
    rect.setAttribute("width", width);
    rect.setAttribute("height", height);
  }); 
</script>

<rect 
  class="faceAnnotation" 
  stroke="#3dfc03" 
  stroke-width="3" 
  fill="none" 
  pointer-events="all"
  on:mouseenter={handleMouseEnter}
  on:mouseleave={handleMouseLeave}
  bind:this={rect}/>