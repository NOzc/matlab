<template>
<div class="mm_test" style="height: 100vh;width: 100%">
  <div style="position: fixed;z-index: 1100;right: 10%">
    <el-button icon="el-icon-s-unfold" circle type="danger" @click="displayDrawer"></el-button>
  </div>
  <el-tabs type="border-card">
    <el-tab-pane label="问题分析" class="onePane">
      <div style="height:855px;text-align: center;background-color: #dce4ec;padding: 50px">
        <div style="height: 10%;font-size: 20px;font-weight: bold;">
          某企业1月~11月份的销售收入时间序列如下表所示(可以修改数据进行多次实验)。试用一次简单滑动平均法预测第12月份的销售收入。
        </div>
        <div style="height: 90%;position: relative">
          <div style="width: 20%;height: 100%;background-color:#fff;text-align: center;padding: 20px;">
            <div style="height: 90%;overflow-y: auto">
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
            <div style="margin-top: 20px">
              <el-button type="primary" @click="drawSequenceDiagram">绘制时序图</el-button>
            </div>
          </div>

          <div style="width: 75%;height: 100%;position: absolute;right: 0;top: 0;" id="SequenceDiagramDiv">

          </div>
        </div>
      </div>
    </el-tab-pane>
    <el-tab-pane label="简单移动平均法预测" class="twoPane">
      <div style="height:855px;text-align: center;background-color: #dce4ec;padding: 50px">
        <div style="height: 10%;font-size: 20px;font-weight: bold;">
          取移动平均的项数 N < T，使用一次简单移动平均值计算公式计算预测值和预测误差
        </div>
        <div style="height: 90%;position: relative">
          <div style="width: 30%;height: 100%;text-align: center;padding: 20px;">
            控制台
            <hr/><br/><br/>
            <div>
              N(移动平均的项数)
              <el-input-number v-model="N" controls-position="right" :min="1"></el-input-number>
            </div>
            <br/><br/>
            <el-button type="primary" @click="calc">计算预测值和预测误差</el-button>
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
            <el-button type="primary" @click="drawCurve">绘制预测曲线</el-button>
          </div>

          <div style="width: 65%;height: 100%;position: absolute;right: 0;top: 0;" id="curveDiv">

          </div>
        </div>
      </div>
    </el-tab-pane>
  </el-tabs>

  <p-c-drawer ref="drawer"/>
</div>
</template>

<script>
import PCDrawer from "@/components/pc/PCDrawer";
import axios from "axios";
import qs from 'qs';
export default {
  name: "Test",
  components: {
    PCDrawer
  },
  data() {
    return {
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
    displayDrawer(){
      this.$refs.drawer.drawer = !this.$refs.drawer.drawer;
    },
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
          left: "10%",
          right: "10%",
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
            fontSize: 16,
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
          left: "10%",
          right: "10%",
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
            fontSize: 16,
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
.onePane td {
  width: 140px;
  font-size: 20px;
}
.twoPane td{
  text-align: center;
  width: 300px;
  height: 50px;
}
</style>