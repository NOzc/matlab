import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
const PW = ()=>import('../views/PW')
const Index=()=>import('../views/pc/Index')
const PCLogin = ()=> import('../views/pc/settings/PCLogin')

// 一维无约束
const PCMinHJ = ()=>import('../views/pc/workbench/odu/PCMinHJ')
const PCMinJT = ()=>import('../views/pc/workbench/odu/PCMinJT')
const PCMinFBNQ = ()=>import('../views/pc/workbench/odu/PCMinFBNQ')
const PCMinNewton=()=>import('../views/pc/workbench/odu/PCMinNewton')
const PCMinGX=()=>import("../views/pc/workbench/odu/PCMinGX")
const PCMinPWX=()=>import('../views/pc/workbench/odu/PCMinPWX')
const PCMinTri=()=>import('../views/pc/workbench/odu/PCMinTri')
const PCMinWP=()=>import('../views/pc/workbench/odu/PCMinWP')
const PCMinGS=()=>import('../views/pc/workbench/odu/PCMinGS')
// 多维无约束
const PCMinPS = ()=>import('../views/pc/workbench/mu/PCMinPS')
const PCMinSimpSearch=()=>import('../views/pc/workbench/mu/PCMinSimpSearch')
const PCMinRb=()=>import('../views/pc/workbench/mu/PCMinRb')
// 约束优化
const PCMinRosen=()=>import('../views/pc/workbench/co/PCMinRosen')
const PCMinPF=()=>import('../views/pc/workbench/co/PCMinPF')
const PCMinGeneralPF=()=>import('../views/pc/workbench/co/PCMinGeneralPF')
const PCMinNF = ()=>import('../views/pc/workbench/co/PCMinNF')
// 整数规划
const PCDivideplane=()=>import('../views/pc/workbench/ip/PCDivideplane')
const PCIntProgFZ=()=>import('../views/pc/workbench/ip/PCIntProgFZ')
const PCZeroOneprog=()=>import('../views/pc/workbench/ip/PCZeroOneprog')
// 二次规划
const PCActivdeSet=()=>import('../views/pc/workbench/sp/PCActivdeSet')
const PCQuadLagR=()=>import('../views/pc/workbench/sp/PCQuadLagR')
const PCTrackRoute=()=>import('../views/pc/workbench/sp/PCTrackRoute')
//遗传
const PCMyGA=()=>import('../views/pc/workbench/ih/PCMyGA')
const PCSBOGA=()=>import('../views/pc/workbench/ih/PCSBOGA')
const PCNormFitGA=()=>import('../views/pc/workbench/ih/PCNormFitGA')
const PCGMGA=()=>import('../views/pc/workbench/ih/PCGMGA')
const PCAdapGA=()=>import('../views/pc/workbench/ih/PCAdapGA')
const PCDblGEGA=()=>import('../views/pc/workbench/ih/PCDblGEGA')
const PCMMAdapGA=()=>import('../views/pc/workbench/ih/PCMMAdapGA')



