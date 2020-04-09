package com.mex.notebook.common;

import java.util.List;
import java.util.Map;

public interface BaseDao<T> {
    List<T> getList(Map<String, Object> var1);

    List<T> getPage(Map<String, Object> var1);

    T findById(Object var1);

    void save(T var1);

    void save(Map<String, Object> var1);

    void save(List<T> var1);

    int update(T var1);

    int update(Map<String, Object> var1);

    int deleteById(Object var1);

    int deleteByIds(Object[] var1);

    int delete(Map<String, Object> var1);

    int queryTotal();

    int queryTotal(Map<String, Object> var1);
}
