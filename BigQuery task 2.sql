
with user_session_id_info as
(select date(timestamp_micros(event_timestamp)) as event_date, event_name,traffic_source.source as source,traffic_source.medium as medium,traffic_source.name as campaign,user_pseudo_id ||
(select value.int_value from unnest(event_params) where key= 'ga_session_id') as user_session_id
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where event_name in ('session_start','add_to_cart','begin_checkout','purchase')),
user_count as
(select event_date,source,medium,campaign, 
count(distinct case when event_name='add_to_cart' then user_session_id end) as count_add_to_cart,
count(distinct case when event_name='begin_checkout' then user_session_id end) as count_begin_checkout,
count(distinct case when event_name='purchase' then user_session_id end) as count_purchase,
count(distinct case when event_name='session_start' then user_session_id end) as count_session_start
from user_session_id_info
group by 1,2,3,4)
select 
event_date,source,medium,campaign,
round(count_add_to_cart/count_session_start,3) as visit_to_cart,
round(count_begin_checkout/count_session_start,3) as visit_to_checkout,
round(count_purchase/count_session_start,3) as visit_to_purchase
from user_count