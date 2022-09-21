package com.tyust.matlab.config;


import matlabcontrol.*;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.io.Serializable;

public class MatlabListener implements ServletContextListener, Serializable {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        File file = new File("D:\\JetBrains\\matlab-project\\MatlabWebApp");//知道m文件的路基，可以任意
        MatlabProxyFactoryOptions options = new MatlabProxyFactoryOptions.Builder()
                .setMatlabLocation("E:\\program files\\MATLAB\\R2021b\\bin\\matlab.exe")
                .setProxyTimeout(300000L)
                .setMatlabStartingDirectory(file)//设置MATLAB的开始目录。
                .setHidden(false)
                .build();
        MatlabProxyFactory factory = new MatlabProxyFactory(options);
        MatlabProxy proxy = null;
        try {
            proxy = factory.getProxy();
        }catch (MatlabConnectionException e) {
            e.printStackTrace();
        }

        sce.getServletContext().setAttribute("proxy",proxy);
        System.out.println(">>>连接matlab成功<<<");

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        MatlabProxy proxy = (MatlabProxy) sce.getServletContext().getAttribute("proxy");
        try {
            proxy.exit();
        } catch (MatlabInvocationException e) {
            e.printStackTrace();
        }
    }
}
