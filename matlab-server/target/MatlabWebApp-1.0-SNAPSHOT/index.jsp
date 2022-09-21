<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>OMVES</title>

    <!-- Bootstrap Core CSS -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/animate.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="assets/css/style.css" rel="stylesheet">

    <link href="assets/css/pe-icons.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="assets/js/jquery.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- import Vue before Element -->
    <script src="assets/config/vue.js"></script>
    <!-- import JavaScript -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="assets/config/axios.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            'use strict';
            jQuery('#headerwrap').backstretch([
                "assets/img/bg/bg1.jpg",
                "assets/img/bg/bg2.jpg",
                "assets/img/bg/bg3.jpg"
            ], {duration: 8000, fade: 500});
        });
    </script>

</head>

<body id="page-top" class="index">

<div class="preloader">
    <div class="preloader-img">
        <img src="assets/img/loading-bars.svg" width="100" alt="Loading icon" />
    </div>
</div>

<!-- Navigation -->
<nav class="navbar navbar-default navbar-shrink bounceInDown" data-wow-delay="2s">
    <div class="container">
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li><a class="navbar-brand" href="index.html">OMVES</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">一维无约束<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="views/odu/minJT.jsp">进退法</a></li>
                        <li><a href="views/odu/minHJ.jsp">黄金分割法</a></li>
                        <li><a href="views/odu/minFBNQ.jsp">斐波那契法</a></li>
                        <li><a href="views/odu/minNewton.jsp">牛顿法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">多维无约束<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">模式搜索法线性规划</a></li>
                        <li><a href="#">Rosenbrock法</a></li>
                        <li><a href="#">单纯形搜索法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">约束优化<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="index-coming-soon.html">Rosen梯度投影法</a></li>
                        <li><a href="index-coming-soon.html">外点罚函数法</a></li>
                        <li><a href="index-coming-soon.html">内点罚函数法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">非线性二乘<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="index-coming-soon.html">G-N法</a></li>
                        <li><a href="index-coming-soon.html">修正G-N法</a></li>
                        <li><a href="index-coming-soon.html">L-M法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">线性规划<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="index-coming-soon.html">单纯形法</a></li>
                        <li><a href="index-coming-soon.html">完整单纯形法</a></li>
                        <li><a href="index-coming-soon.html">修正单纯形法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">整数规划<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="index-coming-soon.html">割平面法</a></li>
                        <li><a href="index-coming-soon.html">分支定界法</a></li>
                        <li><a href="index-coming-soon.html">枚举法（包括穷举法和隐枚举法）</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">二次规划<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="index-coming-soon.html">拉格朗日法</a></li>
                        <li><a href="index-coming-soon.html">起作用集法</a></li>
                        <li><a href="index-coming-soon.html">路径跟踪法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">粒子群算法<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="index-video.html">基本粒子群算法</a></li>
                        <li><a href="index-onepager.html">带压缩因子的粒子群算法</a></li>
                        <li><a href="index-coming-soon.html">线性递减权重粒子群优化算法</a></li>
                        <li><a href="index-coming-soon.html">自适应权重粒子群优化算法</a></li>
                        <li><a href="index-coming-soon.html">随机权重粒子群优化算法</a></li>
                        <li><a href="index-coming-soon.html">学习因子同步变化的粒子群优化算法</a></li>
                        <li><a href="index-coming-soon.html">学习因子异步变化的粒子群优化算法</a></li>
                        <li><a href="index-coming-soon.html">二阶粒子群优化算法</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">遗传算法<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">基本遗传算法</a></li>
                        <li><a href="index-onepager.html">顺序选择遗传算法</a></li>
                        <li><a href="index-coming-soon.html">动态线性标定适应值的遗传算法</a></li>
                        <li><a href="index-coming-soon.html">大变异遗传算法</a></li>
                        <li><a href="index-coming-soon.html">自适应遗传算法</a></li>
                        <li><a href="index-coming-soon.html">双切点遗传</a></li>
                        <li><a href="index-coming-soon.html">多变异位自适应遗传</a></li>
                    </ul>
                </li>
            </ul>
            <div id="app">
                <div style="position: absolute;top: 20%;right: 10%">
                    <c:if test="${empty sessionScope.sessionUser}">
                        <el-button type="primary" round @click="login">登录</el-button>
                    </c:if>
                    <c:if test="${not empty sessionScope.sessionUser}">
<%--                        <el-button type="primary" round style="position:absolute;top: 20%;right: 5%" @click="logout">安全退出</el-button>--%>
<%--                        <el-tag style="position: absolute;top: 20%;right: 13%" type="success">${sessionScope.sessionUser.username}</el-tag>--%>
                        <el-dropdown>
                            <el-avatar icon="el-icon-user-solid"></el-avatar>
                            <el-dropdown-menu>
                                <el-dropdown-item><el-button @click="logout">退出登录</el-button></el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown>
                    </c:if>
                </div>
            </div>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>
<!-- Header -->
<header id="headerwrap" class="fullheight">
    <div class="container">
        <div class="intro-text">
            <div class="intro-lead-in wow bounceInDown" data-wow-delay="0.5s">欢迎 <span class="wodry"> 您 |学生|教师|从业者</span> 使用</div>
            <div class="intro-heading wow bounceInUp" data-wow-delay="1s">最优化方法 <span class="thin">可视化实验系统</span></div>
            <a class="page-scroll btn btn-xl btn-negative wow bounceInDown" data-wow-delay="2s">开始</a>
        </div>
    </div>
</header>
<!-- Bootstrap Core JavaScript -->
<script src="assets/js/bootstrap.min.js"></script>
<!-- Plugin JavaScript -->
<script src="assets/js/plugins.js"></script>
<!-- Plugins -->
<script src="assets/js/jqBootstrapValidation.js"></script>
<script src="assets/js/contact_me.js"></script>
<!-- Custom JavaScript -->
<script src="assets/js/init.js"></script>

</body>
<script>
    new Vue({
        el: '#app',
        data() {
            return {

            }
        },
        methods:{
            login(){
                window.location.href='login.jsp'
            },
            logout() {
                // window.location.href='user/logout.do'
                axios({
                    url: "user/logout.do",
                }).then((res)=>{
                    console.info("退出系统",res)
                    if (res.data.code==="1"){
                        this.$alert(res.data.message,'提示',{
                            confirmButtonText: '确定',
                            type: 'success'
                        }).then(()=>{
                            window.location.href="login.jsp"
                        })
                    }
                })
            }
        }
    })
</script>
</html>
