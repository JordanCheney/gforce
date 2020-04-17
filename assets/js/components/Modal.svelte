<script>
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  let Component = null;
  let props = {}

  let background;

  export function openModal(NewComponent, newProps = {}) {
    console.log("Toggling modal open")
    Component = NewComponent;
    props = newProps;
  };

  const close = () => {
    Component = null;
    props = {};

    dispatch('modalClosed', {});
  };

  const handleKeyup = ({ key }) => {
    if (Component && key === 'Escape') {
      event.preventDefault();
      close();
    }
  };

  const handleOuterClick = (e) => {
    console.log("outer click:", e)
    if (event.target === background)
    {
      event.preventDefault();
      close();
    }
  };
</script>

<style>
  .modal {
    transition: opacity 0.25s ease;
  }
</style>

<svelte:window on:keyup={handleKeyup}/>

<div>
  <slot></slot>
  <div class="modal fixed w-screen h-screen top-0 left-0 items-center justify-center flex flex-col" class:opacity-0={!Component} class:pointer-events-none={!Component} on:click={handleOuterClick}>
    <div class="absolute w-screen h-screen bg-gray-900 opacity-50 z-0" bind:this={background}/>
    <div class="bg-white max-w-80 mx-auto max-h-body p-4 rounded shadow-lg z-50 self-center overflow-y-auto">
      {#if Component}
        <Component {...props} on:modalClosed={close}/>
      {/if}
    </div>
  </div>
</div>