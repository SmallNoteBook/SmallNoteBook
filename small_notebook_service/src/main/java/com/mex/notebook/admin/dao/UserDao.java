package com.mex.notebook.admin.dao;

import com.mex.notebook.common.BaseDao;
import org.apache.ibatis.annotations.Mapper;
import com.mex.notebook.admin.entity.User;

@Mapper
public interface UserDao extends BaseDao<User> {

}
