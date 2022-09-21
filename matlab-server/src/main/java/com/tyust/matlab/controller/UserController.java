package com.tyust.matlab.controller;

import com.mathworks.toolbox.javabuilder.MWClassID;
import com.mathworks.toolbox.javabuilder.MWException;
import com.mathworks.toolbox.javabuilder.MWNumericArray;
import com.tyust.matlab.common.Contacts;
import com.tyust.matlab.common.entity.ReturnObject;
import com.tyust.matlab.common.utils.UUIDUtil;
import com.tyust.matlab.entity.User;
import com.tyust.matlab.service.UserService;
import myGA_test.GA;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@CrossOrigin
public class UserController {

    @Resource
    private UserService userService;

    @RequestMapping("/user/login.do")
    @ResponseBody
    public Object login(User user, HttpSession session){

        /*try {
            GA func = new GA();
            Object[] result = func.myGA_test(2,new MWNumericArray(1, MWClassID.INT32),
                    new MWNumericArray(0, MWClassID.DOUBLE)
                    ,new MWNumericArray(1, MWClassID.DOUBLE),
                    new MWNumericArray(50, MWClassID.INT32),
                    new MWNumericArray(50, MWClassID.INT32),
                    new MWNumericArray(0.1, MWClassID.DOUBLE),
                    new MWNumericArray(0.1, MWClassID.DOUBLE),
                    new MWNumericArray(0.01, MWClassID.DOUBLE));
//            Object[] result = func.myGA_test(2, 0, 0, 1, 50, 50, 0.1, 0.1, 0.01);
            System.out.println("输出调用结果==============》》》》》》");
            for (int i = 0; i < result.length; i++) {
                System.out.println(result[i]);
            }
        } catch (MWException e) {
            e.printStackTrace();
        }*/

        User u = userService.queryUser(user);
        ReturnObject res = new ReturnObject();
        if (u!=null){
            session.setAttribute(Contacts.SESSION_USER,u);
            res.setCode(Contacts.RETURN_OBJECT_CODE_SUCCESS);
            res.setMessage("登录成功");
            res.setRetData(u);
        }else{
            res.setCode(Contacts.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("用户不存在");
        }
        return res;
    }

    @RequestMapping("/user/logout.do")
    @ResponseBody
    public Object logout(HttpSession session){
        session.invalidate();
        ReturnObject res = new ReturnObject();
        res.setCode(Contacts.RETURN_OBJECT_CODE_SUCCESS);
        res.setMessage("您已退出系统");
        return res;
    }

    @RequestMapping("/user/register.do")
    @ResponseBody
    public Object register(User user){
        User u = userService.queryUser(user);
        ReturnObject res = new ReturnObject();
        if (u!=null){
            res.setCode(Contacts.RETURN_OBJECT_CODE_FAIL);
            res.setMessage("用户已存在！");
        }else {
            try{
                user.setId(UUIDUtil.getUUID());
                int count = userService.createUser(user);
                if (count==1){
                    res.setCode(Contacts.RETURN_OBJECT_CODE_SUCCESS);
                    res.setMessage("注册成功");
                    res.setRetData(user);
                }else{
                    res.setCode(Contacts.RETURN_OBJECT_CODE_FAIL);
                    res.setMessage("系统繁忙，请稍后重试....");
                }
            }catch (Exception e){
                e.printStackTrace();
                res.setCode(Contacts.RETURN_OBJECT_CODE_FAIL);
                res.setMessage("系统繁忙，请稍后重试....");
            }
        }
        return res;
    }
}
