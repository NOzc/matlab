<template>
  <div>
    <el-tabs type="border-card" style="height: 100%">
      <el-tab-pane label="图像视图">
        <div style="height:675px;text-align: center;" id="imgRes"
             v-loading="loading.status"
             :element-loading-text="loading.text"
             element-loading-spinner="el-icon-loading"
             element-loading-background="rgba(0, 0, 0, 0.8)">
          <div style="margin-top: 2%;width: 100%;height: 100%" ref="imgResDiv">

          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="数值结果视图">
        <div style="width: 1300px;height:700px;position: relative;" id="numRes">
          <div style="margin: 0 auto">
            <slot></slot>
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "PCFuncImgArea",
  data() {
    return {
      numResHtml: '',
      imgResHtml: '',
      res: {
        x: '',
        minf: ''
      },
      loading: {
        status: false,
        text: '',
      }
    }
  },
  methods: {
    displayMinNewton() {
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>极值点：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>极值：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinPS() {
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数取最小值时的自变量x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数的最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinSimpSearch(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数最小值点x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinRb(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数取最小值时的自变量值x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinRosen(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数最小值点x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinPF(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数最小值点x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinGeneralPF(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数最小值点x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMinNF(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数最小值点x：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值minf：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
          },
    displayIntProgFZ(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/IntProgFZ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'>"+
      "<span style='font-size: 18px'>x1：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p><span style='font-size: 18px'>x2：</span><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>"+
         "<span style='font-size: 18px'>x3：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/> </div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值y：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayDividePlane(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/DividePlane',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'>目标函数取最小时的自变量值<p>"+
      "<span style='font-size: 18px'>x1：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p><span style='font-size: 18px'>x2：</span><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数最小值y：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayZeroOneprog(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/ZeroOneprog',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'>"+
      "<span style='font-size: 18px'>x1：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p><span style='font-size: 18px'>x2：</span><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>" +
          "<span style='font-size: 18px'>x3：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>"+
          "<span style='font-size: 18px'>x4：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>"+
          "<span style='font-size: 18px'>x5：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>"+
          "<span style='font-size: 18px'>目标函数最小值y：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayQuadLagR(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/QuadLagR',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'>"+
      "<span style='font-size: 18px'>x1：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p><span style='font-size: 18px'>x2：</span><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>" +
          "<span style='font-size: 18px'>目标函数最小值y：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayActivdeSet(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/ActivdeSet',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'>"+
      "<span style='font-size: 18px'>x1：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p><span style='font-size: 18px'>x2：</span><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>" +
          "<span style='font-size: 18px'>目标函数最小值y：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayTrackRoute(){
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/TrackRoute',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'>"+
      "<span style='font-size: 18px'>x1：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p><span style='font-size: 18px'>x2：</span><input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/><p>" +
          "<span style='font-size: 18px'>目标函数最小值y：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
    displayMyGA() {
      console.log('显示图像');
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minHJ',
        method: 'get'
      }).then((res)=>{
        this.imgResHtml = res.data
      })
      this.numResHtml = "<div style='position: absolute;width:100%;left: 20%;top: 20%'><span style='font-size: 18px'>目标函数取最小值时的自变量值xm：</span>" +
          "<input type='text' value='呵呵' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>" +
          "<div style='position: absolute;width:100%;left: 20%;top: 50%'><span style='font-size: 18px'>目标函数的最小值fv：</span>" +
          "<input type='text' value='嗯嗯' style='-webkit-appearance: none;\n" +
          "background-color: #FFF;\n" +
          "border-radius: 4px;\n" +
          "border: 1px solid #DCDFE6;\n" +
          "box-sizing: border-box;\n" +
          "color: #606266;\n" +
          "display: inline-block;\n" +
          "font-size: inherit;\n" +
          "height: 40px;\n" +
          "line-height: 40px;\n" +
          "outline: 0;\n" +
          "padding: 0 15px;\n" +
          "transition: border-color .2s cubic-bezier(.645,.045,.355,1);\n" +
          "width: 20%;' disabled/></div>"
    },
  }
}
</script>

<style scoped>

</style>