<template>
  <div class="minsimpsearch-pc" style="height: 100vh;width: 100%;">
    <!--  顶部标题部分  -->
    <div style="height: 15%;padding: 10px;position: relative;background-color: #802c8c;">
      <p-c-title-area @run="run" @pause="pause" @displayDrawer="displayDrawer" @showDialog="showDialog" @resetAllSettings='resetAllSettings' title="用单纯形搜索法求解多维函数的极值"/>
    </div>
    <div style="height: 2%;width: 100%;background-color: #4982f4;"></div>
    <div style="width: 100%;height: 83%;position: relative">
      <!--  左边参数设置区域  -->
      <div id="workarea" style="height: 100%;width: 30%;position: absolute;">
        <p-c-params-area ref="paramsArea">
          <table>
            <tr>
              <td style="width: 140px">目标函数f：</td>
              <td><el-input clearable v-model="parameters.func" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
          </table>
          <table>
            <tr>
              <td>初始单纯形x1：</td>
              <td><el-input clearable v-model="parameters.x[0][0]" :disabled="disabledStatus"></el-input></td>
              <td><el-input clearable v-model="parameters.x[1][0]" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td>初始单纯形x2：</td>
              <td><el-input clearable v-model="parameters.x[0][1]" :disabled="disabledStatus"></el-input></td>
              <td><el-input clearable v-model="parameters.x[1][1]" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td>初始单纯形x3：</td>
              <td><el-input clearable v-model="parameters.x[0][2]" :disabled="disabledStatus"></el-input></td>
              <td><el-input clearable v-model="parameters.x[1][2]" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td style="width: 140px">反应系数alpha：</td>
              <td><el-input clearable v-model="parameters.alpha" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td>紧缩系数sita：</td>
              <td><el-input clearable v-model="parameters.sita" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td>扩展系数gama：</td>
              <td><el-input clearable v-model="parameters.gama" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td>收缩系数beta：</td>
              <td><el-input clearable v-model="parameters.beta" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
            <tr>
              <td>精度eps：</td>
              <td><el-input clearable v-model="parameters.eps" :disabled="disabledStatus"></el-input></td>
            </tr><br/>
          </table>
        </p-c-params-area>
      </div>
      <div style="background:#4982f4;width: 1%;height: 100%;position: absolute;left: 30%"></div>
      <!--  右边图像显示部分  -->
      <div style="height: 100%;width: 69%;position: absolute;right: 0">
        <p-c-func-img-area ref="funcImgArea">
          <table>
            <tr>
              <td>极值点：</td>
              <td><el-input :value="result.x"/></td>
            </tr>
            <tr>
              <td>极值：</td>
              <td><el-input :value="result.minf"/></td>
            </tr>
          </table>
        </p-c-func-img-area>
      </div>
    </div>

    <!--抽屉-->
    <p-c-drawer ref="drawer"/>

    <!--设置弹出框-->
    <div class="dialog-container">
      <el-dialog title="设置" :visible.sync="dialogVisible" width="30%" style="height: 100%">
        <el-tabs type="border-card" style="height: 75%">
          <el-tab-pane label="图像参数">
            <el-divider content-position="left">Lines</el-divider>
            <div style="margin-left: 50px">
              <table>
                <tr>
                  <td style="width: 120px">曲线类型</td>
                  <td><el-select v-model="imageStyle.line.lineType">
                    <el-option v-for="item in imageStyle.line.lineTypes" :key="item.value" :label="item.label" :value="item.value"/>
                  </el-select></td>
                </tr>
                <tr>
                  <td style="width: 120px">曲线颜色</td>
                  <td><el-color-picker v-model="imageStyle.line.lineColor"></el-color-picker></td>
                </tr>
              </table>
            </div>
            <el-divider content-position="left">Markers</el-divider>
            <div style="margin-left: 50px">
              <table>
                <tr>
                  <td style="width: 120px">标记点型</td>
                  <td><el-select v-model="imageStyle.marker.markerPointType">
                    <el-option v-for="item in imageStyle.marker.markerPointTypes" :key="item.value" :label="item.label" :value="item.value"/>
                  </el-select></td>
                </tr>
                <tr>
                  <td style="width: 120px">标记颜色</td>
                  <td>
                    <el-color-picker v-model="imageStyle.marker.markerPointColor"></el-color-picker>
                  </td>
                </tr>
                <tr>
                  <td style="width: 120px">标记大小</td>
                  <td><el-input-number v-model="imageStyle.marker.markerPointSize" controls-position="right" :min="1" :max="10"></el-input-number></td>
                </tr>
              </table>
            </div>
          </el-tab-pane>
          <el-tab-pane label="坐标轴参数">
            <el-divider content-position="left">Limits</el-divider>
            <div style="margin-left: 50px">
              <table>
                <tr>
                  <td style="width: 120px">x轴范围</td>
                  <td><el-input v-model="xyStyle.limit.xliml"/></td>
                  <td><el-input v-model="xyStyle.limit.xlimr"/></td>
                </tr>
                <tr>
                  <td style="width: 120px">y轴范围</td>
                  <td><el-input v-model="xyStyle.limit.yliml"/></td>
                  <td><el-input v-model="xyStyle.limit.ylimr"/></td>
                </tr>
              </table>
            </div>
            <el-divider content-position="left">Labels</el-divider>
            <div style="margin-left: 50px">
              <table>
                <tr>
                  <td style="width: 120px">标题</td>
                  <td><el-input v-model="xyStyle.label.title"/></td>
                </tr>
                <tr>
                  <td style="width: 120px">x轴标签</td>
                  <td><el-input v-model="xyStyle.label.xlabel"/></td>
                </tr>
                <tr>
                  <td style="width: 120px">y轴标签</td>
                  <td><el-input v-model="xyStyle.label.ylabel"/></td>
                </tr>
              </table>
            </div>
          </el-tab-pane>
        </el-tabs>
        <span slot="footer" class="dialog-footer">
          <el-button @click="defineClick">确 定</el-button>
          <el-button @click="cancelClick">取 消</el-button>
          <el-button type="primary" @click="applyClick">应 用</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import PCParamsArea from "@/components/pc/PCParamsArea";
