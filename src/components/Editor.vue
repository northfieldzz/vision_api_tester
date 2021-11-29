<template>
  <div class="ink-tabs top" data-prevent-url-change="true">
    <ul class="tabs-nav">
      <li><a class="tabs-tab" href="#setting">Setting</a></li>
      <li><a class="tabs-tab" href="#format">Format</a></li>
      <li>
        <RequestButton @update-request="updateRequest"
                       @responded="responded"
                       :image="image"
                       :rectangles="rectangles"
                       :feature-type="featureType.documentTextDetection"
                       :api-key="apiKey"/>
      </li>
    </ul>

    <div id="setting" class="tabs-content">
      <form class="ink-form">
        <div class="control-group column-group">
          <label for="file" class="all-20">Image</label>
          <div class="control all-80">
            <input id="file" name="file" type="file" accept="image/*" value="ファイルを選択" @change="onChangeFile">
          </div>
        </div>

        <div class="control-group column-group">
          <label for="apiKey" class="all-20">Api Key</label>
          <div class="control all-80">
            <input id="apiKey" name="apiKey" type="text" v-model="apiKey" placeholder="Input Api key issued GCP">
          </div>
        </div>
      </form>
    </div>

    <div id="format" class="tabs-content">
      <form class="ink-form">
        <div v-for="(rectangle, index) in rectangles" :key="index">
          <Rectangle @remove="removeRectangle"
                     @input="inputRectangle"
                     :m-index="index"
                     :m-identify="rectangle.identify"
                     :m-result="rectangle.result"
                     :m-vertices="rectangle.vertices"
                     :m-error="rectangle.error"/>
        </div>
        <button type="button" class="ink-button blue" @click="addRectangle">Add</button>
      </form>
    </div>

  </div>
</template>

<script>
import RequestButton from "@/components/RequestButton";
import Rectangle from "@/components/Rectangle";

export default {
  name: "Editor",
  components: {
    Rectangle,
    RequestButton,
  },
  props: [
    'image'
  ],
  data: function () {
    return {
      apiKey: '',
      rectangles: [],
      canvas: document.createElement('canvas'),
      featureType: {
        textDetection: 'TEXT_DETECTION',
        documentTextDetection: 'DOCUMENT_TEXT_DETECTION'
      },
    }
  },
  computed: {
    context: function () {
      return this.canvas.getContext('2d')
    },
  },
  watch: {
    rectangles: {
      handler: function () {
        this.$emit('updateRectangles', this.rectangles)
      },
      deep: true
    }
  },
  methods: {
    /**
     * 選択ファイル変更時のイベントハンドル
     * @param event
     * @returns {Promise<void>}
     */
    onChangeFile: function (event) {
      const files = event.target.files || event.dataTransfer.files
      this.fileReader(files[0])
          .then((image) => {
            this.$emit('onChangeFile', image)
          })
    },
    /**
     * 選択ファイルの読み取り
     * @param file
     * @returns {Promise<unknown>}
     */
    fileReader: function (file) {
      return new Promise((resolve) => {
        const accept = {binary: ['image/png', 'image/jpeg']}
        if (file !== null) {
          if (accept.binary.indexOf(file.type) > -1) {
            const reader = new FileReader()
            reader.onload = (event) => resolve(event.target.result)
            reader.readAsDataURL(file)
          }
        }
      })
    },

    /**
     * 矩形の追加
     */
    addRectangle: function () {
      this.rectangles.push({
        identify: '',
        vertices: {
          start: {x: 0, y: 0},
          end: {x: 10, y: 10}
        },
        error: '',
        result: ''
      })
    },
    /**
     * 矩形の削除
     * @param index
     */
    removeRectangle: function (index) {
      this.rectangles.splice(index, 1);
    },
    /**
     * 矩形の変更
     * @param index
     * @param value
     */
    inputRectangle: function (index, value) {
      this.rectangles[index].identify = value.identify
      this.rectangles[index].vertices = value.vertices
    },

    updateRequest: function (value) {
      this.$emit('updateRequest', value)
    },
    /**
     *
     * @param data
     */
    responded: function (data) {
      for (const [index, rect] of this.rectangles.entries()) {
        rect.result = data.responses[index].fullTextAnnotation.text
      }
      this.$emit('responded', this.rectangles)
    }
  }
}
</script>

<style scoped>

</style>