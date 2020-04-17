package com.mex.notebook.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.mex.notebook.admin.dao.UserDao;
import com.mex.notebook.admin.entity.User;


@Service
//@CacheConfig(cacheNames="userCache")
//@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor=Exception.class)
public class UserService {

    /** get the list of entity User
     * 列表方法，返回{@link List<User>}
     * @param map the input select conditions
     * @return {@link List<User>}
     */
    //@DataFilter(tableAlias = "B", owner = false)
    public List<User> getList(Map<String, Object> map){
        return dao.getList(map);
    }

    /** find the entity by input id, return entity
     * 对象详情方法，通过id查询对象{@link User}
     * @param id the input id
     * @return {@link User}
     */
    //@Cacheable(key="#p0")
    //@DataSource(name=DataSourceNames.FIRST)
    public User findById(Integer id){
        return dao.findById(id);
    }

    /** save the entity with input object
     * 保存对象方法
     * @param user the input user
     */
    //@Transactional
    public void save(User user){
        //user.init();
        dao.save(user);
    }

    /** update the entity with input object
     * 更新对象方法
     * @param user the input user
     */
    //@Transactional
    //@CachePut(key="#p0.id")
    public void update(User user){
        dao.update(user);
    }

    /** delete the entity by input id
     * 删除方法，通过id删除对象
     * @param id the input id
     */
    //@CacheEvict(key="#p0")
    public void deleteById(Integer id){
        dao.deleteById(id);
    }

    /** batch delete the entity by input ids
     * 批量删除方法，通过ids删除对象
     * @param ids the input ids
     */
    //@Transactional
    //@CacheEvict(allEntries = true)
    public void deleteByIds(Integer[] ids){
        dao.deleteByIds(ids);
    }

    /** query the total count by input select conditions
     * 通过输入的条件查询记录总数
     * @param map the input select conditions
     * @return total count
     */
    //@DataFilter(tableAlias = "B", owner = false)
    public int queryTotal(Map<String, Object> map){
        return dao.queryTotal(map);
    }

    public List<User> getUser(Map<String, Object> param){
        return dao.queryUser(param);
    }
    @Autowired
    private UserDao dao;

}
