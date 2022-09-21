<template>
<div>
  <el-tabs :tab-position="tabPosition">
    <el-tab-pane label="一维无约束">
      <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minjt')">进退法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minhj')">黄金分割法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minfbnq')">斐波那契法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/odu/mingx')">割线法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/odu/mings')">Goldstein法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/odu/minwp')">Wolfe-Powell法</el-button></div>
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
      <div><el-button type="text" @click="toWork('/mobile/workbench/ih/sboga')">顺序选择遗传算法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/ih/normfitga')">动态线性标定适应值的遗传算法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/ih/gmga')">大变异遗传算法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/ih/adapga')">自适应遗传算法</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/ih/dblgega')">双切点遗传</el-button></div>
      <div><el-button type="text" @click="toWork('/mobile/workbench/ih/mmadapga')">多变异位自适应遗传</el-button></div>
    </el-tab-pane>
    <el-tab-pane label="数学建模">
      <div><el-button type="text" @click="toWork('/mobile/workbench/mathmodel/tsp')">时间序列预测模型</el-button></div>
    </el-tab-pane>
  </el-tabs>
</div>
</template>

<script>
export default {
  name: "MOCategory",
  data() {
    return {
      tabPosition:'left'
    }
  },
  methods: {
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
  }
}
</script>

<style scoped>

</style>