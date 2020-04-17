<script>
  export let content = null;
</script>

<div class="max-w-sm rounded overflow-hidden shadow-lg">
  <div class="w-100 bg-green-400">
    <h3 class="text-center py-4">Scene Annotations</h3>
  </div>
  <table class="table-auto border-separate text-left py-2" style="border-spacing: 2rem 0">
    <thead>
      <tr>
        <th>Scene Label</th>
        <th>Confidence</th>
      </tr>
    </thead>

    {#if content != null && content.length != 0}
      <tbody class="text-sm">
        {#each content as item}
          <tr>
            <td>{item.description}</td>
            <td>{item.score}</td>
          </tr>
        {/each}
      </tbody>
    {/if}
  </table>
</div>