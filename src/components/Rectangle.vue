<template>
  <div>
    <input type="text" v-model="identify" placeholder="Identify">
    <span class="vertical-space left-space">Result: {{ result }}</span>
    <button type="button" class="ink-button red push-right" v-on:click="remove(mIndex)">Remove</button>
    <Vertices ref="vertices"
              @input="inputVertices"
              :mStart="vertices.start"
              :mEnd="vertices.end"/>
    <p class="fw-500 tip">{{ error }}</p>
  </div>
</template>

<script>
import Vertices from "@/components/Vertices";

export default {
  name: "Rectangle",
  components: {Vertices},
  props: [
    'mIndex',
    'mIdentify',
    'mResult',
    'mVertices',
    'mError',
  ],
  data: function () {
    return {
      identify: this.mIdentify,
      result: this.mResult,
      vertices: this.mVertices,
      error: this.mError
    }
  },
  watch: {
    identify: {
      handler: function () {
        this.input()
      },
      deep: true
    },
    result: function () {
      this.input()
    },
    vertices: {
      handler: function () {
        this.input()
      },
      deep: true
    },
    error: function () {
      this.input()
    },
  },
  methods: {
    remove: function (index) {
      this.$emit('remove', index)
    },
    input: function () {
      this.$emit('input', this.mIndex, this.$data)
    },
    inputVertices: function (value) {
      this.vertices = value
    }
  }
}
</script>

<style scoped>

</style>