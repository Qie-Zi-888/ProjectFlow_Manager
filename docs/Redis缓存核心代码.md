# Redis缓存核心实现代码

## 1. Redis配置类

```java
/**
 * Redis配置类
 * 配置RedisTemplate的序列化方式和缓存策略
 */
@Configuration
@EnableCaching
public class RedisConfig extends CachingConfigurerSupport
{
    @Bean
    @SuppressWarnings(value = { "unchecked", "rawtypes" })
    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory connectionFactory)
    {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        FastJson2JsonRedisSerializer serializer = new FastJson2JsonRedisSerializer(Object.class);

        // 使用StringRedisSerializer来序列化和反序列化redis的key值
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(serializer);

        // Hash的key也采用StringRedisSerializer的序列化方式
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(serializer);

        template.afterPropertiesSet();
        return template;
    }
}
```

## 2. Redis缓存工具类

```java
/**
 * Spring Redis 工具类
 * 提供统一的缓存操作接口
 */
@Component
public class RedisCache
{
    @Autowired
    public RedisTemplate redisTemplate;

    /**
     * 缓存基本的对象，Integer、String、实体类等
     *
     * @param key 缓存的键值
     * @param value 缓存的值
     */
    public <T> void setCacheObject(final String key, final T value)
    {
        redisTemplate.opsForValue().set(key, value);
    }

    /**
     * 缓存对象并设置过期时间
     *
     * @param key 缓存的键值
     * @param value 缓存的值
     * @param timeout 超时时间
     * @param timeUnit 时间单位
     */
    public <T> void setCacheObject(final String key, final T value, 
                                    final Integer timeout, final TimeUnit timeUnit)
    {
        redisTemplate.opsForValue().set(key, value, timeout, timeUnit);
    }

    /**
     * 获得缓存的基本对象
     *
     * @param key 缓存键值
     * @return 缓存键值对应的数据
     */
    public <T> T getCacheObject(final String key)
    {
        ValueOperations<String, T> operation = redisTemplate.opsForValue();
        return operation.get(key);
    }

    /**
     * 删除单个对象
     *
     * @param key 缓存键值
     */
    public boolean deleteObject(final String key)
    {
        return redisTemplate.delete(key);
    }

    /**
     * 删除集合对象
     *
     * @param collection 多个对象
     */
    public boolean deleteObject(final Collection collection)
    {
        return redisTemplate.delete(collection) > 0;
    }

    /**
     * 判断key是否存在
     *
     * @param key 键
     * @return true 存在 false不存在
     */
    public Boolean hasKey(String key)
    {
        return redisTemplate.hasKey(key);
    }

    /**
     * 设置有效时间
     *
     * @param key Redis键
     * @param timeout 超时时间
     * @param unit 时间单位
     * @return true=设置成功；false=设置失败
     */
    public boolean expire(final String key, final long timeout, final TimeUnit unit)
    {
        return redisTemplate.expire(key, timeout, unit);
    }

    /**
     * 获得缓存的基本对象列表
     *
     * @param pattern 字符串前缀
     * @return 对象列表
     */
    public Collection<String> keys(final String pattern)
    {
        return redisTemplate.keys(pattern);
    }
}
```

## 3. 字典缓存实现（典型应用场景）

