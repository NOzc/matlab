<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wf" uri="http://www.mathworks.com/builderja/webfigures.tld" %>
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
        .login-container .el-input input{
            background-color: transparent;
            border: 0px;
            -webkit-appearance: none;
            border-radius: 0px;
            color: #fff;
            height: 47px;
            caret-color: #fff;
        }
        .login-container .el-form-item{
            border: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            color: #454545;
        }
        .login-container{
            height: 100vh;
            width: 100%;
            background-color: #2d3a4b;
            overflow: hidden;
        }
        .login-container .login-form{
            position: relative;
            width: 520px;
            max-width: 100%;
            padding: 160px 35px 0;
            margin: 0 auto;
            overflow: hidden;
        }
        .login-container .title-container{
            position: relative;
        }
        .login-container .title-container .title{
            font-size: 26px;
            color: #eee;
            margin: 0px auto 40px auto;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body style="margin: 0">
<div id="app" style="width: 100%;height: 100%;background-color:#283443;">
    <div class="login-container">
        <el-form :rules="rules" ref="loginForm" :model="loginForm" class="login-form" style="position: relative">
            <div class="title-container">
                <h3 class="title">系统登录</h3>
            </div>
            <el-form-item prop="username">
                <el-input type="text" auto-complete="false" v-model="loginForm.username" placeholder="请输入用户名"></el-input>
            </el-form-item>
            <el-form-item prop="password">
                <el-input type="password" auto-complete="false" v-model="loginForm.password" placeholder="请输入密码"></el-input>
            </el-form-item>
            <el-button type="primary" style="width: 100%" @click="submitLogin">登录</el-button>
        </el-form>
        <div style="position: absolute;right: 38%;">
            <el-button type="text" @click="toRegister">没有账号?去注册-></el-button>
        </div>
    </div>

</div>
</body>
<script>
    new Vue({
        el: '#app',
        data() {
            return {
                captchaUrl: '',
                loginForm: {
                    username: '',
                    password: ''
                },
                checked: true,
                rules: {
                    username: [{required: true, message: '请输入用户名', trigger: 'blur'}],
                    password: [{required: true, message: '请输入密码', trigger: 'blur'}]
                },
            }
        },
        methods: {
            submitLogin() {
                this.$refs.loginForm.validate((valid) => {
                    if (valid) {
                        axios({
                            method: 'get',
                            url: 'user/login.do',
                            params: {
                                username: this.loginForm.username,
                                password: this.loginForm.password
                            }
                        }).then((res)=>{
                            console.info(res)
                            if (res.data.code==="0"){
                                this.$alert(res.data.message,'提示',{
                                    confirmButtonText: '确定',
                                    type: 'error'
                                })
                            }else {
                                this.$alert(res.data.message,'提示',{
                                    confirmButtonText: '确定',
                                    type: 'success'
                                }).then(()=>{
                                    console.log('跳转到主页面');
                                    window.location.href="index.jsp"
                                })
                                <%--window.location.href='<%=request.getContextPath()%>/'--%>
                            }
                        })
                    } else {
                        this.$message.error('用户名和密码不能为空！')
                        return false;
                    }
                });
            },
            toRegister() {
                window.location.href="register.jsp"
            }
        }
    })
</script>
</html>