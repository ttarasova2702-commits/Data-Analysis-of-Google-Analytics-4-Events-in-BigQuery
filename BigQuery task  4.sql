
with user_session_id_info as (select
user_pseudo_id ||
(select value.int_value from unnest(event_params) where key= 'ga_session_id') as user_session_id,
sum(coalesce((select value.int_value from unnest(event_params) where key= 'engagement_time_msec'),0)) as user_eng_time,
max(coalesce(
(select value.int_value from unnest(event_params) where key= 'session_engaged') ,
safe_cast((select value.string_value from unnest(event_params) where key= 'session_engaged') as integer),0)) as session_engaged,
max(case when event_name='purchase' then 1 else 0 end) as purchase_check 
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by 1)
select
corr(session_engaged, purchase_check)as ccorr_engaged_purchase,
corr(user_eng_time, purchase_check)as corr_eng_time_purchase
from user_session_id_info;