<template>
  <table class="ink-table">
    <tr>
      <th></th>
      <th class="align-left">X</th>
      <th class="align-left">Y</th>
    </tr>
    <Coordinate @input="inputStart"
                :title="'Start'"
                :mX="start.x"
                :mY="start.y"/>
    <Coordinate @input="inputEnd"
                :title="'End'"
                :mX="end.x"
                :mY="end.y"/>
  </table>
</template>

<script>
import Coordinate from "./Coordinate";

export default {
  name: "Vertices",
  components: {Coordinate},
  props: [
    'mStart',
    'mEnd',
  ],
  data: function () {
    return {
      start: this.mStart,
      end: this.mEnd,
    }
  },
  watch: {
    start: function () {
      this.input()
    },
    end: function () {
      this.input()
    }
  },
  methods: {
    inputStart: function (value) {
      this.start = value
    },
    inputEnd: function (value) {
      this.end = value
    },
    input: function () {
      this.$emit('input', this.$data)
    }
  }
}
</script>

<style scoped>

</style>