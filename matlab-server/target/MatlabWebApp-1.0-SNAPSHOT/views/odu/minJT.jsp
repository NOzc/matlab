<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="wf" uri="/WEB-INF/webfigures.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
    String basePath = request.getScheme()
            +"://"+request.getServerName()+":"
            +request.getServerPort()
            +request.getContextPath()+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>Title</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- import Vue before Element -->
    <script src="assets/config/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="assets/config/axios.min.js"></script>
    <style>
        .dialog-container .el-dialog{
            height: 80%;
        }
    </style>
</head>
<body>
    <div id="app">
        <!--  顶部标题部分  -->
        <div style="height: 12%;padding: 10px;position: relative;background-color:#283443;">
            <!--左边展开按钮-->
            <div style="position: absolute;left: 2%;top: 30%">
                <el-button icon="el-icon-s-unfold" circle @click="displayDrawer"></el-button>
            </div>
            <div style="margin: 2% 10px 3% 20%;line-height: normal;width: 25%;font-size: 26px;color: #fff;letter-spacing: 5px">用进退法求解一维函数的极值区间</div>
            <el-button-group style="position: absolute;right: 20%;top: 30%">
                <el-button type="primary" @click="run" v-html="runBtnHtml"></el-button>
                <el-button type="primary"><i class="el-icon-refresh" style="font-size: 30px"></i> <br/><br/>重置</el-button>
                <el-button type="primary"><i class="el-icon-eleme" style="font-size: 30px"></i> <br/><br/>随机</el-button>
                <el-button type="primary" @click="dialogVisible=true"><i class="el-icon-setting" style="font-size: 30px"></i> <br/><br/>设置</el-button>
            </el-button-group>
        </div>
        <!--  左边参数设置区域  -->
        <div id="workarea" style="height: 85%;width: 30%;position: absolute;left: 0;">
            <div style="padding: 30px 30px 30px 30px">
                <div>
                    <el-divider>目标函数f</el-divider>
                    <el-input clearable v-model="parameters.func" :disabled="disabledStatus"></el-input>
                </div>
                <div style="margin-top: 50px">
                    <el-divider>初始点x0</el-divider>
                    <el-input clearable v-model="parameters.x0" :disabled="disabledStatus"></el-input>
                </div>
                <div style="margin-top: 50px">
                    <el-divider>初始步长h0</el-divider>
                    <el-input clearable v-model="parameters.h0" :disabled="disabledStatus"></el-input>
                </div>
                <div style="margin-top: 50px">
                    <el-divider>精度eps</el-divider>
                    <el-input clearable v-model="parameters.eps" :disabled="disabledStatus"></el-input>
                </div>
            </div>
        </div>
        <!--  右边图像显示部分  -->
        <div style="height: 85%;width: 70%;position: absolute;right: 0">
            <div>
                <el-tabs type="border-card" style="height: 100%">
                    <el-tab-pane label="图像视图">
                        <div style="width: 1300px;height:700px" id="imgRes">
                            <iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
                        </div>
                    </el-tab-pane>
                    <el-tab-pane label="数值结果视图">
                        <div style="width: 1300px;height:700px;position: relative" id="numRes">
                            <div style='position: absolute;width:100%;left: 20%;top: 20%'>
                                <span style='font-size: 18px'>极值点：</span>
                                <input type='text' style='-webkit-appearance: none;background-color: #FFF;border-radius: 4px;border: 1px solid #DCDFE6;box-sizing: border-box;color: #606266;display: inline-block;font-size: inherit;height: 40px;line-height: 40px;outline: 0;padding: 0 15px;transition: border-color .2s cubic-bezier(.645,.045,.355,1);width: 20%;' disabled/>
                            </div>
                            <div style='position: absolute;width:100%;left: 20%;top: 50%'>
                                <span style='font-size: 18px'>极值点：</span>
                                <input type='text' style='-webkit-appearance: none;background-color: #FFF;border-radius: 4px;border: 1px solid #DCDFE6;box-sizing: border-box;color: #606266;display: inline-block;font-size: inherit;height: 40px;line-height: 40px;outline: 0;padding: 0 15px;transition: border-color .2s cubic-bezier(.645,.045,.355,1);width: 20%;' disabled/>
                            </div>
                        </div>
                    </el-tab-pane>
                </el-tabs>
            </div>
        </div>
        <!--抽屉-->
        <div>
            <el-drawer title="导航" :visible.sync="drawer" direction="ltr">
                <el-menu class="el-menu-demo">
                    <el-submenu index="1">
                        <template slot="title">一维无约束</template>
                        <el-menu-item index="/workbench/odu/minjt" @click="toWorkbench('views/odu/minJT.jsp')">进退法</el-menu-item>
                        <el-menu-item index="/workbench/odu/minhj" @click="toWorkbench('views/odu/minHJ.jsp')">黄金分割法</el-menu-item>
                        <el-menu-item index="/workbench/odu/minfbnq" @click="toWorkbench('views/odu/minFBNQ.jsp')">斐波那契法</el-menu-item>
                        <el-menu-item index="/workbench/odu/minnewton" @click="toWorkbench('views/odu/minNewton.jsp')">牛顿法</el-menu-item>
                    </el-submenu>

                    <el-submenu index="2">
                        <template slot="title">多维无约束</template>
                        <el-menu-item index="/workbench/minps">模式搜索法线性规划</el-menu-item>
                        <el-menu-item index="/workbench/minrb">ROSENBROCK法</el-menu-item>
                        <el-menu-item index="/workbench/minsimpsearch">单纯形搜索法</el-menu-item>
                    </el-submenu>

                    <el-submenu index="3">
                        <template slot="title">约束优化</template>
                        <el-menu-item index="/workbench/minrosen">ROSEN梯度投影法</el-menu-item>
                        <el-menu-item index="/workbench/minpf">外点罚函数法</el-menu-item>
                        <el-menu-item index="/workbench/minnf">内点罚函数法</el-menu-item>
                    </el-submenu>

                    <el-submenu index="4">
                        <template slot="title">非线性二乘</template>
                        <el-menu-item index="/workbench/mingn">G-N法</el-menu-item>
                        <el-menu-item index="/workbench/minmgn">修正G-N法</el-menu-item>
                        <el-menu-item index="/workbench/minlm">L-M法</el-menu-item>
                    </el-submenu>

                    <el-submenu index="5">
                        <template slot="title">线性规划</template>
                        <el-menu-item index="/workbench/simplemthd">单纯形法</el-menu-item>
                        <el-menu-item index="/workbench/cmpsimpleMthd">完整单纯形法</el-menu-item>
                        <el-menu-item index="/workbench/modifsimplemthd">修正单纯形法</el-menu-item>
                    </el-submenu>

                    <el-submenu index="6">
                        <template slot="title">整数规划</template>
                        <el-menu-item index="/workbench/divideplane">割平面法</el-menu-item>
                        <el-menu-item index="/workbench/intprogfz">分支定界法</el-menu-item>
                        <el-menu-item index="/workbench/zerooneprog ">枚举法(包括穷举法和隐枚举法)</el-menu-item>
                    </el-submenu>

                    <el-submenu index="7">
                        <template slot="title">二次规划</template>
                        <el-menu-item index="/workbench/quadlagr">拉格朗日法</el-menu-item>
                        <el-menu-item index="/workbench/activdeset">起作用集法</el-menu-item>
                        <el-menu-item index="/workbench/trackroute ">路径跟踪法</el-menu-item>
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
                        <el-menu-item index="/workbench/myga">基本遗传算法</el-menu-item>
                        <el-menu-item index="/workbench/sboga">顺序选择遗传算法</el-menu-item>
                        <el-menu-item index="/workbench/normfitga">动态线性标定适应值的遗传算法</el-menu-item>
                        <el-menu-item index="/workbench/gmga">大变异遗传算法</el-menu-item>
                        <el-menu-item index="/workbench/adapga">自适应遗传算法</el-menu-item>
                        <el-menu-item index="/workbench/dblgega">双切点遗传</el-menu-item>
                        <el-menu-item index="/workbench/mmadapga">多变异位自适应遗传</el-menu-item>
                    </el-submenu>
                </el-menu>
            </el-drawer>
        </div>
        <!--对话框-->
        <div class="dialog-container">
            <el-dialog title="设置" :visible.sync="dialogVisible" width="30%" style="height: 100%">
                <el-tabs type="border-card" style="height: 75%">
                    <el-tab-pane label="图像参数">
                        <el-divider content-position="left">Lines</el-divider>
                        <div style="margin-left: 50px">
                            <table>
                                <tr>
                                    <td style="width: 120px">曲线类型</td>
                                    <td><el-select v-model="lineType">
                                        <el-option v-for="item in lineTypes" :key="item.value" :label="item.label" :value="item.value"/>
                                    </el-select></td>
                                </tr>
                                <tr>
                                    <td style="width: 120px">曲线颜色</td>
                                    <td><el-select v-model="lineColor">
                                        <el-option v-for="item in lineColors" :key="item.value" :label="item.label" :value="item.value"/>
                                    </el-select></td>
                                </tr>
                            </table>
                        </div>
                    </el-tab-pane>
                    <el-tab-pane label="坐标轴参数">
                        <el-divider content-position="left">Markers</el-divider>
                    </el-tab-pane>
                </el-tabs>
                <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
                </span>
            </el-dialog>
        </div>
    </div>
