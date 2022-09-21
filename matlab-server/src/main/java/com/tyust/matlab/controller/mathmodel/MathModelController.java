package com.tyust.matlab.controller.mathmodel;

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
public class MathModelController {

    @RequestMapping("/workbench/math_model/time_series")
    @ResponseBody
    public Object timeSeries(Double[]  arr, Integer N, HttpServletRequest request){
        System.out.println("开始数学建模");

        System.out.println(arr.length);
        double[] array = new double[arr.length];
        for (int i = 0; i < arr.length; i++) {
            array[i] = arr[i].doubleValue();
        }
        System.out.println(N);
//        System.out.println(arr.length);
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List<Double> list = new ArrayList<>();
        try {
            Object[] result = proxy.returningFeval("xulie", 2, array, N);
            if (result!=null){
                System.out.println("结果不为空");
                double value = ((double[]) result[0])[0];
                double error = ((double[]) result[1])[0];
                System.out.println(value+"==========="+error);
                list.add(value);
                list.add(error);
            }
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
        return list;
    }
}