```java
/**
 * 字典工具类 - 基于Redis实现字典数据缓存
 */
public class DictUtils
{
    /**
     * 设置字典缓存
     * 
     * @param key 字典类型键
     * @param dictDatas 字典数据列表
     */
    public static void setDictCache(String key, List<SysDictData> dictDatas)
    {
        SpringUtils.getBean(RedisCache.class).setCacheObject(getCacheKey(key), dictDatas);
    }

    /**
     * 获取字典缓存
     * 
     * @param key 字典类型键
     * @return 字典数据列表
     */
    public static List<SysDictData> getDictCache(String key)
    {
        JSONArray arrayCache = SpringUtils.getBean(RedisCache.class)
            .getCacheObject(getCacheKey(key));
        if (StringUtils.isNotNull(arrayCache))
        {
            return arrayCache.toList(SysDictData.class);
        }
        return null;
    }

    /**
     * 根据字典类型和字典值获取字典标签
     * 
     * @param dictType 字典类型
     * @param dictValue 字典值
     * @return 字典标签
     */
    public static String getDictLabel(String dictType, String dictValue)
    {
        List<SysDictData> datas = getDictCache(dictType);
        if (StringUtils.isNull(datas) || StringUtils.isEmpty(dictValue))
        {
            return StringUtils.EMPTY;
        }
        
        // 构建字典映射 Map<value, label>
        Map<String, String> dictMap = datas.stream()
            .collect(HashMap::new, 
                (map, dict) -> map.put(dict.getDictValue(), dict.getDictLabel()), 
                Map::putAll);
        
        return dictMap.getOrDefault(dictValue, StringUtils.EMPTY);
    }

    /**
     * 删除指定字典缓存
     * 
     * @param key 字典键
     */
    public static void removeDictCache(String key)
    {
        SpringUtils.getBean(RedisCache.class).deleteObject(getCacheKey(key));
    }

    /**
     * 清空所有字典缓存
     */
    public static void clearDictCache()
    {
        Collection<String> keys = SpringUtils.getBean(RedisCache.class)
            .keys(CacheConstants.SYS_DICT_KEY + "*");
        SpringUtils.getBean(RedisCache.class).deleteObject(keys);
    }

    /**
     * 获取缓存键
     * 
     * @param configKey 参数键
     * @return 缓存键key
     */
    public static String getCacheKey(String configKey)
    {
        return CacheConstants.SYS_DICT_KEY + configKey;
    }
}
```

## 4. 字典服务层缓存应用

```java
/**
 * 字典业务层处理 - 展示缓存的完整生命周期管理
 */
@Service
public class SysDictTypeServiceImpl implements ISysDictTypeService
{
    @Autowired
    private SysDictTypeMapper dictTypeMapper;

    @Autowired
    private SysDictDataMapper dictDataMapper;

    /**
     * 项目启动时，初始化字典到缓存
     */
    @PostConstruct
    public void init()
    {
        loadingDictCache();
    }

    /**
     * 根据字典类型查询字典数据（优先从缓存读取）
     * 
     * @param dictType 字典类型
     * @return 字典数据集合信息
     */
    @Override
    public List<SysDictData> selectDictDataByType(String dictType)
    {
        // 1. 先从Redis缓存中获取
        List<SysDictData> dictDatas = DictUtils.getDictCache(dictType);
        if (StringUtils.isNotEmpty(dictDatas))
        {
            return dictDatas;
        }
        
        // 2. 缓存未命中，从数据库查询
        dictDatas = dictDataMapper.selectDictDataByType(dictType);
        if (StringUtils.isNotEmpty(dictDatas))
        {
            // 3. 将查询结果写入缓存
            DictUtils.setDictCache(dictType, dictDatas);
            return dictDatas;
        }
        return null;
    }

    /**
     * 加载字典缓存数据（系统启动时调用）
     */
    @Override
    public void loadingDictCache()
    {
        SysDictData dictData = new SysDictData();
        dictData.setStatus("0");
        
        // 查询所有启用的字典数据
        Map<String, List<SysDictData>> dictDataMap = 
            dictDataMapper.selectDictDataList(dictData).stream()
                .collect(Collectors.groupingBy(SysDictData::getDictType));
        
        // 批量写入Redis缓存
        for (Map.Entry<String, List<SysDictData>> entry : dictDataMap.entrySet())
        {
            DictUtils.setDictCache(entry.getKey(), 
                entry.getValue().stream()
                    .sorted(Comparator.comparing(SysDictData::getDictSort))
                    .collect(Collectors.toList()));
        }
    }

    /**
     * 修改保存字典类型信息（缓存更新策略）
     * 
     * @param dict 字典类型信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateDictType(SysDictType dict)
    {
        SysDictType oldDict = dictTypeMapper.selectDictTypeById(dict.getDictId());
        
        // 更新关联的字典数据类型字段
        dictDataMapper.updateDictDataType(oldDict.getDictType(), dict.getDictType());
        
        int row = dictTypeMapper.updateDictType(dict);
        if (row > 0)
        {
            // 数据库更新成功后，同步更新缓存
            List<SysDictData> dictDatas = 
                dictDataMapper.selectDictDataByType(dict.getDictType());
            DictUtils.setDictCache(dict.getDictType(), dictDatas);
        }
        return row;
    }

    /**
     * 删除字典类型（缓存清除策略）
     * 
     * @param dictIds 需要删除的字典ID
     */
    @Override
    public void deleteDictTypeByIds(Long[] dictIds)
    {
        for (Long dictId : dictIds)
        {
            SysDictType dictType = selectDictTypeById(dictId);
            
            // 检查是否有字典数据引用
            if (dictDataMapper.countDictDataByType(dictType.getDictType()) > 0)
            {
                throw new ServiceException(
                    String.format("%1$s已分配,不能删除", dictType.getDictName()));
            }
            
            // 删除数据库记录
            dictTypeMapper.deleteDictTypeById(dictId);
            
            // 清除对应的Redis缓存
            DictUtils.removeDictCache(dictType.getDictType());
        }
    }

    /**
     * 重置字典缓存数据
     */
    @Override
    public void resetDictCache()
    {
        clearDictCache();
        loadingDictCache();
    }
}
```

