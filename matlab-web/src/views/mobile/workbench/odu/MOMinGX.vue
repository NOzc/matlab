<template>
  <div class="mingx-mobile">
    <div style="padding: 25px 25px 35px 25px;position:fixed;left:0;right:0;top:0;text-align: center;background-color:#802c8c;color: #ffffff;font-size:18px;height:44px">用割线法求解一维函数的极值</div>
    <div style="position: fixed;left: 0;right: 0;bottom: 0;">
      <el-tabs v-model="activeName" tab-position="bottom" :stretch="true">
        <el-tab-pane name="home">
          <span slot="label"><i class="el-icon-s-home"></i> 实验</span>
          <!--标题-->
          <div style="margin-top: 0">
            <el-tabs type="border-card" :stretch="true">
              <el-tab-pane label="参数设置">
                <!--参数-->
                <div style="height: 463px">
                  <el-divider>目标函数f</el-divider>
                  <el-input clearable v-model="parameters.func" :disabled="disabledStatus"></el-input>
                  <el-divider>初始点x0</el-divider>
                  <el-input clearable v-model="parameters.x0" :disabled="disabledStatus"></el-input>
                  <el-divider>初始点x1</el-divider>
                  <el-input clearable v-model="parameters.x1" :disabled="disabledStatus"></el-input>
                  <el-divider>精度eps</el-divider>
                  <el-input clearable v-model="parameters.eps" :disabled="disabledStatus"></el-input>
                  <div style="width: 100%;text-align: center;margin-top: 10%">
                    <el-button @click="run" v-html="runBtnHtml">运行</el-button>
                  </div>
                </div>
              </el-tab-pane>
              <el-tab-pane label="样式设置">
                <div style="height: 447px">
                  <el-tabs>
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
                </div>
                <div style="width: 100%;text-align: center">
                  <span><el-button @click="resetSettings">重置</el-button></span>
                </div>
              </el-tab-pane>
              <el-tab-pane label="运行结果">
                <div style="height: 487px">
                  <el-tabs>
                    <el-tab-pane label="图像视图">
                      <div id="mo_imgDiv" style="width: 360px;height: 400px;"
                           v-loading="loading.status"
                           :element-loading-text="loading.text"
                           element-loading-spinner="el-icon-loading"
                           element-loading-background="rgba(0, 0, 0, 0.8)">

                      </div>
                    </el-tab-pane>
                    <el-tab-pane label="数值结果视图">
                      <div>
                        <div style="margin-top: 10%">极值点：</div>
                        <div><el-input v-model="result.x"/></div>
                      </div>
                      <div style="margin-top: 10%">
                        <div>极值：</div>
                        <div><el-input v-model="result.minf"/></div>
                      </div>
                    </el-tab-pane>
                  </el-tabs>
                </div>
              </el-tab-pane>
            </el-tabs>
          </div>
        </el-tab-pane>
        <el-tab-pane name="profile" style="height: 500px">
          <span slot="label"><i class="el-icon-user-solid"></i> 分类</span>
          <div style="background-color:#ffffff;">
            <m-o-category/>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import MOCategory from "@/components/mobile/MOCategory";
export default {
  name: "MOMinGX",
  components: {
    MOCategory
  },
  computed: {
    runBtnHtml(){
      if (this.disabledStatus === true){
        return '暂停'
      }else {
        return '运行'
      }
    }
  },
  data() {
    return {
      activeName: 'home',
      loading: {
        status: false,text: ''
      },
      parameters: {
        func:'t^3-3*t+2',
        x0: 5,
        x1: 8,
        eps: 1.0e-6
      },
      disabledStatus: false,
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
          xliml:-3,xlimr:3,yliml:0,ylimr:8
        },
        label: {
          title:'', xlabel:'x',ylabel:'y'
        },
        defaultStyle: {
          limit: {
            xliml:-3,xlimr:3,yliml:0,ylimr:8
          },
          label: {
            title:'', xlabel:'x',ylabel:'y'
          }
        }
      },
      imgResHtml: '',
      result: {
        x: '',
        minf: ''
      },
    }
  },
  methods: {
    resetSettings(){
      this.dialogVisible = false;
      this.imageStyle.line.lineType = this.imageStyle.defaultStyle.lineType
      this.imageStyle.line.lineColor = this.imageStyle.defaultStyle.lineColor
      this.imageStyle.marker.markerPointType = this.imageStyle.defaultStyle.markerPointType
      this.imageStyle.marker.markerPointColor = this.imageStyle.defaultStyle.markerPointColor
      this.xyStyle.limit.xliml=this.xyStyle.defaultStyle.limit.xliml
      this.xyStyle.limit.xlimr=this.xyStyle.defaultStyle.limit.xlimr
      this.xyStyle.label.title=this.xyStyle.defaultStyle.label.title
      this.xyStyle.label.xlabel=this.xyStyle.defaultStyle.label.xlabel
      this.xyStyle.label.ylabel=this.xyStyle.defaultStyle.label.ylabel
    },
    run() {
      if (this.disabledStatus === false){
        this.loading.status = true
        this.loading.text='请稍等....'
        console.log("开始运行")
        axios({
          url: 'http://127.0.0.1:8080/matlab-server/workbench/odu/minGX',
          method: 'get',
          params: {
            func: this.parameters.func,
            x0: this.parameters.x0,
            x1: this.parameters.x1,
            eps: this.parameters.eps,
            xliml: this.xyStyle.limit.xliml,
            xlimr: this.xyStyle.limit.xlimr
          }
        }).then(res=>{
          this.loading.status = false;
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
          let dom = document.getElementById("mo_imgDiv");
          let myChart = this.$echarts.getInstanceByDom(dom);
          if (myChart == null){
            myChart = this.$echarts.init(dom);
          }
          myChart.clear();
          setTimeout(myChart.setOption({
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
          }),1000)
        })
      }
      this.disabledStatus = !this.disabledStatus
    },
  }
}
</script>

<style scoped>

</style>
<style>
.mingx-mobile .el-tabs__content{
  overflow: scroll;
}
</style>