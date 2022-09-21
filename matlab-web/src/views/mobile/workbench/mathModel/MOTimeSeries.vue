<template>
  <div style="position: fixed;left: 0;right: 0;bottom: 0;">
    <el-tabs v-model="activeName" tab-position="bottom" :stretch="true">
      <el-tab-pane name="home">
        <span slot="label"><i class="el-icon-s-home"></i> 实验</span>
        <!--标题-->
        <div style="margin-top: 0">
          <el-tabs type="border-card" :stretch="true">
            <el-tab-pane label="问题分析">
              <div style="height: 60px;font-size: 14px;font-weight: bold;text-align: center">
                某企业1月~11月份的销售收入时间序列如下表所示(可以修改数据进行多次实验)。试用一次简单滑动平均法预测第12月份的销售收入。
              </div>
              <el-tabs>
                <el-tab-pane label="控制台">
                  <div style="height: 380px;overflow-y: auto">
                    <table style="border: 2px">
                      <tr>
                        <th>月份t</th>
                        <th>销售收入y</th>
                      </tr><br/>
                      <tr v-for="item in revenueList" :key="item.month">
                        <td>{{item.month}}</td>
                        <td><el-input v-model="item.revenue"></el-input></td>
                      </tr>
                    </table>
                  </div>
                  <div style="margin-top: 20px;text-align: center">
                    <el-button type="primary" @click="drawSequenceDiagram">绘制时序图</el-button>
                  </div>
                </el-tab-pane>
                <el-tab-pane label="图像">
                  <div style="height: 380px;width: 400px;overflow-y: auto" id="SequenceDiagramDiv">

                  </div>
                  <div style="margin-top: 60px;text-align: center" >

                  </div>
                </el-tab-pane>
              </el-tabs>
            </el-tab-pane>
            <el-tab-pane label="简单移动平均法预测">
              <div style="height: 60px;font-size: 14px;font-weight: bold;text-align: center">
                取移动平均的项数 N < T，使用一次简单移动平均值计算公式计算预测值和预测误差
              </div>
              <el-tabs>
                <el-tab-pane label="控制台">
                  <div style="height: 380px;overflow-y: auto">
                    <div>
                      N(移动平均的项数)
                      <el-input-number v-model="N" controls-position="right" :min="1"></el-input-number>
                    </div>
                    <br/><br/>
                    <div style="text-align: center"><el-button type="primary" @click="calc">计算预测值和预测误差</el-button></div>
                    <br/><br/><br/>
                    <div style="text-align: center">
                      <table>
                        <tr>
                          <td>第12期的预测值：</td>
                          <td><div style="background-color:#fff;height: 100%;line-height: 50px" v-text="result.value"></div></td>
                        </tr>
                        <br/>
                        <tr>
                          <td>预测的标准误差：</td>
                          <td><div style="background-color:#fff;height: 100%;line-height: 50px" v-text="result.error"></div></td>
                        </tr>
                      </table>
                    </div>
                    <br/><br/><br/>
                    <div style="text-align: center"><el-button type="primary" @click="drawCurve">绘制预测曲线</el-button></div>
                  </div>
                  <div style="margin-top: 60px;text-align: center" >

                  </div>
                </el-tab-pane>
                <el-tab-pane label="图像">
                  <div style="height: 380px;width: 400px;overflow-y: auto" id="curveDiv">

                  </div>
                  <div style="margin-top: 60px;text-align: center" >

                  </div>
                </el-tab-pane>
              </el-tabs>

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
</template>

