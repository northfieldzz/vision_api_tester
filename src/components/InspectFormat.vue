<template>
  <div>
    <button type="button" class="ink-button">Download</button>
    <pre><code>{{ output }}</code></pre>
  </div>
</template>

<script>
export default {
  name: "InspectFormat",
  props: [
    'rectangles'
  ],
  computed: {
    output: function () {
      return JSON.stringify(this.rectangles, null, 2)
    }
  }
}
</script>

<style scoped>

</style>