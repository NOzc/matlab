<template>
  <div class="index_test" style="width: 100%;height: 100vh">
    <div style="width: 100%;height: 100%;position: relative" class="content">
      <!-- 导航   -->
      <div style="width: 20%;height: 100%;overflow-y: scroll;scrollbar-face-color: red; scrollbar-shadow-color: #999;">
        <el-menu class="el-menu-demo" :router="true">
          <div class="first"><el-menu-item index="/pw">平台主页</el-menu-item></div>
          <el-submenu index="1">
            <template slot="title">一维无约束</template>
            <el-menu-item index="/pc/workbench/odu/minjt">进退法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/minhj">黄金分割法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/minfbnq">斐波那契法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/minnewton">牛顿法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/mingx">割线法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/minpwx">抛物线法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/mintri">三次插值法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/mings">Goldstein法</el-menu-item>
            <el-menu-item index="/pc/workbench/odu/minwp">Wolfe-Powell法</el-menu-item>
          </el-submenu>

          <el-submenu index="2">
            <template slot="title">多维无约束</template>
            <el-menu-item index="/pc/workbench/mu/minps">模式搜索法线性规划</el-menu-item>
            <el-menu-item index="/pc/workbench/mu/minrb">ROSENBROCK法</el-menu-item>
            <el-menu-item index="/pc/workbench/mu/minsimpsearch">单纯形搜索法</el-menu-item>
          </el-submenu>

          <el-submenu index="3">
            <template slot="title">约束优化</template>
            <el-menu-item index="/pc/workbench/co/minrosen">ROSEN梯度投影法</el-menu-item>
            <el-menu-item index="/pc/workbench/co/minpf">外点罚函数法-线性等式</el-menu-item>
            <el-menu-item index="/pc/workbench/co/mingeneralpf">外点罚函数法-一般等式</el-menu-item>
            <el-menu-item index="/pc/workbench/co/minnf">内点罚函数法</el-menu-item>
          </el-submenu>

<!--          <el-submenu index="4">
            <template slot="title">非线性二乘</template>
            <el-menu-item index="/workbench/mingn">G-N法</el-menu-item>
            <el-menu-item index="/workbench/minmgn">修正G-N法</el-menu-item>
            <el-menu-item index="/workbench/minlm">L-M法</el-menu-item>
          </el-submenu>-->

<!--          <el-submenu index="5">
            <template slot="title">线性规划</template>
            <el-menu-item index="/workbench/simplemthd">单纯形法</el-menu-item>
            <el-menu-item index="/workbench/cmpsimpleMthd">完整单纯形法</el-menu-item>
            <el-menu-item index="/workbench/modifsimplemthd">修正单纯形法</el-menu-item>
          </el-submenu>-->

