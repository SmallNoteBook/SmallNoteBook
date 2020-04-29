package com.mex.notebook.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringUtil implements ApplicationContextAware {

//    private static ApplicationContext applicationContext;
//
//    @Override
//    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
//        if (SpringUtil.applicationContext == null) {
//            SpringUtil.applicationContext = applicationContext;
//        }
//    }
//
//    // 获取applicationContext
//    public static ApplicationContext getApplicationContext() {
//        return applicationContext;
//    }
//
//    // 通过name获取 Bean.
//    public static Object getBean(String name) {
//        return getApplicationContext().getBean(name);
//    }
//
//    // 通过class获取Bean.
//    public static <T> T getBean(Class<T> clazz) {
//        return getApplicationContext().getBean(clazz);
//    }
//
//    // 通过name,以及Clazz返回指定的Bean
//    public static <T> T getBean(String name, Class<T> clazz) {
//        return getApplicationContext().getBean(name, clazz);
//    }

    private static ApplicationContext ac;

    @Override
    public void setApplicationContext(ApplicationContext arg0) throws BeansException {
        ac = arg0;
    }

    public static ApplicationContext getApplicationContext() {
        return ac;
    }

    /**
     * 通过class获取Bean
     */
    public static <T> T getBean(Class<T> clazz){
        return getApplicationContext().getBean(clazz);
    }


    /**
     * 如果BeanFactory包含所给名称匹配的bean返回true
     * @param name
     * @return boolean
     */
    public static boolean containsBean(String name) {
        return ac.containsBean(name);
    }

    /**
     * 判断注册的bean是singleton还是prototype。
     * 如果与给定名字相应的bean定义没有被找到，将会抛出一个异常（NoSuchBeanDefinitionException）
     * @param name
     * @return boolean
     */
    public static boolean isSingleton(String name) {
        return ac.isSingleton(name);
    }

    /**
     * @param name
     * @return Class 注册对象的类型
     */
    public static Class<?> getType(String name) {
        return ac.getType(name);
    }


}
