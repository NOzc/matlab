<template>
  <div class="minpf-pc">
    <!--  顶部标题部分  -->
    <div style="height: 12%;padding: 10px;position: relative;background-color:#283443;">
      <p-c-title-area @run="run" @pause="pause" @displayDrawer="displayDrawer" @showDialog="showDialog" title="用外点罚函数法求解线性等式约束多维函数的极值"/>
    </div>

    <!--  左边参数设置区域  -->
    <div id="workarea" style="height: 85%;width: 30%;position: absolute;left: 0;">
      <p-c-params-area ref="paramsArea">
        <div slot="one">
          <table>
            <tr>
              <td>目标函数f：</td>
              <td><el-input clearable v-model="parameters.func" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="two">
          <table>
            <tr>
              <td>初始点x0：</td>
              <td><el-input clearable v-model="parameters.x0.x0l" :disabled="disabledStatus"></el-input></td>
              <td><el-input clearable v-model="parameters.x0.x0r" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="three">
          <table>
            <tr>
              <td>约束矩阵A：</td>
              <td><el-input clearable v-model="parameters.a.al" :disabled="disabledStatus"></el-input></td>
              <td><el-input clearable v-model="parameters.a.ar" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="four">
          <table>
            <tr>
              <td>约束右端向量b：</td>
              <td><el-input clearable v-model="parameters.b" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="five">
          <table>
            <tr>
              <td>罚参数的初始...：</td>
              <td><el-input clearable v-model="parameters.penparInit" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="six">
          <table>
            <tr>
              <td>罚参数的比例...：</td>
              <td><el-input clearable v-model="parameters.penparPro" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="seven">
          <table>
            <tr>
              <td>自变量向量var：</td>
              <td><el-input clearable v-model="parameters.var.vl" :disabled="disabledStatus"></el-input></td>
              <td><el-input clearable v-model="parameters.var.vr" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
        <div style="margin-top: 50px" slot="eight">
          <table>
            <tr>
              <td>精度eps：</td>
              <td><el-input clearable v-model="parameters.eps" :disabled="disabledStatus"></el-input></td>
            </tr>
          </table>
        </div>
      </p-c-params-area>
    </div>

    <!--  右边图像显示部分  -->
    <div style="height: 85%;width: 70%;position: absolute;right: 0">
      <p-c-func-img-area ref="funcImgArea"/>
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
  name: "PCMinPF",
  components: {
    PCTitleArea,
    PCParamsArea,
    PCFuncImgArea,
    PCDrawer
  },
  data() {
    return {
      parameters: {
        func:'0.5*t^2+s^2/4',
        x0:{x0l:0,x0r:0},
        a:{al:1,ar:1},
        b:1,
        penparInit:0.05,
        penparPro:2,
        var:{vl:'t',vr:'s'},
        eps:0.01
      },
      disabledStatus: false,
      dialogVisible: false,
      imageStyle: {
        line: {
          lineTypes: [{value:'-',label:'实线'},{value:'--',label:'虚线'},{value:':',label:'点线'},{value:'-.',label:'点划线'}],
          lineType: '-',
          lineColor: '#0C0D0D'
        },
        marker: {
          markerPointTypes: [
            {value:'o',label:'圆圈'},
            {value:'+',label:'加号'},
            {value:'*',label:'星号'},
            {value:'.',label:'观点'},
            {value:'_',label:'水平线'},
            {value:'|',label:'垂线'},
            {value:'s',label:'正方形'},
            {value:'d',label:'钻石'},
            {value:'>',label:'右三角'},
            {value:'<',label:'左三角'},
            {value:'p',label:'五角星'},
            {value:'h',label:'卦'}
          ],
          markerPointType: 'o',
          markerPointColor: '#69F50B',
          markerPointSize: 6
        },
        defaultStyle: {
          lineType:'-',lineColor:'#0C0D0D',markerPointType:'o',markerPointColor:'#69F50B',markerPointSize: 6,
        }
      },
      xyStyle: {
        limit: {
          xliml:-1,xlimr:1,yliml:-1,ylimr:1
        },
        label: {
          title:'X', xlabel:'X',ylabel:'Y'
        },
        defaultStyle: {
          limit: {
            xliml:-1,xlimr:1,yliml:-1,ylimr:1
          },
          label: {
            title:'X', xlabel:'X',ylabel:'Y'
          }
        }
      }
    }
  },
  methods: {
    run(payload) {
      //向后端发起请求，获取图像
      this.$refs.funcImgArea.displayMinPF();
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
    }
  }
}
</script>

<style scoped>

</style>
<style>
.minpf-pc .dialog-container .el-dialog{
  height: 60%;
}/*
#workarea .el-input__inner{
  width: 40%;
}*/
</style>