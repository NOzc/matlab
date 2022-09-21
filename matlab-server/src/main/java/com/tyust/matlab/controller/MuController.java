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
public class MuController {

    @RequestMapping("/workbench/mu/minPS")
    @ResponseBody
    public Object minPS(String func, Double[] x0, Double[] delta, Double gama, Double sita, Double eps,
                        Double xliml,Double xlimr,Double yliml,Double ylimr,HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        double[] arr1 = new double[x0.length];
        double[] arr2 = new double[delta.length];
        for (int i = 0; i < x0.length; i++) {
            arr1[i] = x0[i].doubleValue();
        }
        for (int i = 0; i < delta.length; i++) {
            arr2[i] = delta[i].doubleValue();
        }
        double x_startIndex = xliml;
        double x_endIndex = xlimr;
        double y_startIndex = yliml;
        double y_endIndex = ylimr;
        try {
            Object[] result = proxy.returningFeval("minPS",3,func,arr1,arr2,gama.doubleValue(),
                    sita.doubleValue(),eps.doubleValue(),x_startIndex,x_endIndex,y_startIndex,y_endIndex);
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
