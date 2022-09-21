package com.tyust.matlab.controller;

import matlabcontrol.MatlabInvocationException;
import matlabcontrol.MatlabProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@CrossOrigin
public class OduController {

    @RequestMapping("/workbench/odu/minHJ")
    @ResponseBody
    public Object minHJ(String func, Double lOpt, Double rOpt, Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double leftPoint = lOpt.doubleValue();
        double rightPoint = rOpt.doubleValue();
        double e = eps.doubleValue();
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minHJ",3,func,leftPoint,rightPoint,e,startIndex,endIndex);
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/odu/minJT")
    @ResponseBody
    public Object minJT(String func,Double initPoint,Double initStep,Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double point = initPoint;
        double step = initStep;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minJT",5,func,point,step,e,startIndex,endIndex);
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(((double[]) result[2])[0]);
                list.add(((double[]) result[3])[0]);
                list.add(result[4]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/odu/minFBNQ")
    @ResponseBody
    public Object minFBNQ(String func,Double lOpt,Double rOpt,Double delta,Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double a = lOpt;
        double b = rOpt;
        double d = delta;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minFBNQ",3,func,a,b,d,e,startIndex,endIndex);
            if (result != null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/odu/minGX")
    @ResponseBody
    public Object minGX(String func,Double x0,Double x1,Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double a = x0;
        double b = x1;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minGX",3,func,a,b,e,startIndex,endIndex);
            if (result != null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/odu/minNewton")
    @ResponseBody
    public Object minNewton(String func,Double x0,Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double a = x0;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minNewton",3,func,a,e,startIndex,endIndex);
            if (result != null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/odu/minPWX")
    @ResponseBody
    public Object minPWX(String func,Double lOpt,Double rOpt,Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double a = lOpt;
        double b = rOpt;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minPWX",3,func,a,b,e,startIndex,endIndex);
            if (result != null){
                System.out.println("抛物线取得结果");
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @RequestMapping("/workbench/odu/minTri")
    @ResponseBody
    public Object minTri(String func,Double lOpt,Double rOpt,Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        double a = lOpt;
        double b = rOpt;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minTri",3,func,a,b,e,startIndex,endIndex);
            if (result!=null){
                System.out.println("三次插值取得结果");
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @RequestMapping("/workbench/odu/minWP")
    @ResponseBody
    public Object minWP(String func,Double XMAX,Double sigma1,Double sigma2,Double alpha,Double eps,
                        Double xliml,Double xlimr,HttpServletRequest request){
        double xmax = XMAX;
        double s1 = sigma1;
        double s2 = sigma2;
        double a = alpha;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minWP",3,func,xmax,s1,s2,a,e,startIndex,endIndex);
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/odu/minGS")
    @ResponseBody
    public Object minGS(String func,Double XMAX,Double sigma1,Double sigma2,Double alpha,Double eps,
                        Double xliml,Double xlimr,HttpServletRequest request){
        double xmax = XMAX;
        double s1 = sigma1;
        double s2 = sigma2;
        double a = alpha;
        double e = eps;
        double startIndex = xliml;
        double endIndex = xlimr;
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("minGS",3,func,xmax,s1,s2,a,e,startIndex,endIndex);
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException ex) {
            ex.printStackTrace();
        }
        return list;
    }
}
