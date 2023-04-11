select 
* 
,current_date as snapshot_date
from {{ref('customers')}}