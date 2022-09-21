<template>
  <div class="minpwx-mobile">
    <div style="padding: 25px 25px 35px 25px;position:fixed;left:0;right:0;top:0;text-align: center;background-color:#802c8c;color: #ffffff;font-size:18px;height:44px">用抛物线法求解一维函数的极值</div>
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
                  <el-select :disabled="disabledStatus" v-model="funcIndex" @change="funcChange(funcIndex)">
                    <el-option v-for="item in parameters.funcs" :key="item.value" :label="item.label" :value="item.value"/>
                  </el-select>
                  <el-divider>区间左端点a</el-divider>
                  <el-input clearable v-model="parameters.lOpt" :disabled="disabledStatus"></el-input>
                  <el-divider>区间右端点b</el-divider>
                  <el-input clearable v-model="parameters.rOpt" :disabled="disabledStatus"></el-input>
                  <el-divider>结束参数delta</el-divider>
                  <el-input clearable v-model="parameters.delta" :disabled="disabledStatus"></el-input>
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
                            <td>
                              <el-select v-model="imageStyle.line.lineColor">
                                <el-option v-for="item in imageStyle.line.lineColors" :key="item.value" :label="item.label" :value="item.value"/>
                              </el-select>
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
                              <el-select v-model="imageStyle.marker.markerPointColor">
                                <el-option v-for="item in imageStyle.marker.markerPointColors" :key="item.value" :label="item.label" :value="item.value"/>
                              </el-select>
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
                </div>
                <div style="width: 100%;text-align: center">
                  <span><el-button @click="resetSettings">重置</el-button></span>
                </div>
              </el-tab-pane>
              <el-tab-pane label="运行结果">
                <div style="height: 487px">
                  <el-tabs>
                    <el-tab-pane label="图像视图">
                      <div v-html="imgResHtml" style="text-align: center"></div>
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
            <el-tabs :tab-position="tabPosition">
              <el-tab-pane label="一维无约束">
                <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minjt')">进退法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minhj')">黄金分割法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minfbnq')">斐波那契法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minnewton')">牛顿法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/odu/mingx')">割线法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="多维无约束">
                <div><el-button type="text" @click="toWork('/mobile/workbench/mu/minps')">模式搜索法线性规划</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/mu/minrb')">ROSENBROCK法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/mu/minsimpsearch')">单纯形搜索法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="约束优化">
                <div><el-button type="text" @click="toWork('/mobile/workbench/co/minrosen')">ROSEN梯度投影法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/co/mingreneralpf')">外点罚函数法-一般等式</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/co/minpf')">外点罚函数法-线性等式</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/co/minnf')">内点罚函数法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="非线性二乘">
                <div><el-button type="text" @click="toWork('/mobile/workbench/mingn')">G-N法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/minmgn')">修正G-N法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/minlm')">L-M法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="线性规划">
                <div><el-button type="text" @click="toWork('/mobile/workbench/simplemthd')">单纯形法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/cmpsimpleMthd')">完整单纯形法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/modifsimplemthd')">修正单纯形法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="整数规划">
                <div><el-button type="text" @click="toWork('/mobile/workbench/ip/divideplane')">割平面法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/ip/intprogfz')">分支定界法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/ip/zerooneprog')">枚举法(包括穷举法和隐枚举法)</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="二次规划">
                <div><el-button type="text" @click="toWork('/mobile/workbench/sp/quadlagr')">拉格朗日法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/sp/activdeset')">起作用集法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/sp/trackroute')">路径跟踪法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="粒子群算法">
                <div><el-button type="text" @click="toWork('/mobile/workbench/pso')">基本粒子群算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/yspso')">带压缩因子的粒子群算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/linwpso')">线性递减权重粒子群优化算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/sapso')">自适应权重粒子群优化算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/randwpso')">随机权重粒子群优化算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/lncpso')">学习因子同步变化的粒子群优化算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/asylncpso')">学习因子异步变化的粒子群优化算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/secpso')">二阶粒子群优化算法</el-button></div>
              </el-tab-pane>
              <el-tab-pane label="遗传算法">
                <div><el-button type="text" @click="toWork('/mobile/workbench/ih/myga')">基本遗传算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/sboga')">顺序选择遗传算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/normfitga')">动态线性标定适应值的遗传算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/gmga')">大变异遗传算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/adapga')">自适应遗传算法</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/dblgega')">双切点遗传</el-button></div>
                <div><el-button type="text" @click="toWork('/mobile/workbench/mmadapga')">多变异位自适应遗传</el-button></div>
              </el-tab-pane>
            </el-tabs>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MOMinPWX",
  components: {
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
      funcIndex: 1,
      parameters: {
        funcs:[
          {value:0,label:'y=x^4-x^2-2*x+5',xlimt:{l:-8,r:8},ylimt: {l:-10,r:50}},
          {value:1,label:'y=t^2-log(t)-5',xlimt:{l:-8,r:8},ylimt: {l:-5,r:20}},
          {value:2,label:'y=t^3-3*t+2',xlimt:{l:-8,r:8},ylimt: {l:-150,r:150}},
          {value:3,label:'y=t^2-2*t+7',xlimt:{l:-8,r:8},ylimt: {l:5,r:45}},
          {value:4,label:'y=exp(-x^2)*(x+sin(x))',xlimt:{l:-8,r:8},ylimt: {l:-1,r:1}},
          {value:5,label:'y=sin(2*x+1)+3*sin(4*x+3)+5*sin(6*x+5)',xlimt:{l:-5,r:25},ylimt: {l:-10,r:10}},
          {value:6,label:'y=-1/((x-2)^2+3)-1/(3*(x-5)^2+4)-1/(2*(x-1)^2+1)',xlimt:{l:-5,r:5},ylimt: {l:-1.4,r:0}},
          {value:7,label:'y=abs(x+1)+x^2+x-2',xlimt:{l:-8,r:8},ylimt: {l:-5,r:50}},
          {value:8,label:'y=1/2*x^2+log(x+8)*(x+8)-x-8-1/4*x^4',xlimt:{l:-8,r:9},ylimt: {l:-200,r:50}},
          {value:9,label:'y=asin(x/2)',xlimt:{l:-3,r:3},ylimt:{l:-2,r:2}},
          {value:10,label:'y=exp((cos(1/x)^2))',xlimt:{l:0,r:0.5},ylimt: {l:1,r:3}},
          {value:11,label:'y=log(x+sqrt(x^2+1))',xlimt:{l:-8,r:9},ylimt: {l:-4,r:4}},
        ],
        lOpt: -5,
        rOpt: 10,
        delta: 0.05,
        eps: 1.0e-6
      },
      disabledStatus: false,
      imageStyle: {
        line: {
          lineTypes: [{value:'-',label:'实线'},{value:'--',label:'虚线'},{value:':',label:'点线'},{value:'-.',label:'点划线'}],
          lineType: '-',
          lineColors:[{value:'r',label:'红色'},{value:'g',label:'绿色'},{value:'b',label:'蓝色'},{value:'c',label:'青色'},{value:'m',label:'洋红'},{value:'y',label:'黄色'},{value:'k',label:'黑色'},{value:'w',label:'白色'}],
          lineColor: 'k'
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
          markerPointColors: [{value:'r',label:'红色'},{value:'g',label:'绿色'},{value:'b',label:'蓝色'},{value:'c',label:'青色'},{value:'m',label:'洋红'},{value:'y',label:'黄色'},{value:'k',label:'黑色'},{value:'w',label:'白色'}],
          markerPointColor: 'g',
          markerPointSize: 6
        },
        defaultStyle: {
          lineType:'-',lineColor:'k',markerPointType:'o',markerPointColor:'g',markerPointSize: 6,
        }
      },
      xyStyle: {
        limit: {
          xliml:-8,xlimr:8,yliml:-5,ylimr:20
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
      },
      imgResHtml: '',
      result: {
        x: '',
        minf: ''
      },
      tabPosition: 'left'
    }
  },
  methods: {
    funcChange(funcIndex) {
      let xliml,xlimr,yliml,ylimr;
      for (let i = 0; i < this.parameters.funcs.length; i++) {
        if (funcIndex === this.parameters.funcs[i].value){
          xliml = this.parameters.funcs[i].xlimt.l
          xlimr = this.parameters.funcs[i].xlimt.r
          yliml = this.parameters.funcs[i].ylimt.l
          ylimr = this.parameters.funcs[i].ylimt.r
          break
        }
      }
      this.xyStyle.limit.xliml=xliml
      this.xyStyle.limit.xlimr=xlimr
      this.xyStyle.limit.yliml=yliml
      this.xyStyle.limit.ylimr=ylimr
    },
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
    toWork(path){
      console.log(path)
      console.log(this.$route.path.indexOf(path))
      if (this.$route.path.indexOf(path)!==-1){
        console.log("就是当前路径")
        this.activeName = 'home'
      }else{
        this.$router.replace(path)
      }
    },
    run() {
      console.log("开始运行")
      if (this.disabledStatus === false){
        this.displayImg(
            this.funcIndex,
            this.parameters.lOpt,
            this.parameters.rOpt,
            this.parameters.eps,
            this.imageStyle.line.lineColor,
            this.imageStyle.line.lineType,
            this.imageStyle.marker.markerPointType,
            this.imageStyle.marker.markerPointColor,
            this.imageStyle.marker.markerPointSize,
            this.xyStyle.limit.xliml,
            this.xyStyle.limit.xlimr,
            this.xyStyle.limit.yliml,
            this.xyStyle.limit.ylimr
        );
      }
      this.disabledStatus = !this.disabledStatus
    },
    displayImg(funcIndex, lOpt, rOpt, eps, lineColor, lineType, markerType, markerColor, markerSize, xliml, xlimr, yliml, ylimr){
      console.log(funcIndex);
      this.imgResHtml = ''
      axios({
        url: 'http://127.0.0.1:8080/matlab-server/mobile/workbench/odu/minFBNQ',
        method: 'get',
        params: {
          funcIndex, lOpt,rOpt,eps
        }
      }).then((res)=>{
        console.log(res.data);
        this.result.minx=res.data[0]
        this.result.maxx=res.data[1]
        axios({
          url: 'http://127.0.0.1:8080/matlab-server/mobile/workbench/odu/minFBNQ/webplot',
          method: 'get',
          params: {
            funcIndex, lOpt,rOpt,eps,lineColor,lineType,
            markerType,markerColor,markerSize,xliml,xlimr,yliml,ylimr
          }
        }).then((webfigure)=>{
          console.log(webfigure);
          this.imgResHtml=webfigure.data
        })
      })
    }
  }
}
</script>

<style scoped>

</style>
<style>
.minpwx-mobile .el-tabs__content{
  overflow: scroll;
}
</style>