<script>
import axios from "axios";
import qs from 'qs';
import MOCategory from "@/components/mobile/MOCategory";
export default {
  name: "MOTimeSeries",
  components: {
    MOCategory
  },
  data() {
    return {
      activeName: 'home',
      revenueList: [
        {month: 1,revenue: 533.8000},{month: 2,revenue: 574.6000},{month: 3,revenue: 606.9000},{month: 4,revenue: 649.8000},
        {month: 5,revenue: 705.1000},{month: 6,revenue: 772},{month: 7,revenue: 816.4000},{month: 8,revenue: 892.7000},
        {month: 9,revenue: 963.9000},{month: 10,revenue: 1.0151e+03},{month: 11,revenue: 1.1027e+03}
      ],
      N: 4,
      result: {
        value: null,
        error: null
      }
    }
  },
  methods: {
    drawSequenceDiagram() {
      //图像数组
      let data = [];
      let arr = [];
      for (let i = 0;i<this.revenueList.length;i++){
        data.push([this.revenueList[i].month,this.revenueList[i].revenue]);
        arr.push(this.revenueList[i].revenue);
      }
      //坐标轴范围
      let miny = Math.floor(Math.min.apply(null,arr));
      miny = miny-miny%100;
      let maxy = Math.ceil(Math.max.apply(null,arr));
      if (maxy%100!==0){
        maxy = maxy+(100-maxy%100);
      }

      let myChart = this.$echarts.init(document.getElementById("SequenceDiagramDiv"))
      myChart.setOption({
        title: {
          text: '1月~11月销售收入时序图'
        },
        animation: false,//开启动画
        backgroundColor: '#fff',
        axisPointer:{
          show:true//显示标线和刻度
        },
        grid: {//位置
          top: "10%",
          left: "12%",
          right: "20%",
          bottom: "10%"
        },
        xAxis: {
          // name: 'x',
          min: 0,
          max: 12,
          minorTick: {
            show: true //显示次刻度线
          },
          minorSplitLine: {
            show: true //显示次分隔线
          }
        },
        yAxis: {
          name: '销售收入y',
          nameLocation: 'center',
          nameTextStyle:{
            fontSize: 12,
          },
          nameGap:35,
          min: miny,
          max: maxy,
          minorTick: {
            show: true
          },
          minorSplitLine: {
            show: true
          }
        },
        series: [
          {
            type: 'line',
            showSymbol: false,
            clip: true,
            // lineStyle: {},//线条样式
            data: data,
            /*markPoint:{//标注
              data:[{
                name:"fff",
                coord:[res.data[0][0],res.data[0][1]]
              }]
            }*/
          }
        ]
      })
    },
    calc(){
      let arr = [];
      for (let i = 0; i < this.revenueList.length; i++) {
        arr.push(this.revenueList[i].revenue);
      }
      let N = this.N;
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/workbench/math_model/time_series',
        method: 'get',
        params: {
          arr: arr,
          N: N
        },
        paramsSerializer: params=>{
          return qs.stringify(params,{indices: false})
        }
      }).then((res)=>{
        console.log(res);
        this.result.value=res.data[0]
        this.result.error=res.data[1]
      })
    },
    drawCurve(){
      console.log('开始运行');
      //图像数组
      let data = [];
      let arr = [];
      for (let i = 0;i<this.revenueList.length;i++){
        data.push([this.revenueList[i].month,this.revenueList[i].revenue]);
        arr.push(this.revenueList[i].revenue);
      }
      data.push([12,this.result.value])
      arr.push(this.result.value)
      // console.log(data);
      //坐标轴范围
      console.log(arr)
      let miny = Math.floor(Math.min.apply(null,arr));
      miny = miny-miny%100;
      let maxy = Math.ceil(Math.max.apply(null,arr));
      if (maxy%100!==0){
        maxy = maxy+(100-maxy%100);
      }
      // console.log(miny,maxy);

      let myChart = this.$echarts.init(document.getElementById("curveDiv"))
      myChart.setOption({
        title: {
          text: '销售收入时序图'
        },
        animation: false,//开启动画
        backgroundColor: '#fff',
        axisPointer:{
          show:true//显示标线和刻度
        },
        grid: {//位置
          top: "10%",
          left: "12%",
          right: "20%",
          bottom: "10%"
        },
        xAxis: {
          // name: 'x',
          min: 0,
          max: 12,
          minorTick: {
            show: true //显示次刻度线
          },
          minorSplitLine: {
            show: true //显示次分隔线
          }
        },
        yAxis: {
          name: '销售收入y',
          nameLocation: 'center',
          nameTextStyle:{
            fontSize: 12,
          },
          nameGap:35,
          min: miny,
          max: maxy,
          minorTick: {
            show: true
          },
          minorSplitLine: {
            show: true
          }
        },
        /*dataZoom: [//区域缩放
          {
            show: true,
            type: 'inside',
            filterMode: 'none',//不过滤数据，只改变数轴范围
            xAxisIndex: [0],
            startValue: -20,
            endValue: 20
          },
          {
            show: true,
            type: 'inside',
            filterMode: 'none',
            yAxisIndex: [0],
            startValue: -20,
            endValue: 20
          }
        ],*/
        series: [
          {
            type: 'line',
            showSymbol: false,
            clip: true,
            // lineStyle: {},//线条样式
            data: data,
            /*markPoint:{//标注
              data:[{
                name:"fff",
                coord:[res.data[0][0],res.data[0][1]]
              }]
            }*/
          }
        ]
      })
    }
  }
}
</script>

<style scoped>

</style>