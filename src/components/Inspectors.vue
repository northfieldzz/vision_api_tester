<template>
  <div class="ink-tabs top" data-prevent-url-change="true">
    <ul class="tabs-nav">
      <li><a class="tabs-tab" href="#format">Output</a></li>
      <li><a class="tabs-tab" href="#request">Request</a></li>
    </ul>

    <div id="format" class="tabs-content">
      <InspectFormat :rectangles="rectangles"/>
    </div>

    <div id="request" class="tabs-content">
      <InspectRequest :url="request.url" :body="request.body"/>
    </div>
  </div>
</template>

<script>
import InspectFormat from "@/components/InspectFormat";
import InspectRequest from "@/components/InspectRequest";

export default {
  name: "Inspectors",
  components: {
    InspectFormat,
    InspectRequest,
  },
  props: [
    'rectangles',
    'request',
  ]
}
</script>

<style scoped>

</style>