const MOLogin = ()=>import('../views/mobile/settings/MOLogin')
//一维无约束
const MOMinJT = ()=>import('../views/mobile/workbench/odu/MOMinJT')
const MOMinHJ = ()=>import('../views/mobile/workbench/odu/MOMinHJ')
const MOMinFBNQ = ()=> import('../views/mobile/workbench/odu/MOMinFBNQ')
const MOMinNewton=()=>import('../views/mobile/workbench/odu/MOMinNewton')
const MOMinGX=()=>import('../views/mobile/workbench/odu/MOMinGX')
const MOMinGS=()=>import('../views/mobile/workbench/odu/MOMinGS')
const MOMinWP=()=>import('../views/mobile/workbench/odu/MOMinWP')
//多维无约束
const MOMinPS = ()=>import('../views/mobile/workbench/mu/MOMinPS')
const MOMinSimpSearch=()=>import('../views/mobile/workbench/mu/MOMinSimpSearch')
const MOMinRb=()=>import('../views/mobile/workbench/mu/MOMinRb')
//约束优化
const MOMinGeneralPF=()=>import('../views/mobile/workbench/co/MOMinGeneralPF')
const MOMinNF=()=>import('../views/mobile/workbench/co/MOMinNF')
const MoMinPF=()=>import('../views/mobile/workbench/co/MOMinPF')
//整数规划
const MODivideplane=()=>import('../views/mobile/workbench/ip/MODivideplane')
const MOIntProgFZ=()=>import('../views/mobile/workbench/ip/MOIntProgFZ')
const MOZeroOneprog=()=>import('../views/mobile/workbench/ip/MOZeroOneprog')
//二次规划
const MOActivdeSet=()=>import('../views/mobile/workbench/sp/MOActivdeSet')
const MOQuadLagR=()=>import('../views/mobile/workbench/sp/MOQuadLagR')
const MOTrackRoute=()=>import('../views/mobile/workbench/sp/MOTrackRoute')
//遗传
const MOMyGA=()=>import('../views/mobile/workbench/ih/MOMyGA')
const MOAdapGA=()=>import('../views/mobile/workbench/ih/MOAdapGA')
const MODblGEGA=()=>import('../views/mobile/workbench/ih/MODblGEGA')
const MOGMGA=()=>import('../views/mobile/workbench/ih/MOGMGA')
const MOMMAdapGA=()=>import('../views/mobile/workbench/ih/MOMMAdapGA')
const MONormFitGA=()=>import('../views/mobile/workbench/ih/MONormFitGA')
const MOSBOGA=()=>import('../views/mobile/workbench/ih/MOSBOGA')
// 数学建模
const PCTimeSeries=()=>import('../views/pc/workbench/mathModel/PCTimeSeries')
const MOTimeSeries=()=>import('../views/mobile/workbench/mathModel/MOTimeSeries')
const WorkDesign = ()=>import('../views/pw/WorkDesign')
const PlatformIntroduction=()=>import('../views/pw/PlatformIntroduction')
const routes = [
  {
    path: '/pw',
    component: PW,
    children:[
      {
        path: 'work_designer',
        component:WorkDesign
      },
      {
        path: 'platformIntroduction',
        component: PlatformIntroduction
      }
    ]
  },
  {
    path: '/pc',
    redirect: '/pc/settings/user/login'
  },
  {
    path: '/pc/matlab/index',
    component: Index
  },
  {
    path: '/pc/settings/user/login',
    component: PCLogin
  },
  {
    path: '/pc/workbench/odu/minhj',
    component: PCMinHJ
  },
  {
    path: '/pc/workbench/odu/minjt',
    component: PCMinJT
  },
  {
    path: '/pc/workbench/odu/minfbnq',
    component: PCMinFBNQ
  },
  {
    path: '/pc/workbench/odu/minnewton',
    component: PCMinNewton
  },
  {
    path: '/pc/workbench/odu/mingx',
    component: PCMinGX
  },
  {
    path: '/pc/workbench/odu/minpwx',
    component: PCMinPWX
  },
  {
    path: '/pc/workbench/odu/mintri',
    component: PCMinTri
  },
  {
    path: '/pc/workbench/odu/minwp',
    component: PCMinWP
  },
  {
    path: '/pc/workbench/odu/mings',
    component: PCMinGS
  },
  {
    path: '/pc/workbench/mu/minps',
    component: PCMinPS
  },
  {
    path: '/pc/workbench/mu/minsimpsearch',
    component: PCMinSimpSearch
  },
  {
    path: '/pc/workbench/mu/minrb',
    component: PCMinRb
  },
  {
    path: '/pc/workbench/co/minrosen',
    component: PCMinRosen
  },
  {
    path: '/pc/workbench/co/minpf',
    component: PCMinPF
  },
  {
    path: '/pc/workbench/co/mingeneralpf',
    component: PCMinGeneralPF
  },
  {
    path: '/pc/workbench/co/minnf',
    component: PCMinNF
  },
  {
    path: '/pc/workbench/ip/intProgFZ',
    component: PCIntProgFZ
  },
  {
    path: '/pc/workbench/ip/zeroOneprog',
    component: PCZeroOneprog
  },
  {
    path: '/pc/workbench/ip/divideplane',
    component: PCDivideplane
  },
  {
    path: '/pc/workbench/sp/activdeSet',
    component: PCActivdeSet
  },
  {
    path: '/pc/workbench/sp/quadLagR',
    component: PCQuadLagR
  },
  {
    path: '/pc/workbench/sp/trackRoute',
    component: PCTrackRoute
  },
  {
    path: '/pc/workbench/ih/myga',
    component: PCMyGA
  },
  {
    path: '/pc/workbench/ih/sboga',
    component: PCSBOGA
  },
  {
    path: '/pc/workbench/ih/normfitga',
    component: PCNormFitGA
  },
  {
    path: '/pc/workbench/ih/gmga',
    component: PCGMGA
  },
  {
    path: '/pc/workbench/ih/adapga',
    component: PCAdapGA
  },
  {
    path: '/pc/workbench/ih/dblgega',
    component: PCDblGEGA
  },
  {
    path: '/pc/workbench/ih/mmadapga',
    component: PCMMAdapGA
  },
  {
    // 数学建模
    path: '/pc/workbench/mathmodel/tsp',
    component: PCTimeSeries
  },
  {
    path: '/mobile',
    redirect: '/mobile/settings/user/login'
  },
  {
    path: '/mobile/settings/user/login',
    component: MOLogin
  },
  {
    path: '/mobile/workbench/odu/minjt',
    component: MOMinJT
  },
  {
    path: '/mobile/workbench/odu/minhj',
    component: MOMinHJ
  },
  {
    path: '/mobile/workbench/odu/minfbnq',
    component: MOMinFBNQ
  },
  {
    path:'/mobile/workbench/odu/minnewton',
    component: MOMinNewton
  },
  {
    path:'/mobile/workbench/odu/mingx',
    component: MOMinGX
  },
  {
    path: '/mobile/workbench/odu/mings',
    component: MOMinGS
  },
  {
    path: '/mobile/workbench/odu/minwp',
    component: MOMinWP
  },
  {
    path: '/mobile/workbench/mu/minps',
    component:MOMinPS
  },
  {
    path:'/mobile/workbench/mu/minsimpsearch',
    component:MOMinSimpSearch
  },
  {
    path: '/mobile/workbench/mu/minrb',
    component: MOMinRb
  },
  {
    path: '/mobile/workbench/co/mingreneralpf',
    component: MOMinGeneralPF
  },
  {
    path: '/mobile/workbench/co/minnf',
    component:MOMinNF
  },
  {
    path: '/mobile/workbench/co/minpf',
    component:MoMinPF
  },
  {
    path: '/mobile/workbench/ip/divideplane',
    component: MODivideplane
  },
  {
    path: '/mobile/workbench/ip/intprogfz',
    component: MOIntProgFZ
  },
  {
    path: '/mobile/workbench/ip/zerooneprog',
    component: MOZeroOneprog
  },
  {
    path: '/mobile/workbench/sp/activdeset',
    component:MOActivdeSet
  },
  {
    path: '/mobile/workbench/sp/quadlagr',
    component: MOQuadLagR
  },
  {
    path: '/mobile/workbench/sp/trackroute',
    component:MOTrackRoute
  },
  {
    path: '/mobile/workbench/ih/myga',
    component: MOMyGA
  },
  {
    path: '/mobile/workbench/ih/adapga',
    component: MOAdapGA
  },
  {
    path: '/mobile/workbench/ih/dblgega',
    component: MODblGEGA
  },
  {
    path: '/mobile/workbench/ih/gmga',
    component: MOGMGA
  },
  {
    path: '/mobile/workbench/ih/mmadapga',
    component: MOMMAdapGA
  },
  {
    path: '/mobile/workbench/ih/normfitga',
    component: MONormFitGA
  },
  {
    path: '/mobile/workbench/ih/sboga',
    component: MOSBOGA
  },
  {
    path: '/mobile/workbench/mathmodel/tsp',
    component: MOTimeSeries
  }
]

const router = new VueRouter({
  routes
})

export default router
