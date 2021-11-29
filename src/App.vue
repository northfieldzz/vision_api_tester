<template>
  <div id="app">
    <div class="wrap">
      <Header/>
      <div class="ink-grid vertical-space">
        <div class="column-group horizontal-gutters">

          <div class="all-60">
            <Display ref="display"/>
          </div>

          <div class="all-40">
            <Editor @onChangeFile="updateImage"
                    @updateRectangles="updateRectangles"
                    @updateRequest="updateRequest"
                    @responded="updateRectangles"
                    :rectangles="rectangles"
                    :image="image"/>
          </div>
        </div>
        <Inspectors :rectangles="rectangles" :request="request"/>
      </div>
      <div class="push"></div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import Editor from "@/components/Editor";
import Display from "@/components/Display";
import Inspectors from "@/components/Inspectors";

export default {
  name: 'App',
  components: {
    Inspectors,
    Display,
    Editor,
    Footer,
    Header,
  },
  data: function () {
    return {
      image: null,
      rectangles: [],
      request: {}
    }
  },
  watch: {
    image: {
      handler: function () {
        this.draw()
      }
    },
    rectangles: {
      handler: function () {
        this.draw()
      },
      deep: true,
    },

    // isGrayScale: {
    //   handler: function () {
    //     const imageData = this.context.getImageData(0, 0, this.canvas.width, this.canvas.height)
    //     this.grayScale(imageData.data)
    //     this.context.putImageData(imageData, 0, 0);
    //   }
    // },
    // isBitwiseNot: {
    //   handler: function () {
    //     const imageData = this.context.getImageData(0, 0, this.canvas.width, this.canvas.height)
    //     this.bitwiseNot(imageData.data)
    //     this.context.putImageData(imageData, 0, 0);
    //   }
    // },
    // isMedian: {
    //   handler: function () {
    //     const imageData = this.context.getImageData(0, 0, this.canvas.width, this.canvas.height)
    //     this.median(imageData.data)
    //     this.context.putImageData(imageData, 0, 0);
    //   }
    // },
    // isMono: {
    //   handler: function () {
    //     const imageData = this.context.getImageData(0, 0, this.canvas.width, this.canvas.height)
    //     this.mono(imageData.data)
    //     this.context.putImageData(imageData, 0, 0);
    //   }
    // }
  },
  methods: {
    updateImage: function (value) {
      this.image = value
    },
    updateRectangles: function (value) {
      this.rectangles = value
    },
    updateRequest: function (value) {
      this.request = value
    },
    draw: function () {
      this.$refs.display.draw(this.image, this.rectangles)
    },

    // // canvasのグレースケール
    // grayScale: function (data) {
    //   for (let i = 0; i < data.length; i += 4) {
    //     let g = data[i] * 0.2126 + data[i + 1] * 0.7152 + data[i + 2] * 0.0722
    //     data[i] = data[i + 1] = data[i + 2] = g
    //   }
    //   return data
    // },
    // // canvasの色反転
    // bitwiseNot: function (data) {
    //   for (let i = 0; i < data.length; i += 4) {
    //     data[i] = 255 - data[i]
    //     data[i + 1] = 255 - data[i + 1]
    //     data[i + 2] = 255 - data[i + 2]
    //   }
    //   return data
    // },
    // // canvasのメディアンフィルタ
    // median: function (data, width) {
    //   const _data = data.slice()
    //   const getMedian = (color, i) => {
    //     const prevLine = i - (width * 4)
    //     const nextLine = i + (width * 4)
    //     const colors = [
    //       _data[prevLine - 4 + color], _data[prevLine + color], _data[prevLine + 4 + color],
    //       _data[i - 4 + color], _data[i + color], _data[i + 4 + color],
    //       _data[nextLine - 4 + color], _data[nextLine + color], _data[nextLine + 4 + color],
    //     ]
    //     colors.sort((a, b) => a - b)
    //     return colors[Math.floor(colors.length / 2)]
    //   }
    //   for (let i = width * 4; i < data.length - (width * 4); i += 4) {
    //     if (i % (width * 4) === 0 || i % ((width * 4) + 300) === 0) {
    //       // nop
    //     } else {
    //       data[i] = getMedian(0, i)
    //       data[i + 1] = getMedian(1, i)
    //       data[i + 2] = getMedian(2, i)
    //     }
    //   }
    //   return data
    // },
    // // canvasの2値化
    // mono: function (data) {
    //   const threshold = 255 / 2
    //   const getColor = (data, i) => {
    //     const avg = (data[i] + data[i + 1] + data[i + 2]) / 3
    //     return threshold < avg ? 255 : 0
    //   }
    //   for (let i = 0; i < data.length; i += 4) {
    //     const color = getColor(data, i)
    //     data[i] = data[i + 1] = data[i + 2] = color
    //   }
    //   return data
    // },
    // onGrayScale: function () {
    //   this.isGrayScale = true
    // },
    // onBitwiseNot: function () {
    //   this.isBitwiseNot = !this.isBitwiseNot
    // },
    // onMedian: function () {
    //   this.isMedian = !this.isMedian
    // },
    // onMono: function () {
    //   this.isMono = !this.isMono
    // },
  }
}
</script>

<style>
html, body, #app {
  height: 100%;
  background: #f0f0f0;
}

.wrap {
  min-height: 100%;
  height: auto !important;
  height: 100%;
  margin: 0 auto -120px;
  overflow: auto;
}

.push, footer {
  height: 120px;
  margin-top: 0;
}
</style>
