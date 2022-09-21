<template>
<div style="width: 100%;height: 100vh;" class="pw">
  <div style="height: 15%;width: 100%;background-color: #802c8c;;position: relative;">
    <div style="line-height: normal;font-size: 40px;color: #fff;letter-spacing: 5px;position: absolute;right: 24%;top: 20%">数学建模与优化方法可视化实验平台</div>
  </div>
  <div style="height: 85%;width: 100%;position: relative">
    <!--左边-->
    <div style="height: 100%;width: 16%;background-color:#ffffff;overflow: scroll">
      <el-menu class="el-menu-demo" :router="true">
        <el-menu-item index="/pw" :class="{activeColor:1===currentIndex}" @click="changeColor(1)">数学建模课程介绍</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:2===currentIndex}" @click="changeColor(2)">MATLAB WEB简介</el-menu-item><br/>
        <el-menu-item index="/pw/platformIntroduction" :class="{activeColor:3===currentIndex}" @click="changeColor(3)">可视化实验系统平台简介</el-menu-item><br/>
        <el-menu-item index="/pw/work_designer" :class="{activeColor:4===currentIndex}" @click="changeColor(4)">作品设计</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:5===currentIndex}" @click="changeColor(5)">研发目的</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:6===currentIndex}" @click="changeColor(6)">基本思路</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:7===currentIndex}" @click="changeColor(7)">创新点</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:8===currentIndex}" @click="changeColor(8)">技术关键和主要技术指标</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:9===currentIndex}" @click="changeColor(9)">产品反馈</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:10===currentIndex}" @click="changeColor(10)">关于作者</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:11===currentIndex}" @click="changeColor(11)">开发者选项</el-menu-item><br/>
        <el-menu-item index="/pw" :class="{activeColor:12===currentIndex}" @click="changeColor(12)">用户使用手册</el-menu-item>
      </el-menu>
    </div>
    <!---右边-->
    <div style="height: 100%;width: 84%;position: absolute;right: 0;top: 0">
      <router-view/>
    </div>
  </div>
</div>
</template>

<script>
export default {
  name: "PW",
  data() {
    return {
      currentIndex: 1
    }
  },
  methods: {
    changeColor(index){
      this.currentIndex = index
    }
  }
}
</script>

<style scoped>
.activeColor{
  color: #224ff4;
}
</style>
<style>
.pw .el-menu{
  background-color: transparent !important;/* 背景透明 */
}
.pw .el-menu--inline{
  background-color: transparent !important;/* 背景透明 */
}
.pw .el-menu-item{
  background-color: transparent !important;/* 背景透明 */
  color: #1a1a1a;
  font-size: 18px;
}

</style>