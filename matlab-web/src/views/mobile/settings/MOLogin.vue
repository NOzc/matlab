<template>
  <div class="mo-login-container">
    <el-form :rules="rules" ref="loginForm" :model="loginForm" class="login-form">
      <div class="title-container">
        <div v-if="isLoginStatus">
          <h3 class="title">系统登录</h3>
        </div>
        <div v-else>
          <h3 class="title">注册账号</h3>
        </div>
      </div>
      <el-form-item prop="username">
        <el-input type="text" auto-complete="false" v-model="loginForm.username" placeholder="请输入用户名"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" auto-complete="false" v-model="loginForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <div v-if="isLoginStatus">
        <el-button type="primary" class="loginBtn" @click="submitLogin">登录</el-button>
      </div>
      <div v-else>
        <el-button type="primary" class="registerBtn" @click="submitRegister">注册</el-button>
      </div>
    </el-form>
    <div class="textBtn" v-if="isLoginStatus">
      <el-button type="text" @click="changeIsLoginStatus">没有账号?去注册-></el-button>
    </div>
    <div class="textBtn" v-else>
      <el-button type="text" @click="changeIsLoginStatus">已有账号?去登录-></el-button>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "MOLogin",
  data() {
    return {
      captchaUrl: '',
      loginForm: {
        username: '',
        password: ''
      },
      rules: {
        username: [{required: true, message: '请输入用户名', trigger: 'blur'}],
        password: [{required: true, message: '请输入密码', trigger: 'blur'}]
      },
      isLoginStatus: true
    }
  },
  methods: {
    submitLogin() {
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          axios({
            method: 'post',
            url: 'http://127.0.0.1:8080/matlab-server/user/login.do',
            params: {
              username: this.loginForm.username,
              password: this.loginForm.password
            }
          }).then((res)=>{
            console.info(res)
            if (res.data.code==="0"){
              this.$message.error(res.data.message);
            }else {
              this.$store.state.user.username = res.data.retData.username
              this.$router.replace('/mobile/workbench/odu/minjt')
              this.$message.success(res.data.message);
              //  vuex保存登录信息
              this.$store.state.user.username = res.data.retData.username
              // this.$router.replace('/matlab/index')
              //登录成功跳转到进退法主页面
              this.$router.replace('/mobile/workbench/odu/minjt')
            }
          })
        } else {
          this.$message.error('用户名和密码不能为空！')
          return false;
        }
      });
      // this.$router.replace('/mobile/workbench/odu/minjt');
    },
    submitRegister() {
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          axios({
            method: 'get',
            url: 'http://127.0.0.1:8080/matlab-server/user/register.do',
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
                this.isLoginStatus = true
              })
            }
          })
        } else {
          this.$message.error('请输入所有字段！')
          return false;
        }
      });
    },
    changeIsLoginStatus() {
      this.isLoginStatus = !this.isLoginStatus
    }
  }
}
</script>

<style scoped>
.mo-login-container{
  height: 100vh;
  width: 100%;
  background-color: #2d3a4b;
  overflow: hidden;
}
.mo-login-container .login-form{
  position: relative;
  width: 520px;
  max-width: 100%;
  padding: 160px 35px 0;
  margin: 0 auto;
  overflow: hidden;
}
.mo-login-container .title-container{
  position: relative;
}
.mo-login-container .title-container .title{
  font-size: 26px;
  color: #eee;
  margin: 0px auto 25% auto;
  text-align: center;
  font-weight: bold;
}
.loginBtn{
  width: 100%
}
.registerBtn{
  width: 100%
}
.textBtn{
  position: absolute;right: 38%
}
</style>
<style>
.mo-login-container .el-input input{
  background-color: transparent;
  border: 0px;
  -webkit-appearance: none;
  border-radius: 0px;
  color: #fff;
  height: 47px;
  caret-color: #fff;
}
.mo-login-container .el-form-item{
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  color: #454545;
}
</style>