import PCTitleArea from "@/components/pc/PCTitleArea";
import PCFuncImgArea from "@/components/pc/PCFuncImgArea";
import PCDrawer from "@/components/pc/PCDrawer";

export default {
  name: "PCMinSimpSearch",
  components: {
    PCTitleArea,
    PCParamsArea,
    PCFuncImgArea,
    PCDrawer
  },
  data() {
    return {
      parameters: {
        func:'3*t^2+s^2-t*s+3*s-5',
        x: [[-10,1,8],[-10,4,8]],
        alpha:1.2,
        sita:0.5,
        gama:2,
        beta:0.3,
        eps:0.01
      },
      disabledStatus: false,
      dialogVisible: false,
      imageStyle: {
        line: {
          lineTypes: [{value:'solid',label:'实线'},{value:'dashed',label:'虚线'},{value:'dotted',label:'点线'}],
          lineType: 'solid',
          lineColor: '#9DA0A3'
        },
        marker: {
          markerPointTypes: [
            {value:'circle',label:'圆圈'},
            {value:'rect',label:'正方形'},
            {value:'roundRect',label:'圆角正方形'},
            {value:'triangle',label:'三角'},
            {value:'diamond',label:'菱形'},
            {value:'pin',label:'大头针'},
            {value:'arrow',label:'箭'},
            {value:'none',label:'无'}
          ],
          markerPointType: 'pin',
          markerPointColor: '#409EFF',
          // markerPointColors: [{value:'r',label:'红色'},{value:'g',label:'绿色'},{value:'b',label:'蓝色'},{value:'c',label:'青色'},{value:'m',label:'洋红'},{value:'y',label:'黄色'},{value:'k',label:'黑色'},{value:'w',label:'白色'}],
          markerPointSize: 40
        },
        defaultStyle: {
          lineType:'solid',lineColor:'#9DA0A3',markerPointType:'pin',markerPointColor:'#409EFF',markerPointSize: 40,
        }
      },
      xyStyle: {
        limit: {
          xliml:-5,xlimr:5,yliml:-5,ylimr:5
        },
        label: {
          title:'', xlabel:'x',ylabel:'y'
        },
        defaultStyle: {
          limit: {
            xliml:-5,xlimr:5,yliml:-5,ylimr:5
          },
          label: {
            title:'', xlabel:'x',ylabel:'y'
          }
        }
      },
      result: {
        x: null,minf: null
      }
    }
  },
  methods: {
    run(payload) {
      //向后端发起请求，获取图像
      // this.$refs.funcImgArea.displayMinSimpSearch();
      this.disabledStatus = payload
    },
    pause(payload) {
      this.disabledStatus = payload
    },
    displayDrawer() {
      this.$refs.drawer.drawer = !this.$refs.drawer.drawer;
    },
    showDialog() {
      this.dialogVisible = true;
    },
    defineClick(){
      this.imageStyle.defaultStyle.lineType=this.imageStyle.line.lineType
      this.imageStyle.defaultStyle.lineColor=this.imageStyle.line.lineColor
      this.imageStyle.defaultStyle.markerPointType=this.imageStyle.marker.markerPointType
      this.imageStyle.defaultStyle.markerPointColor=this.imageStyle.marker.markerPointColor
      this.imageStyle.defaultStyle.markerPointSize=this.imageStyle.marker.markerPointSize
      this.xyStyle.defaultStyle.limit.xliml=this.xyStyle.limit.xliml
      this.xyStyle.defaultStyle.limit.xlimr=this.xyStyle.limit.xlimr
      this.xyStyle.defaultStyle.limit.yliml=this.xyStyle.limit.yliml
      this.xyStyle.defaultStyle.limit.ylimr=this.xyStyle.limit.ylimr
      this.xyStyle.defaultStyle.label.title=this.xyStyle.label.title
      this.xyStyle.defaultStyle.label.xlabel=this.xyStyle.label.xlabel
      this.xyStyle.defaultStyle.label.ylabel=this.xyStyle.label.ylabel
      this.dialogVisible = false;
    },
    cancelClick() {
      this.dialogVisible = false;
      this.imageStyle.line.lineType = this.imageStyle.defaultStyle.lineType
      this.imageStyle.line.lineColor = this.imageStyle.defaultStyle.lineColor
      this.imageStyle.marker.markerPointType = this.imageStyle.defaultStyle.markerPointType
      this.imageStyle.marker.markerPointColor = this.imageStyle.defaultStyle.markerPointColor
      this.imageStyle.marker.markerPointSize=this.imageStyle.defaultStyle.markerPointSize
      this.xyStyle.limit.xliml=this.xyStyle.defaultStyle.limit.xliml
      this.xyStyle.limit.xlimr=this.xyStyle.defaultStyle.limit.xlimr
      this.xyStyle.limit.yliml=this.xyStyle.defaultStyle.limit.yliml
      this.xyStyle.limit.ylimr=this.xyStyle.defaultStyle.limit.ylimr
      this.xyStyle.label.title=this.xyStyle.defaultStyle.label.title
      this.xyStyle.label.xlabel=this.xyStyle.defaultStyle.label.xlabel
      this.xyStyle.label.ylabel=this.xyStyle.defaultStyle.label.ylabel
    },
    applyClick() {
      this.imageStyle.defaultStyle.lineType=this.imageStyle.line.lineType
      this.imageStyle.defaultStyle.lineColor=this.imageStyle.line.lineColor
      this.imageStyle.defaultStyle.markerPointType=this.imageStyle.marker.markerPointType
      this.imageStyle.defaultStyle.markerPointColor=this.imageStyle.marker.markerPointColor
      this.imageStyle.defaultStyle.markerPointSize=this.imageStyle.marker.markerPointSize
      this.xyStyle.defaultStyle.limit.xliml=this.xyStyle.limit.xliml
      this.xyStyle.defaultStyle.limit.xlimr=this.xyStyle.limit.xlimr
      this.xyStyle.defaultStyle.limit.yliml=this.xyStyle.limit.yliml
      this.xyStyle.defaultStyle.limit.ylimr=this.xyStyle.limit.ylimr
      this.xyStyle.defaultStyle.label.title=this.xyStyle.label.title
      this.xyStyle.defaultStyle.label.xlabel=this.xyStyle.label.xlabel
      this.xyStyle.defaultStyle.label.ylabel=this.xyStyle.label.ylabel
      this.dialogVisible = false;
    },
    resetAllSettings(){
      //参数设置
      this.parameters.func='3*t^2+s^2-t*s+3*s-5'
      this.parameters.x=[[-10,1,8],[-10,4,8]]
      this.parameters.alpha =1.2
      this.parameters.sita = 0.5
      this.parameters.gama = 2
      this.parameters.beta=0.3
      this.parameters.eps=0.01
      //样式设置
      this.imageStyle.line.lineType = 'solid'
      this.imageStyle.line.lineColor = '#9DA0A3'
      this.imageStyle.marker.markerPointType = 'pin'
      this.imageStyle.marker.markerPointColor = '#409EFF'
      this.imageStyle.marker.markerPointSize = 40
      this.xyStyle.limit.xliml=-5
      this.xyStyle.limit.xlimr=5
      this.xyStyle.limit.yliml=-5
      this.xyStyle.limit.ylimr=5
      this.xyStyle.label.title=''
      this.xyStyle.label.xlabel='x'
      this.xyStyle.label.ylabel='y'
    }
  }
}
</script>

<style scoped>

</style>
<style>
.minsimpsearch-pc .dialog-container .el-dialog{
  height: 60%;
}/*
#workarea .el-input__inner{
  width: 40%;
}*/
</style>