<!--          <el-submenu index="6">
            <template slot="title">整数规划</template>
            <el-menu-item index="/pc/workbench/ip/divideplane">割平面法</el-menu-item>
            <el-menu-item index="/pc/workbench/ip/intprogfz">分支定界法</el-menu-item>
            <el-menu-item index="/pc/workbench/ip/zeroOneprog">枚举法(包括穷举法和隐枚举法)</el-menu-item>
          </el-submenu>-->

          <el-submenu index="7">
            <template slot="title">二次规划</template>
            <el-menu-item index="/pc/workbench/sp/quadlagr">拉格朗日法</el-menu-item>
            <el-menu-item index="/pc/workbench/sp/activdeset">起作用集法</el-menu-item>
            <el-menu-item index="/pc/workbench/sp/trackroute">路径跟踪法</el-menu-item>
          </el-submenu>

          <el-submenu index="8">
            <template slot="title">粒子群算法</template>
            <el-menu-item index="/workbench/pso">基本粒子群算法</el-menu-item>
            <el-menu-item index="/workbench/yspso">带压缩因子的粒子群算法</el-menu-item>
            <el-menu-item index="/workbench/linwpso ">线性递减权重粒子群优化算法</el-menu-item>
            <el-menu-item index="/workbench/sapso">自适应权重粒子群优化算法</el-menu-item>
            <el-menu-item index="/workbench/randwpso">随机权重粒子群优化算法</el-menu-item>
            <el-menu-item index="/workbench/lncpso">学习因子同步变化的粒子群优化算法</el-menu-item>
            <el-menu-item index="/workbench/asylncpso">学习因子异步变化的粒子群优化算法</el-menu-item>
            <el-menu-item index="/workbench/secpso">二阶粒子群优化算法</el-menu-item>
          </el-submenu>

          <el-submenu index="9">
            <template slot="title">遗传算法</template>
            <el-menu-item index="/pc/workbench/ih/myga">基本遗传算法</el-menu-item>
            <el-menu-item index="/pc/workbench/ih/sboga">顺序选择遗传算法</el-menu-item>
            <el-menu-item index="/pc/workbench/ih/normfitga">动态线性标定适应值的遗传算法</el-menu-item>
            <el-menu-item index="/pc/workbench/ih/gmga">大变异遗传算法</el-menu-item>
            <el-menu-item index="/pc/workbench/ih/adapga">自适应遗传算法</el-menu-item>
            <el-menu-item index="/pc/workbench/ih/dblgega">双切点遗传</el-menu-item>
            <el-menu-item index="/pc/workbench/ih/mmadapga">多变异位自适应遗传</el-menu-item>
          </el-submenu>

          <el-submenu index="10">
            <template slot="title">数学建模</template>
            <el-menu-item index="/pc/workbench/mathmodel/tsp">时间序列预测模型</el-menu-item>
          </el-submenu>
        </el-menu>
      </div>
      <!--  主体  -->
<!--      <div style="width:80%;height:100%;position:absolute;right: 0;top: 0;z-index: 2;background-color: rgba(8, 8, 8, 0.31); "></div>-->
      <div style="width: 80%;height: 100%;position: absolute;right: 0;top: 0">
        <div style="margin-left:40%;margin-top: 100px;width:60%;">
          <div style="font-size: 60px;color: #f4ab1b;letter-spacing: 10px;text-align: center">
            <span>数学建模与优化方法</span><br/>
          </div>
          <div style="margin-top: 20px;font-size: 50px;color: #1a1a1a;letter-spacing: 10px;text-align: center">
            <span>可视化实验平台</span><br/>
          </div>
<!--          <div><el-button type="text" style="width: 120px;height: 50px;margin-top: 20%" @click="toPw('/pw')">平台简介>></el-button></div>-->
        </div>
        <div style="width: 30%;margin-top: 30%;margin-left: 10%;font-size: 50px;color: #f4ab1b">
          基于WEB
        </div>
        </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      /*identity: ['您','从业者','学生'],
      currentIndex: 0,*/
    }
  },
  computed: {
    loginStatus() {
      return this.$store.state.user.username !== ''
    }
  },
  mounted() {
    setInterval(this.autoPlay,3000)
  },
  methods: {
    toPw(path){
      this.$router.replace(path)
    }
  }
}
</script>

<style scoped>
.content {
  background-image: url("../../assets/img/indexbg.jpg");
  background-repeat: no-repeat;
  background-size: 100% 100%;
  height:860px;
}
</style>
<style>
.index_test .el-menu{
  background-color: transparent !important;/* 背景透明 */
}
.index_test .el-submenu{
  background-color: transparent !important;/* 背景透明 */
}
.index_test .el-menu--inline{
  background-color: transparent !important;/* 背景透明 */
}
.index_test .el-submenu__title{
  background-color: transparent !important;/* 背景透明 */
  color: #f41318;
  font-size: 20px;
}
.index_test .el-menu-item{
  background-color: transparent !important;/* 背景透明 */
  color: #1a1a1a;
  font-size: 18px;
}
.index_test .el-button{
  background-color: transparent !important;/* 背景透明 */
  color:#f4ab1b ;
  font-size: 40px;
}
.first .el-menu-item{
  background-color: transparent !important;/* 背景透明 */
  color: #f41318;
  font-size: 30px;
}
</style>