## 5. 参数配置缓存实现

```java
/**
 * 参数配置服务实现 - 另一种缓存应用场景
 */
@Service
public class SysConfigServiceImpl implements ISysConfigService
{
    @Autowired
    private RedisCache redisCache;
    
    @Autowired
    private SysConfigMapper configMapper;

    /**
     * 根据键名查询参数配置信息（带缓存）
     *
     * @param configKey 参数键名
     * @return 参数键值
     */
    @Override
    public String selectConfigByKey(String configKey)
    {
        // 1. 尝试从Redis缓存获取
        String configValue = Convert.toStr(
            redisCache.getCacheObject(getCacheKey(configKey)));
        
        if (StringUtils.isNotEmpty(configValue))
        {
            return configValue;
        }
        
        // 2. 缓存未命中，查询数据库
        SysConfig config = new SysConfig();
        config.setConfigKey(configKey);
        SysConfig retConfig = configMapper.selectConfig(config);
        
        if (StringUtils.isNotNull(retConfig))
        {
            // 3. 将查询结果存入缓存
            redisCache.setCacheObject(getCacheKey(configKey), retConfig.getConfigValue());
            return retConfig.getConfigValue();
        }
        
        return StringUtils.EMPTY;
    }

    /**
     * 新增参数配置（写入缓存）
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public int insertConfig(SysConfig config)
    {
        int row = configMapper.insertConfig(config);
        if (row > 0)
        {
            // 数据库插入成功后，同步写入缓存
            redisCache.setCacheObject(
                getCacheKey(config.getConfigKey()), 
                config.getConfigValue());
        }
        return row;
    }

    /**
     * 修改参数配置（更新缓存）
     *
     * @param config 参数配置信息
     * @return 结果
     */
    @Override
    public int updateConfig(SysConfig config)
    {
        SysConfig temp = configMapper.selectConfigById(config.getConfigId());
        
        // 如果键名发生变化，删除旧缓存
        if (!StringUtils.equals(temp.getConfigKey(), config.getConfigKey()))
        {
            redisCache.deleteObject(getCacheKey(temp.getConfigKey()));
        }

        int row = configMapper.updateConfig(config);
        if (row > 0)
        {
            // 更新缓存
            redisCache.setCacheObject(
                getCacheKey(config.getConfigKey()), 
                config.getConfigValue());
        }
        return row;
    }

    /**
     * 清空参数缓存数据
     */
    @Override
    public void clearConfigCache()
    {
        // 使用通配符删除所有参数配置缓存
        Collection<String> keys = redisCache.keys(
            CacheConstants.SYS_CONFIG_KEY + "*");
        redisCache.deleteObject(keys);
    }

    /**
     * 设置cache key
     *
     * @param configKey 参数键
     * @return 缓存键key
     */
    private String getCacheKey(String configKey)
    {
        return CacheConstants.SYS_CONFIG_KEY + configKey;
    }
}
```

## 6. 验证码缓存实现（带过期时间）

