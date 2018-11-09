## mysql 索引与数据量的限制

数据表：
```mysql

CREATE TABLE `td_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `targeting_id` int(11) NOT NULL DEFAULT '0'
  `tda_user_id` int(11) NOT NULL DEFAULT '0'
  `user_id` int(11) NOT NULL DEFAULT '0'
  `business_id` int(11) NOT NULL DEFAULT '0'
  `channel_id` int(11) NOT NULL DEFAULT '0'
  `spot_id` bigint(20) NOT NULL DEFAULT '0'
  `medium_id` int(11) NOT NULL DEFAULT '0'
  `plan_id` int(11) NOT NULL DEFAULT '0'
  `campaign_id` int(11) NOT NULL DEFAULT '0'
  `creative_id` int(11) NOT NULL DEFAULT '0'
  `landing_page_id` int(11) NOT NULL DEFAULT '0'
  `date` int(10) unsigned NOT NULL DEFAULT '0'
  `hour` int(10) unsigned NOT NULL DEFAULT '0'
  `ts` bigint(20) unsigned NOT NULL DEFAULT '0'
  `create_time` int(11) unsigned NOT NULL DEFAULT '0'
  `cost` bigint(20) NOT NULL DEFAULT '0'
  `impressions` int(11) NOT NULL DEFAULT '0'
  `clicks` int(11) NOT NULL DEFAULT '0'
  `b_page_views` int(11) NOT NULL DEFAULT '0'
  `b_visitors` int(11) NOT NULL DEFAULT '0'
  `l_visitors` int(11) NOT NULL DEFAULT '0'
  `dim_0` bigint(20) NOT NULL DEFAULT '0',
  ...
  `metric_0` int(11) NOT NULL DEFAULT '0',
  ...
  `adx_metric_0` int(11) NOT NULL DEFAULT '0',
  ...
  PRIMARY KEY (`id`),
  INDEX `plan` (`date`,`plan_id`,`campaign_id`,`creative_id`,`landing_page_id`),
  INDEX `campaign` (`date`,`campaign_id`,`creative_id`,`landing_page_id`),
  INDEX `creative` (`date`,`creative_id`,`landing_page_id`),
  INDEX `landing_page` (`date`,`landing_page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

数据特点： 数据重复性高，查询的where字段没有全部建索引


数据量在百万接近千万级时，查询很慢。当查询date大于一天时，select不使用索引。
可能的原因是：
> 经过不断的调整查询条件中的时间跨度，同时一直强制使用索引，查看该索引效率，最后发现当explain的结果中rows大于全表数据的20%时，mysql就不用索引了。
> 关于这一点，可能跟mysql查询优化器的一个设置有关，优化器成本模型中的row_evaluate_cost参数，在mysql.server_cost表里，默认是0.2，表示使用索引时扫描的行数大于全表扫描行数的20%时，优化器会考虑放弃使用该索引。
> 原文：https://blog.csdn.net/lkforce/article/details/79148002 
