<template>
  <footer class="clearfix">
    <div class="ink-grid">
      <ul class="unstyled inline half-vertical-space">
        <li class="active"><a href="#">About</a></li>
        <li><a href="#">Sitemap</a></li>
        <li><a href="#">Contacts</a></li>
      </ul>
      <p class="note">Identification of the owner of the copyright, either by name, abbreviation, or other designation
        by which it is generally known.</p>
    </div>
  </footer>
</template>

<script>
export default {
  name: "Footer"
}
</script>

<style scoped>
footer {
  background: #ccc;
  border: 0;
}

footer * {
  line-height: inherit;
}
</style>