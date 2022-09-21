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
public class IhController {

    @RequestMapping("/workbench/ih/myGA")
    @ResponseBody
    public Object myGA(String func, Double a, Double b, Integer NP, Integer NG, Double Pc, Double Pm, Double eps,
                       Double xliml, Double xlimr, HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("myGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),
                    NG.intValue(),Pc.doubleValue(),Pm.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result != null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/ih/SBOGA")
    @ResponseBody
    public Object SBOGA(String func,Double a,Double b,Integer NP,Integer NG,Double q,Double Pc,Double Pm,
                        Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("SBOGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),NG.intValue(),q.doubleValue(),Pc.doubleValue(),Pm.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/ih/NormFitGA")
    @ResponseBody
    public Object NormFitGA(String func,Double a,Double b,Integer NP,Integer NG,Double ksi0,Double c,Double Pc,Double Pm,
                            Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("NormFitGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),NG.intValue(),ksi0.doubleValue(),c.doubleValue(),Pc.doubleValue(),Pm.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/ih/GMGA")
    @ResponseBody
    public Object GMGA(String func,Double a,Double b,Integer NP,Integer NG,Double Pc,Double Pm,Double alpha,Double Pbm,
                       Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("GMGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),NG.intValue(),Pc.doubleValue(),Pm.doubleValue(),alpha.doubleValue(),Pbm.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/ih/AdapGA")
    @ResponseBody
    public Object AdapGA(String func,Double a,Double b,Integer NP,Integer NG,Double Pc1,Double Pc2,Double Pm1,Double Pm2,
                         Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("AdapGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),NG.intValue(),Pc1.doubleValue(),Pc2.doubleValue(),Pm1.doubleValue(),Pm2.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }

    @RequestMapping("/workbench/ih/DblGEGA")
    @ResponseBody
    public Object DblGEGA(String func,Double a,Double b,Integer NP,Integer NG,Double Pc,Double Pm,Double eps,
                          Double xliml,Double xlimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("DblGEGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),NG.intValue(),Pc.doubleValue(),Pm.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }

        return list;
    }

    @RequestMapping("/workbench/ih/MMAdapGA")
    @ResponseBody
    public Object MMAdapGA(String func,Double a,Double b,Integer NP,Integer NG,Double Pc1,Double Pc2,Double Pm1,Double Pm2,
                             Double eps,Double xliml,Double xlimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        try {
            Object[] result = proxy.returningFeval("MMAdapGA",3,func,a.doubleValue(),b.doubleValue(),NP.intValue(),NG.intValue(),Pc1.doubleValue(),Pc2.doubleValue(),Pm1.doubleValue(),Pm2.doubleValue(),eps.doubleValue(),xliml.doubleValue(),xlimr.doubleValue());
            if (result!=null){
                list.add(((double[]) result[0])[0]);
                list.add(((double[]) result[1])[0]);
                list.add(result[2]);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }
}