```java
/**
 * 验证码Controller - 展示带过期时间的缓存应用
 */
@RestController
public class CaptchaController
{
    @Autowired
    private RedisCache redisCache;

    /**
     * 生成验证码
     */
    @GetMapping("/captchaImage")
    public AjaxResult getCode(HttpServletResponse response)
    {
        // 生成随机UUID作为验证码标识
        String uuid = IdUtils.simpleUUID();
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + uuid;

        // 生成验证码图片和验证码文本
        String capStr = null, code = null;
        BufferedImage image = null;
        
        // 生成算术验证码
        capStr = arithmeticGenerator.generateCode();
        code = arithmeticGenerator.getText(capStr);
        image = arithmeticGenerator.createImage(capStr);

        // 将验证码存入Redis，设置5分钟过期时间
        redisCache.setCacheObject(verifyKey, code, 
            Constants.CAPTCHA_EXPIRATION, TimeUnit.MINUTES);

        // 返回验证码图片Base64编码和UUID
        AjaxResult ajax = AjaxResult.success();
        ajax.put("uuid", uuid);
        ajax.put("img", Base64.encode(os.toByteArray()));
        return ajax;
    }

    /**
     * 验证验证码
     */
    public void validateCaptcha(String username, String code, String uuid)
    {
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + uuid;
        
        // 从Redis获取验证码
        String captcha = redisCache.getCacheObject(verifyKey);
        
        // 验证后立即删除，防止重复使用
        redisCache.deleteObject(verifyKey);
        
        if (captcha == null)
        {
            throw new CaptchaExpireException();
        }
        
        if (!code.equalsIgnoreCase(captcha))
        {
            throw new CaptchaException();
        }
    }
}
```

## 7. 防重复提交缓存实现

```java
/**
 * 防重提交拦截器 - 基于Redis实现请求去重
 */
@Component
public class SameUrlDataInterceptor extends RepeatSubmitInterceptor
{
    @Autowired
    private RedisCache redisCache;

    @Override
    public boolean isRepeatSubmit(HttpServletRequest request, RepeatSubmit annotation)
    {
        // 获取请求参数和URL
        String nowParams = JsonUtils.toJsonString(request.getParameterMap());
        String url = request.getRequestURI();
        
        // 构建缓存键
        String cacheRepeatKey = CacheConstants.REPEAT_SUBMIT_KEY + 
            request.getSession().getId() + url;

        Map<String, Object> nowDataMap = new HashMap<String, Object>();
        nowDataMap.put(REPEAT_PARAMS, nowParams);
        nowDataMap.put(REPEAT_TIME, System.currentTimeMillis());

        // 从Redis获取上一次的请求数据
        Object sessionObj = redisCache.getCacheObject(cacheRepeatKey);
        if (sessionObj != null)
        {
            Map<String, Object> sessionMap = (Map<String, Object>) sessionObj;
            if (sessionMap.containsKey(url))
            {
                Map<String, Object> preDataMap = 
                    (Map<String, Object>) sessionMap.get(url);
                
                // 比较参数和时间间隔
                if (compareParams(nowDataMap, preDataMap) && 
                    compareTime(nowDataMap, preDataMap, annotation.interval()))
                {
                    return true; // 重复提交
                }
            }
        }
        
        // 将本次请求数据存入Redis，设置过期时间
        Map<String, Object> cacheMap = new HashMap<String, Object>();
        cacheMap.put(url, nowDataMap);
        redisCache.setCacheObject(cacheRepeatKey, cacheMap, 
            annotation.interval(), TimeUnit.MILLISECONDS);
        
        return false; // 非重复提交
    }
}
```

## 8. 缓存常量定义

```java
/**
 * 缓存的key常量
 */
public class CacheConstants
{
    /**
     * 登录用户 redis key
     */
    public static final String LOGIN_TOKEN_KEY = "login_tokens:";

    /**
     * 验证码 redis key
     */
    public static final String CAPTCHA_CODE_KEY = "captcha_codes:";

    /**
     * 参数管理 cache key
     */
    public static final String SYS_CONFIG_KEY = "sys_config:";

    /**
     * 字典管理 cache key
     */
    public static final String SYS_DICT_KEY = "sys_dict:";

    /**
     * 防重提交 redis key
     */
    public static final String REPEAT_SUBMIT_KEY = "repeat_submit:";

    /**
     * 限流 redis key
     */
    public static final String RATE_LIMIT_KEY = "rate_limit:";

    /**
     * 登录账户密码错误次数 redis key
     */
    public static final String PWD_ERR_CNT_KEY = "pwd_err_cnt:";
}
```

## 代码说明

以上代码展示了Redis缓存在ProjectFlow Manager系统中的核心应用场景：

1. **基础封装**：`RedisCache`工具类提供了统一的缓存操作接口
2. **字典缓存**：系统启动时预加载，查询时优先读缓存，修改时同步更新
3. **参数缓存**：配置项的缓存读写和清理机制
4. **验证码缓存**：带过期时间的临时数据存储
5. **防重提交**：基于Redis的请求去重机制
6. **缓存策略**：包括缓存穿透保护、缓存更新、缓存清除等完整生命周期管理

这些代码体现了Redis缓存在提升系统性能、减少数据库压力方面的重要作用。
