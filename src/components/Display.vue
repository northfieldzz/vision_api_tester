<template>
  <div>
    <figure class="ink-image">
      <canvas id="preview" @mousemove="onMouseMove"></canvas>
    </figure>

    <div class="column-group">
      <span>x: {{ x }} y: {{ y }}</span>
    </div>
  </div>
</template>

<script>
export default {
  name: "Display",
  data: function () {
    return {
      canvas: null,
      x: 0,
      y: 0,
    }
  },
  mounted: function () {
    this.canvas = document.getElementById('preview')
  },
  computed: {
    context: function () {
      return this.canvas.getContext('2d')
    }
  },
  methods: {
    /**
     * canvas上のマウス位置の取得
     * 画像の拡縮に合わせて倍率を入れている
     * @param event
     */
    onMouseMove: function (event) {
      this.x = event.offsetX
      this.y = event.offsetY
    },
    /**
     * 描画
     * @param imageBase64
     * @param rectangles
     */
    draw: function (imageBase64, rectangles) {
      this.drawBase(imageBase64).then(() => {
        this.drawRects(rectangles)
      })
    },
    /**
     * 画像をcanvasに描く
     * @returns {Promise<unknown>}
     */
    drawBase: function (imageBase64) {
      return new Promise((resolve) => {
        if (imageBase64 == null) {
          resolve()
        } else {
          const image = new Image()
          image.src = imageBase64
          image.onload = () => {
            const width = image.width;
            const height = image.height;
            this.canvas.width = width;
            this.canvas.height = height;
            this.context.drawImage(image, 0, 0, width, height);
            resolve()
          }
        }
      })
    },
    /**
     * rectanglesの四角形を描く
     * @param rectangles
     */
    drawRects: function (rectangles) {
      for (const rectangle of rectangles) {
        const vertices = rectangle.vertices
        this.drawRect(
            vertices.start.x,
            vertices.start.y,
            vertices.end.x - vertices.start.x,
            vertices.end.y - vertices.start.y,
            'purple',
            rectangle.identify,
        )
      }
    },
    /**
     * 四角形をcanvasに描く
     * @param x
     * @param y
     * @param w
     * @param h
     * @param color
     * @param index
     */
    drawRect: function (x, y, w, h, color, index = '') {
      this.context.beginPath()
      this.context.rect(x, y, w, h)
      this.context.strokeStyle = color
      this.context.lineWidth = 2
      this.context.stroke()
      if (index) {
        this.context.font = '20px serif'
        this.context.fillStyle = color
        this.context.textBaseline = 'top'
        this.context.textAlign = 'right'
        this.context.fillText(index, x + w, y + y)
      }
    },
  }
}
</script>

<style scoped>
#preview {
  width: 100%;
}
</style>