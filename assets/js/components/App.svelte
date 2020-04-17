<script>
  import TailwindCSS from "./TailwindCSS.svelte";
  import Header from "./Header.svelte";
  import HelpModal from "./HelpModal.svelte";
  import Modal from "./Modal.svelte";
  import { launchApiRequest } from "./ApiRequest.svelte";
  import Gallery from "./Gallery.svelte";
  import ImageModal from "./ImageModal.svelte";
  import Footer from "./Footer.svelte";

  let header;
  let gallery;
  let modal;
  let modalOpen = false;

  function handleApiResponseReady(id) {
    if (gallery) {
      gallery.handleApiResponseReady(id);
    }
  }

  function handleAddedFile(e) {
    if (header.getApiKey().length == 0) {
      header.triggerApiKeyInputAttention()
      return;
    }

    launchApiRequest(e.detail.id, e.detail.file, apiKey, ["Recognize"], handleApiResponseReady);
    
    if (gallery) {
      gallery.handleAddImage(e);
    }
    else {
      console.log("Gallery component not mounted yet. Please try again");
    }
  }

  function handleThumbnailClicked(e) {
    const {id, src, name} = e.detail;

    let response = JSON.parse(window.sessionStorage.getItem(id));
    if (!response) {
      response = {}
    }

    modalOpen = true;
    modal.openModal(ImageModal, {id: id, src: src, name: name, response: response});
  }

  function handleHelpButtonClicked(e) {
    modalOpen = true;
    modal.openModal(HelpModal, {});
  }

  function handleModalClosed(e) {
    modalOpen = false;
  }
</script>

<TailwindCSS/>
<Modal on:modalClosed={handleModalClosed} bind:this={modal}>
  <div class="px-20 py-4">
    <Header bind:this={header} on:helpClicked={handleHelpButtonClicked}/>
    <Gallery bind:this={gallery} on:addedFile={handleAddedFile} on:thumbnailClicked={handleThumbnailClicked}/>
    <Footer/>
  </div>
</Modal>
