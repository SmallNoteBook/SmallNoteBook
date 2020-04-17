package com.mex.notebook.admin.dao;

import com.mex.notebook.admin.entity.User;
import com.mex.notebook.common.BaseDao;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;


@Mapper
public interface UserDao extends BaseDao<User> {
    List<User> queryUser(Map<String,Object> param);
}
