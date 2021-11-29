<template>
  <button type="button" class="ink-button orange push-right" @click="request">Request</button>
</template>

<script>
export default {
  name: "RequestButton",
  props: [
    'image',
    'rectangles',
    'featureType',
    'apiKey'
  ],
  data: function () {
    return {
      schema: 'https',
      domain: 'vision.googleapis.com',
      path: '/v1/images:annotate',
    }
  },
  computed: {
    url: function () {
      return `${this.schema}://${this.domain}${this.path}?key=${this.apiKey}`
    },
    body: function () {
      const canvas = document.createElement('canvas')
      const context = canvas.getContext('2d')
      this.draw(canvas, context)
      const requests = []
      for (const rect of this.rectangles) {
        rect.error = ''
        try {
          const imageData = context.getImageData(
              rect.vertices.start.x,
              rect.vertices.start.y,
              rect.vertices.end.x - rect.vertices.start.x,
              rect.vertices.end.y - rect.vertices.start.y
          )
          const cropCanvas = document.createElement('canvas')
          const cropContext = cropCanvas.getContext('2d')
          cropContext.putImageData(imageData, 0, 0)
          const cropImage = cropCanvas.toDataURL('image/png').split(',')[1]

          requests.push({
            image: {content: cropImage},
            features: [{type: this.featureType}],
            imageContext: {languageHints: ['ja-t-i0-handwrit']}
          })
        } catch (e) {
          rect.error = e
        }
      }
      return {requests: requests}
    }
  },
  watch: {
    url: function () {
      this.$emit('updateRequest', {url: this.url, body: this.body})
    },
    body: function () {
      this.$emit('updateRequest', {url: this.url, body: this.body})
    }
  },
  methods: {
    draw: function (canvas, context) {
      return new Promise(resolve => {
        if (this.image == null) {
          resolve()
        } else {
          const image = new Image()
          image.src = this.image
          image.onload = () => {
            const width = image.width;
            const height = image.height;
            canvas.width = width;
            canvas.height = height;
            context.drawImage(image, 0, 0, width, height);
            resolve()
          }
        }
      })
    },
    request: async function () {
      await fetch(this.url, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(this.body)
      })
          .then(response => response.json())
          .then(data => this.$emit('responded', data))
          .catch(error => console.log(error))
    },
  }
}
</script>

<style scoped>

</style>