</body>
<script>
    new Vue({
        el: '#app',
        data() {
            return {
                currentStatus : false,
                drawer: false,
                disabledStatus: false,
                parameters: {
                    func:'t^4-t^2-2*t+5',
                    x0: 0,
                    h0: 0.1,
                    eps: 1.0e-6
                },
                dialogVisible: false,
                lineTypes: [{value:1001,label:'点划线'},{value:1002,label:'折线'}],
                lineType: 1001,
                lineColors: [{value:2001,label:'蓝色'},{value:2002,label:'红色'},{value:2003,label:'绿色'}],
                lineColor: 2002
            }
        },
        computed: {
            runBtnHtml(){
                if (this.currentStatus === true){
                    return '<i class="el-icon-video-pause" style="font-size: 30px"></i><br/><br/> 暂停'
                }else {
                    return '<i class="el-icon-video-play" style="font-size: 30px"></i><br/><br/> 运行'
                }
            }
        },
        methods:{
            run() {
                this.currentStatus = !this.currentStatus
                if (this.currentStatus === true){
                    this.disabledStatus = true
                    console.log('开始运行');
                    axios({
                        url: 'workbench/odu/minJT',
                        method: 'get'
                    }).then((res)=>{
                        console.log(res);
                        window.open("webfigure_pc.jsp","workareaFrame");
                    })
                }else {
                    console.log("停止运行")
                    this.disabledStatus = false
                }
            },
            parse(){

            },
            displayDrawer() {
                this.drawer = !this.drawer
            },
            toWorkbench(path) {
                console.log(path);
                window.location.href=path
            }
        }
    })
</script>
</html>
