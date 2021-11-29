<template>
  <div>
    <button type="button" class="ink-button">Copy</button>
    <p>POST {{ url }}</p>
    <pre><code>{{ body }}</code></pre>
  </div>
</template>

<script>
export default {
  name: "InspectRequest",
  props: [
      'url',
      'body',
  ],
  methods: {

  }
}
</script>

<style scoped>

</style>