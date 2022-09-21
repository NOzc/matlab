<template>
<div class="onedm-dialog" style="width: 100%;height: 100%">
  <el-dialog title="目标函数" :visible.sync="dialogVisible" width="80%">
    <div style="text-align: center;margin-left: 10px">
      <table>
        <tr>
          <td v-for="(item,index) in funcList" :key="item.value" v-show="index<3" style="padding: 30px 30px 30px 30px">
            <div @click="itemClick(item.index,item.value,item.df,item.xlimt,item.ylimt)">
              <img :src="item.img" class="image">
              <div style="padding: 14px;">
                <span>{{item.value}}</span>
              </div>
            </div>
          </td>
        </tr>
        <tr >
          <td v-for="(item,index) in funcList" :key="item.value" v-show="index<6&&index>2" style="padding: 30px 30px 30px 30px">
            <div @click="itemClick(item.index,item.value,item.df,item.xlimt,item.ylimt)">
              <img :src="item.img" class="image">
              <div style="padding: 14px;">
                <span>{{item.value}}</span>
              </div>
            </div>
          </td>
        </tr>
        <tr >
          <td v-for="(item,index) in funcList" :key="item.value" v-show="index<9&&index>5" style="padding: 30px 30px 30px 30px">
            <div @click="itemClick(item.index,item.value,item.df,item.xlimt,item.ylimt)">
              <img :src="item.img" class="image">
              <div style="padding: 14px;">
                <span>{{item.value}}</span>
              </div>
            </div>
          </td>
        </tr>
        <tr >
          <td v-for="(item,index) in funcList" :key="item.value" v-show="index<12&&index>8" style="padding: 30px 30px 30px 30px">
            <div @click="itemClick(item.index,item.value,item.df,item.xlimt,item.ylimt)">
              <img :src="item.img" class="image">
              <div style="padding: 14px;">
                <span>{{item.value}}</span>
              </div>
            </div>
          </td>
        </tr>
      </table>
    </div>
      <span slot="footer" class="dialog-footer">
<!--      <el-button @click="dialogVisible = false">取 消</el-button>
      <el-button type="primary" @click="dialogVisible = false">确 定</el-button>-->
    </span>
  </el-dialog>
</div>
</template>

<script>
export default {
  name: "OneDM",
  data() {
    return {
      dialogVisible: false,
      funcList: [
        {index:0,value:'y = x^4-x^2-2*x+5',df: 'y = 4*x^3 - 2*x -2',img:require('@/assets/img/onedm/fitness0.png'),xlimt:{l:-8,r:8},ylimt: {l:-10,r:50}},
        {index:1,value:'y = t^2 -log(t) - 5',df: 'y = 2*x - 1/x',img:require('@/assets/img/onedm/fitness1.png'),xlimt:{l:-8,r:8},ylimt: {l:-5,r:20}},
        {index:2,value:'y = t^3 - 3 *t + 2',df: 'y = 3 *t^2 -3',img:require('@/assets/img/onedm/fitness2.png'),xlimt:{l:-8,r:8},ylimt: {l:-150,r:150}},
        {index:3,value:'y = t^2 - 2*t + 7',df: 'y = 2*t-2',img:require('@/assets/img/onedm/fitness3.png'),xlimt:{l:-8,r:8},ylimt: {l:5,r:45}},
        {index:4,value:'y = exp(-x^2)*(x+sin(x))',df: 'y=exp(-x^2)*(cos(x) + 1) - 2*x*exp(-x^2)*(x + sin(x))',img:require('@/assets/img/onedm/fitness4.png'),xlimt:{l:-8,r:8},ylimt: {l:-1,r:1}},
        {index:5,value:'y = sin(2*x+1)+3*sin(4*x+3)+5*sin(6*x+5)',df: 'y=2*cos(2*x + 1) + 12*cos(4*x + 3) + 30*cos(6*x + 5)',img: require('@/assets/img/onedm/fitness5.png'),xlimt:{l:-5,r:5},ylimt: {l:-10,r:10}},
        {index:6,value:'y = -1/((x-2)^2+3)-1/(3*(x-5)^2+4)-1/(2*(x-1)^2+1)',df: 'y=(2*x - 4)/((x - 2)^2 + 3)^2 + (4*x - 4)/(2*(x - 1)^2 + 1)^2 + (6*x - 30)/(3*(x - 5)^2 + 4)^2',img:require('@/assets/img/onedm/fitness6.png'),xlimt:{l:-5,r:5},ylimt: {l:-1.4,r:0}},
        {index:7,value:'y = abs(x+1)+x^2+x-2',df: 'y=2*x + sign(x + 1) + 1',img:require('@/assets/img/onedm/fitness7.png'),xlimt:{l:-8,r:8},ylimt: {l:-5,r:50}},
        {index:8,value:'y = 1/2*x^2+log(x+8)*(x+8)-x-8-1/4*x^4',df: 'y = x + log(x + 8) - x^3',img:require('@/assets/img/onedm/fitness8.png'),xlimt:{l:-8,r:9},ylimt: {l:-200,r:50}},
        {index:9,value:'y = asin(x/2)',df: 'y = 1/(2*(1 - x^2/4)^(1/2))',img:require('@/assets/img/onedm/fitness9.png'),xlimt:{l:-3,r:3},ylimt:{l:-2,r:2}},
        {index:10,value:'y = exp((cos(1/x)^2))',df: 'y = (2*cos(1/x)*sin(1/x)*exp(cos(1/x)^2))/x^2',img:require('@/assets/img/onedm/fitness10.png'),xlimt:{l:0,r:0.5},ylimt: {l:1,r:3}},
        {index:11,value:' y = log(x+sqrt(x^2+1))',df: 'y = (x/(x^2 + 1)^(1/2) + 1)/(x + (x^2 + 1)^(1/2))',img:require('@/assets/img/onedm/fitness11.png'),xlimt:{l:-8,r:9},ylimt: {l:-4,r:4}}
      ]
    }
  },
  methods: {
    itemClick(index,value,df,xlimt,ylimt) {
      this.$emit('funcDialogClick',index,value,df,xlimt,ylimt)
      this.dialogVisible = false;
    }
  }
}
</script>

<style scoped>

</style>
<style>
.onedm-dialog .el-dialog__wrapper .el-dialog{
  height: 60%;
}
.el-dialog{
  overflow: auto;
}
.onedm-dialog img{
  width: 100%;
  height: 100%;
}
</style>