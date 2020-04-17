<script>
  export let content = null;
</script>

<div class="max-w-sm rounded overflow-hidden shadow-lg">
  <div class="w-100 bg-orange-400">
    <h3 class="text-center py-4">Not Safe For Work Annotations</h3>
  </div>
  <table class="table-auto border-separate text-left py-2" style="border-spacing: 2rem 0">
    <thead>
      <tr>
        <th>NSFW Label</th>
        <th>Confidence</th>
      </tr>
    </thead>

    {#if content != null && content.length != 0}
      <tbody class="text-sm">
        {#each Object.keys(content) as key}
          <tr>
            <td>{key}</td>
            <td>{content[key]}</td>
          </tr>
        {/each}
      </tbody>
    {/if}
</table>
</div>