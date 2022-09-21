<template>
  <div class="minps-mobile">
    <!--标题-->
    <div style="padding: 25px 25px 35px 25px;position:fixed;left:0;right:0;top:0;text-align: center;background-color: #802c8c;color: #ffffff;font-size:18px;height:44px">用模式搜索法求解多维函数的极值</div>
    <div style="position: fixed;left: 0;right: 0;bottom: 0;">
      <el-tabs v-model="activeName" tab-position="bottom" :stretch="true">
        <el-tab-pane name="home">
          <span slot="label"><i class="el-icon-s-home"></i> 实验</span>
          <div style="margin-top: 0">
            <el-tabs type="border-card" :stretch="true">
              <el-tab-pane label="参数设置">
                <!--参数-->
                <div style="height: 487px">
                  <table>
                    <tr>
                      <td style="width: 130px">目标函数f：</td>
                      <td><el-input clearable v-model="parameters.func" :disabled="disabledStatus"></el-input></td>
                    </tr><br/>
                  </table>
                  <table>
                    <tr>
                      <td style="width: 130px">初始搜索点x0：</td>
                      <td><el-input clearable v-model="parameters.x0[0]" :disabled="disabledStatus"></el-input></td>
                      <td><el-input clearable v-model="parameters.x0[1]" :disabled="disabledStatus"></el-input></td>
                    </tr><br/>
                    <tr>
                      <td>初始步长delta：</td>
                      <td><el-input clearable v-model="parameters.delta[0]" :disabled="disabledStatus"></el-input></td>
                      <td><el-input clearable v-model="parameters.delta[1]" :disabled="disabledStatus"></el-input></td>
                    </tr><br/>
                    <tr>
                      <td>加速系数gama：</td>
                      <td><el-input clearable v-model="parameters.gama" :disabled="disabledStatus"></el-input></td>
                    </tr><br/>
                    <tr>
                      <td>收缩系数sita：</td>
                      <td><el-input clearable v-model="parameters.sita" :disabled="disabledStatus"></el-input></td>
                    </tr><br/>
                    <tr>
                      <td>精度eps：</td>
                      <td><el-input clearable v-model="parameters.eps" :disabled="disabledStatus"></el-input></td>
                    </tr><br/>
                  </table>
                  <div style="width: 100%;text-align: center;margin-top: 20px;">
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
                        <div style="margin-top: 10%">目标函数最小值点x：</div>
                        <div><el-input v-model="result.x"/></div>
                      </div>
                      <div style="margin-top: 10%">
                        <div>目标函数最小值minf：</div>
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
import 'echarts-gl'
import axios from "axios";
import qs from "qs";
import MOCategory from "@/components/mobile/MOCategory";
export default {
  name: "MOMinPS",
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
        status: false,
        text: ''
      },
      parameters: {
        func:'3*t^2+s^2-2*t*s+4*t+3*s',
        x0: [-2,6],
        delta:[0.2,0.2],
        gama: 1.4,
        sita:0.2,
        eps:0.01
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
          url: 'http://127.0.0.1:8080/matlab-server/workbench/mu/minPS',
          method: 'get',
          params: {
            func: this.parameters.func,
            x0: this.parameters.x0,
            delta: this.parameters.delta,
            gama: this.parameters.gama,
            sita: this.parameters.sita,
            eps: this.parameters.eps,
            xliml: this.xyStyle.limit.xliml,
            xlimr: this.xyStyle.limit.xlimr,
            yliml: this.xyStyle.limit.yliml,
            ylimr: this.xyStyle.limit.ylimr
          },
          paramsSerializer: params=>{
            return qs.stringify(params,{indices: false})
          }
        }).then(res=>{
          this.loading.status=false
          console.log(res);
          this.result.x = res.data[0].toFixed(2)
          this.result.minf = res.data[1].toFixed(2)
          let data = [];
          for (let i = 0;i<res.data[2].length;i++){
            if (i%3===0){
              data.push([res.data[2][i],res.data[2][i+1],res.data[2][i+2]])
              i=i+2;
            }
          }
          console.log("结果数组",data)
          let dom = document.getElementById("mo_imgDiv");
          let myChart = this.$echarts.getInstanceByDom(dom);
          if (myChart == null){
            myChart = this.$echarts.init(dom);
          }
          myChart.clear();
          myChart.setOption({
            visualMap: {
              show: false,
              dimension: 2,
              min: -1,
              max: 1,
              inRange: {
                color: [
                  '#313695',
                  '#4575b4',
                  '#74add1',
                  '#abd9e9',
                  '#e0f3f8',
                  '#ffffbf',
                  '#fee090',
                  '#fdae61',
                  '#f46d43',
                  '#d73027',
                  '#a50026'
                ]
              }
            },
            grid: {
              top: "10%",
              left: "10%",
              right: "10%",
              bottom: "10%"
            },
            xAxis3D: {
              type: 'value'
            },
            yAxis3D: {
              type: 'value'
            },
            zAxis3D: {
              type: 'value'
            },
            grid3D: {
              environment: "auto",
              viewControl: {
                // projection: 'orthographic'
              }
            },
            series: [
              {
                type: 'surface',
                data: data
              }
            ]
          })
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
.minps-mobile .el-tabs__content{
  overflow: scroll;
}
</style>