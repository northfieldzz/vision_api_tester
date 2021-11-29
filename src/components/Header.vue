<template>
  <div class="top-menu">
    <nav class="ink-navigation ink-grid">
      <ul class="menu horizontal black">
        <li class="active"><a href="#">{{ title }}</a></li>
      </ul>
    </nav>
  </div>
</template>

<script>
export default {
  name: "Header",
  data: function () {
    return {
      title: 'Vision Api'
    }
  }
}
</script>

<style scoped>
.top-menu {
  background: #1a1a1a;
}
</style>