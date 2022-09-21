package com.tyust.matlab.controller;

import matlabcontrol.MatlabProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@CrossOrigin
public class SpController {

    @RequestMapping("/workbench/sp/QuadLagR")
    public Object QuadLagR(String H, String c, String A, Double b, HttpServletRequest request){
        MatlabProxy proxy = (MatlabProxy) request.getServletContext().getAttribute("proxy");
        List list = new ArrayList();
        
        return null;
    }
}
