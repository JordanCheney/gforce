<script>
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  let apiKey = "";
  let apiKeyInputBorderWidth = "border";
  let apiKeyInputBorderColor = "border-black";
  let drawAttention = false;

  export function getApiKey() {
    return apiKey;
  }

  export function triggerApiKeyInputAttention() {
    apiKeyInputBorderWidth = "border-2";
    apiKeyInputBorderColor = "border-red-500";
    drawAttention = true;
  }

  function resetApiKeyInput(e) {
    apiKeyInputBorderWidth = "border";
    apiKeyInputBorderColor = "border-black";
    drawAttention = false;
  }

  function handleApiKeyHelpClick(e) {
    dispatch("helpClicked", {
      target: "GeneratingApiKey"
    });  
  }

  function handleHelpClick(e) {
    dispatch("helpClicked", {});
  }
</script>

<style>
.attention {
  /* Start the shake animation and make the animation last for 0.5 seconds */
  animation: shake 0.25s; 
}

@keyframes shake {
  0% { transform: translate(1px, 1px) rotate(0deg); }
  10% { transform: translate(-1px, -2px) rotate(-1deg); }
  20% { transform: translate(-3px, 0px) rotate(1deg); }
  30% { transform: translate(3px, 2px) rotate(0deg); }
  40% { transform: translate(1px, -1px) rotate(1deg); }
  50% { transform: translate(-1px, 2px) rotate(-1deg); }
  60% { transform: translate(-3px, 1px) rotate(0deg); }
  70% { transform: translate(3px, 1px) rotate(-1deg); }
  80% { transform: translate(-1px, -1px) rotate(1deg); }
  90% { transform: translate(1px, 2px) rotate(0deg); }
  100% { transform: translate(1px, -2px) rotate(-1deg); }
}
</style>

<div class="flex flex-row flex-wrap">
  <img class="flex-none pr-4" src="images/logo.png" alt="Project logo" height=80/>
  <div class="flex-none hidden xl:block self-center text-xl">GForCE: <u>G</u>oogle <u>For</u> combatting <u>C</u>hild <u>E</u>xploitation</div>
  <div class="flex-grow"></div>
  <div class="flex flex-row py-2 mr-4 w-56 self-center">
    <input class="{apiKeyInputBorderWidth} {apiKeyInputBorderColor} w-full h-10 rounded p-2" class:attention={drawAttention} placeholder="Google API Key" bind:value={apiKey} on:input={resetApiKeyInput}/>
  </div>
  <div class="bg-transparent hover:bg-black text-black font-semibold hover:text-white h-10 p-2 border border-black hover:border-transparent rounded shadow self-center" on:click={handleHelpClick}>
    How GForCE Works
  </div>
</div>
