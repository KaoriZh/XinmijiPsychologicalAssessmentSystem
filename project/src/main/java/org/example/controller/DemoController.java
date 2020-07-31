package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/demo")
public class DemoController {

    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public ModelAndView hello(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("hello");
        mv.addObject("name", "233");
        return mv;
    }

    @RequestMapping("/hi")
    public ModelAndView hi() {
        ModelAndView mv = new ModelAndView("hello");
        mv.addObject("name", "345");
        return mv;
    }

}
