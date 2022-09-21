<template>
  <div class="title-area">
    <!--左边展开按钮-->
    <div>
      <el-button icon="el-icon-s-unfold" circle @click="displayDrawer"></el-button>
    </div>
    <div style="margin: 0 auto 3% 20%;width: 80%;line-height: normal;font-size: 40px;color: #fff;letter-spacing: 5px" :style="{marginLeft: left+'%'}">{{title}}</div>
    <el-button-group style="position: absolute;right: 10%;top: 30%" class="four-btn">
      <el-button type="info" @click="run" v-html="runBtnHtml"></el-button>
      <el-button type="info" @click="resetAllSettings"><i class="el-icon-refresh" style="font-size: 30px"></i> <br/><br/>重置</el-button>
      <el-button type="info"><i class="el-icon-eleme" style="font-size: 30px"></i> <br/><br/>随机</el-button>
      <el-button type="info" @click="showDialog"><i class="el-icon-setting" style="font-size: 30px"></i> <br/><br/>设置</el-button>
    </el-button-group>
  </div>
</template>

<script>
export default {
  name: "PCTitleArea",
  props: {
    title: {
      type: String,
      default: '可视化实验系统'
    },
    left: {
      type: Number,
      default: 20
    }
  },
  data() {
    return {
      currentStatus : false,
      drawer: false
    }
  },
  computed: {
    runBtnHtml(){
      if (this.currentStatus === true){
        return '<i class="el-icon-video-pause" style="font-size: 30px"></i><br/><br/> 暂停'
      }else {
        return '<i class="el-icon-video-play" style="font-size: 30px"></i><br/><br/> 运行'
      }
    }
  },
  methods: {
    run() {
      this.currentStatus = !this.currentStatus
      if (this.currentStatus === true){
        this.$emit('run',true)
      }else {
        this.$emit('pause',false)
      }
    },
    displayDrawer() {
      this.$emit('displayDrawer')
    },
    showDialog() {
      this.$emit('showDialog')
    },
    resetAllSettings() {
      this.$emit('resetAllSettings')
    }
  }
}
</script>

<style scoped>

</style>
<style>
.four-btn .el-button{
  background-color: transparent !important;/* 背景透明 */
}
</style>