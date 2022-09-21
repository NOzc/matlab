<template>
  <div class="divideplane-mobile">
    <!--标题-->
    <div style="padding: 25px 25px 35px 25px;position:fixed;left:0;right:0;top:0;text-align: center;background-color:#2d3a4b;color: #ffffff;font-size:14px;height:44px">用割平面法求解整数规划</div>
    <div style="position: fixed;left: 0;right: 0;bottom: 0;">
      <el-tabs v-model="activeName" tab-position="bottom" :stretch="true">
        <el-tab-pane name="home">
          <span slot="label"><i class="el-icon-s-home"></i> 实验</span>
          <div style="margin-top: 0">
            <el-tabs type="border-card" :stretch="true">
              <el-tab-pane label="参数设置">
                <!--参数-->
                <div style="height: 487px">
                  <div>
                    <table>
                      <tr>
                        <td style="width: 40%">约束矩阵A：</td>
                        <td><el-input clearable v-model="parameters.A" :disabled="disabledStatus"></el-input></td>
                      </tr>
                    </table>
                  </div>
                  <div style="margin-top: 20px">
                    <table>
                      <tr>
                        <td style="width: 40%">目标函数系数向量c：</td>
                        <td><el-input clearable v-model="parameters.c" :disabled="disabledStatus"></el-input></td>
                      </tr>
                    </table>
                  </div>
                  <div style="margin-top: 20px">
                    <table>
                      <tr>
                        <td style="width: 40%">约束右端向量b：</td>
                        <td><el-input clearable v-model="parameters.b" :disabled="disabledStatus"></el-input></td>
                      </tr>
                    </table>
                  </div>
                  <div style="margin-top: 20px">
                    <table>
                      <tr>
                        <td style="width: 40%">初始基向量bas：</td>
                        <td><el-input clearable v-model="parameters.bas" :disabled="disabledStatus"></el-input></td>
                      </tr>
                    </table>
                  </div>
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
                      <div v-html="imgResHtml"></div>
                    </el-tab-pane>
                    <el-tab-pane label="数值结果视图">
                      <div>
                        <table>
                          <tr>
                            <td>目标取最小时的自变量值：</td>
                          </tr>
                          <tr>
                            <td>x1：</td>
                            <td><el-input v-model="numRes.minx"/></td>
                          </tr>
                          <tr>
                            <td>x2：</td>
                            <td><el-input v-model="numRes.minx"/></td>
                          </tr>
                        </table>
                      </div>
                      <div style="margin-top: 10%">
                        <table>
                          <tr>
                            <td>目标函数最小值minf：</td>
                          </tr>
                          <tr>
                            <td><el-input v-model="numRes.miny"/></td>
                          </tr>
                        </table>
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
export default {
  name: "MODivideplane",
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
      parameters: {
        A:'[-1 2 1 0;2 1 0 1]',
        c:'[1,-1]',
        b:'[2,4]',
        bas:'[3,4]',
      },
      disabledStatus: false,
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
      },
      imgResHtml: '',
      numRes: {
        minx: '',
        miny: ''
      },
      tabPosition: 'left'
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
      this.disabledStatus = !this.disabledStatus
    },
  }
}
</script>

<style scoped>

</style>
<style>
.divideplane-mobile .el-tabs__content{
  overflow: scroll;
}
</style>