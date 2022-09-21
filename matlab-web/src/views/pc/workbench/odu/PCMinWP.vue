<template>
  <div class="minwp-pc" style="height: 100vh;width: 100%;">
    <!--  顶部标题部分  -->
    <div style="height: 15%;padding: 10px;position: relative;background-color: #802c8c;">
      <p-c-title-area @run="run" @pause="pause" @displayDrawer="displayDrawer" @showDialog="showDialog" @resetAllSettings='resetAllSettings' title="用Wolfe-Powell法求解一维函数的极值"/>
    </div>
    <div style="height: 2%;width: 100%;background-color: #4982f4;"></div>
    <div style="width: 100%;height: 83%;position: relative">
      <!--  左边参数设置区域  -->
      <div id="workarea" style="height: 100%;width: 30%;position: absolute;left: 0;">
        <p-c-params-area ref="paramsArea">
          <div>
            <el-divider>目标函数f</el-divider>
            <el-input clearable v-model="parameters.func" :disabled="disabledStatus" style="width: 100%"></el-input>
            <el-divider>搜索最大值XMAX</el-divider>
            <el-input clearable v-model="parameters.XMAX" :disabled="disabledStatus"></el-input>
            <el-divider>可接受系数1</el-divider>
            <el-input clearable v-model="parameters.sigma1" :disabled="disabledStatus"></el-input>
            <el-divider>可接受系数2</el-divider>
            <el-input clearable v-model="parameters.sigma2" :disabled="disabledStatus"></el-input>
            <el-divider>增大探索点系数</el-divider>
            <el-input clearable v-model="parameters.alpha" :disabled="disabledStatus"></el-input>
            <el-divider>精度</el-divider>
            <el-input clearable v-model="parameters.eps" :disabled="disabledStatus"></el-input>
          </div>
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
                  <td>
                    <!--                    <el-select v-model="imageStyle.line.lineColor">
                                          <el-option v-for="item in imageStyle.line.lineColors" :key="item.value" :label="item.label" :value="item.value"/>
                                        </el-select>-->
                    <el-color-picker v-model="imageStyle.line.lineColor"></el-color-picker>
                  </td>
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
                    <!--                    <el-select v-model="imageStyle.marker.markerPointColor">
                                          <el-option v-for="item in imageStyle.marker.markerPointColors" :key="item.value" :label="item.label" :value="item.value"/>
                                        </el-select>-->
                    <el-color-picker v-model="imageStyle.marker.markerPointColor"></el-color-picker>
                  </td>
                </tr>
                <tr>
                  <td style="width: 120px">标记大小</td>
                  <td><el-input-number v-model="imageStyle.marker.markerPointSize" controls-position="right" :min="1"></el-input-number></td>
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
import axios from "axios";
export default {
  name: "PCMinWP",
  components: {
    PCTitleArea,
    PCParamsArea,
    PCFuncImgArea,
    PCDrawer
  },
  data() {
    return {
      parameters: {
        func:'t^3-3*t+2',
        XMAX:8,
        sigma1:0.1,
        sigma2:0.65,
        alpha:2,
        eps:1.0e-6
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
          xliml:-5,xlimr:5,yliml:-10,ylimr:10
        },
        label: {
          title:'', xlabel:'x',ylabel:'y'
        },
        defaultStyle: {
          limit: {
            xliml:-5,xlimr:5,yliml:-10,ylimr:10
          },
          label: {
            title:'', xlabel:'x',ylabel:'y'
          }
        }
      },
      result:{
        x:'',minf: ''
      }
    }
  },
  methods: {
    run(payload) {
      //向后端发起请求，获取图像
      if (this.parameters.sigma1<0||this.parameters.sigma1>1){
        this.$message.error('sigma1取值范围：0~1');
        return;
      }
      this.$refs.funcImgArea.loading.status = true;
      this.$refs.funcImgArea.loading.text = "请稍等...."
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minWP',
        method: 'get',
        params: {
          func: this.parameters.func,
          XMAX: this.parameters.XMAX,
          sigma1: this.parameters.sigma1,
          sigma2: this.parameters.sigma2,
          alpha: this.parameters.alpha,
          eps: this.parameters.eps,
          xliml: this.xyStyle.limit.xliml,
          xlimr: this.xyStyle.limit.xlimr
        }
      }).then((res)=>{
        this.$refs.funcImgArea.loading.status = false;
        console.log(res);
        this.result.x = res.data[0].toFixed(2)
        this.result.minf = res.data[1].toFixed(2)
        let data = [];
        for (let i = 0;i<res.data[2].length;i++){
          if (i%2===0){
            data.push([res.data[2][i],res.data[2][i+1]])
            i++;
          }
        }
        console.log('结果数组',data);
        let dom = this.$refs.funcImgArea.$refs.imgResDiv
        let myChart = this.$echarts.getInstanceByDom(
            dom
        );
        if (myChart == null){
          myChart = this.$echarts.init(dom);
        }
        myChart.clear();
        myChart.setOption({
          title: {
            text: this.xyStyle.label.title
          },
          animation: false,
          axisPointer:{
            show:true
          },
          grid: {
            top: "10%",
            left: "10%",
            right: "10%",
            bottom: "10%"
          },
          xAxis: [{
            name: this.xyStyle.label.xlabel,
            min: this.xyStyle.limit.xliml,
            max: this.xyStyle.limit.xlimr,
            minorTick: {
              show: true
            },
            minorSplitLine: {
              show: true
            }
          }],
          yAxis: [{
            name: this.xyStyle.label.ylabel,
            min: this.xyStyle.limit.yliml,
            max: this.xyStyle.limit.ylimr,
            minorTick: {
              show: true
            },
            minorSplitLine: {
              show: true
            }
          }],
          dataZoom: [
            {
              // show: true,
              type: 'inside',
              filterMode: 'none',
              xAxisIndex: 0,
              // startValue: -20,
              // endValue: 20
            },
            {
              show: true,
              type: 'inside',
              filterMode: 'none',
              yAxisIndex: 0,
              // startValue: -20,
              // endValue: 20
            }
          ],
          series: [
            {
              type: 'line',
              showSymbol: false,
              clip: true,
              lineStyle: { //线条样式
                color: this.imageStyle.line.lineColor,
                type: this.imageStyle.line.lineType
              },
              data: data,
              markPoint:{//标注
                symbol: this.imageStyle.marker.markerPointType,
                symbolSize: this.imageStyle.marker.markerPointSize,
                itemStyle: {
                  color: this.imageStyle.marker.markerPointColor
                },
                data:[{
                  name:"fff",
                  coord:[res.data[0],res.data[1]],
                  value: "("+res.data[0].toFixed(2)+","+res.data[1].toFixed(2)+")"
                }]
              }
            }
          ]
        })
      })
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
      this.parameters.func='t^3-3*t+2'
      this.parameters.XMAX=8
      this.parameters.sigma1=0.1
      this.parameters.sigma2=0.65
      this.parameters.alpha=2
      this.parameters.eps=1.0e-6
      //样式设置
      this.imageStyle.line.lineType = 'solid'
      this.imageStyle.line.lineColor = '#9DA0A3'
      this.imageStyle.marker.markerPointType = 'pin'
      this.imageStyle.marker.markerPointColor = '#409EFF'
      this.imageStyle.marker.markerPointSize = 40
      this.xyStyle.limit.xliml=-5
      this.xyStyle.limit.xlimr=5
      this.xyStyle.limit.yliml=-10
      this.xyStyle.limit.ylimr=10
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
 .minwp-pc .dialog-container .el-dialog{
  height: 60%;
}
</style>