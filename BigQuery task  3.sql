
with user_session_id_info as (select user_pseudo_id,event_name,
user_pseudo_id ||
(select value.int_value from unnest(event_params) where key= 'ga_session_id') as user_session_id,
safe.regexp_extract((select value.string_value from unnest(event_params) where key='page_location'),r'https?://[^/]+([^?]*)') as page_path 
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`  
where(_table_suffix >='20200101' and _table_suffix <='20201231') and event_name in ('session_start','purchase')),
session_summary as (select user_session_id,
max(if(event_name='session_start',page_path,null)) as first_page_path,
max(if(event_name='session_start',1,0)) as session_started,
max(if(event_name='purchase',1,0)) as completed_purchase 
from user_session_id_info
group by 1)
select first_page_path as page_path,
countif(session_started=1) as unique_sesions,
countif(completed_purchase=1) as purchases,
round(safe_divide(countif(completed_purchase=1),countif(session_started=1)),4) as conversion_rate
from session_summary
where first_page_path is not null
group by first_page_path
order by conversion_rate desc