<template>
  <tr>
    <td>{{ title }}</td>
    <td><input type="number" v-model.number="x"></td>
    <td><input type="number" v-model.number="y"></td>
  </tr>
</template>

<script>
export default {
  name: "Coordinate",
  props: [
    'title',
    'mX',
    'mY',
  ],
  data: function () {
    return {
      x: this.mX,
      y: this.mY,
    }
  },
  watch: {
    x: function () {
      this.input()
    },
    y: function () {
      this.input()
    }
  },
  methods: {
    input: function () {
      this.$emit('input', this.$data)
    }
  },
}
</script>

<style scoped>

</style>