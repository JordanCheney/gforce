<script>
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  function handleCloseButtonClick(e) {
    dispatch('modalClosed', {});
  }
</script>

<div class="flex flex-col justify-center eading-relaxed text-lg">
  <div class="flex-grow-0 justify-center p-2">
    <p class="float-left font-bold text-xl">GForCE Help</p>
    <div class="float-right cursor-pointer items-center h-8 w-8 p-2" on:click={handleCloseButtonClick}>
      <img class="w-full h-auto" src="images/close.svg" alt="Close modal"/>
    </div>
  </div>
  <div class="flex flex-row justify-center">
    <div class="flex-none flex flex-col pr-2 border-r-2 border-black min-w-helpTOC overflow-y-scroll">
      <a class="text-blue-400" href="#Overview">Overview</a>
      <a class="text-blue-400" href="#DataUsage">Data Usage</a>
      <a class="text-blue-400" href="#GeneratingApiKey">Generating an API Key</a>
      <a class="text-blue-400" href="#Pricing">Pricing</a>
      <a class="text-blue-400" href="#SelfHosting">Self Hosting</a>
    </div>
    <div class="flex-grow pl-2 px-2 overflow-y-scroll">
      <p id="Overview" class="font-bold text-xl">Overview</p>

      GForCE is a web-based tool that exposes Google Cloud's media APIs in a user friendly UI. 
      It was built based on my experience with the Interpol DevOps Working Groups and was 
      designed with law enforcement users in the VictimID field in mind.

      <p id="DataUsage" class="font-bold text-xl pt-6">Data Usage</p>

      <h3 class="border-l-4 border-black ml-2 pl-2 py-2 italic">
        GForCE is a web-based service that sends your data to a remote server. If that is not acceptable do not use GForCE
      </h3>
      <p>Data control and privacy is the key tenant of GForCE. First, it's important to understand how data flows through the tool.
      When you add an image to the web app, it is uploaded first to the GForCE server with a unique id. On the server, it is kept in RAM and
      transformed into a compliant Google request, then dispatched to the Google Cloud server for processing. The GForCE server waits for a
      response from Google, associates that response with the images unique id, and then returns that response to client for association.
      For users looking to validate this, the GForCE server is 
      <a class="text-blue-400" target="_blank" href="https://github.com/JordanCheney/gforce">open soure</a> and can be hosted locally so that users
      have full control. Google has outlined their data policies specifically for the Cloud Vision API 
      <a class="text-blue-400" target="_blank" href="https://cloud.google.com/vision/docs/data-usage">here</a>.</p>

      <p class="pt-2">All communication made between the client and the GForCE server are sent encrypted over HTTPS. All communication 
      between the GForCE server and the Google Cloud server are sent encrypted over HTTPS</p>

      <p class="pt-2">All requests are made using the user's Google API key, see 
      <a class="text-blue-400" href="#GeneratingApiKey">the next section</a> for information on how to create an API key. This means 
      that all the user has full control over requests, logging, Google Cloud management and permissions.</p>
      
      <p id="GeneratingApiKey" class="font-bold text-xl pt-6">Generating An API Key</p>

      GForCE requires you to provide a Google Cloud API key so that you control you data in Google and so that you pay for your requests.
      To create a Google Cloud API key, first vist <a class="text-blue-400" target="_blank" href="https://cloud.google.com">cloud.google.com</a>
      to create a Google Cloud Account. Once you have an account sign into the Google Cloud console and follow 
      <a class="text-blue-400" target="_blank" href="https://cloud.google.com/docs/authentication/api-keys">these instructions</a> to create an
      API key. Once you have a key, copy and paste it into the field at the top of GForCE.

      <p id="Pricing" class="font-bold text-xl pt-6">Pricing</p>

      GForCE is a free and open source tool, but the Google Cloud APIs cost money. To use GForCE, you have to have an existing Google Cloud account
      with a valid credit card attached to it. Any request you make through GForCE, will issue a corresponding request to Google Cloud, which you
      will have to pay for. Google Cloud prices are listed <a class="text-blue-400" target="_blank" href="https://cloud.google.com/vision/pricing">here</a>.
      GForCE requests several types of features per image uploaded. Currently, it requests "Label Detection", "Text Detection", "Safe Search Detection", 
      "Face Detection", "Logo Detection", and "Object Localization". As of March 30th, 2020, those features will cost $8.25 (US) per thousand images and 
      the first thousand images are free. Please check current pricing before using GForCE to avoid surprise billing.

      <p id="SelfHosting" class="font-bold text-xl pt-6">Self Hosting</p>

      GForCE is open source, and instructions for running it yourself are included in the 
      <a class="text-blue-400" target="_blank" href="https://github.com/JordanCheney/gforce">Github repository</a>
    </div>
  </div>
</div>
