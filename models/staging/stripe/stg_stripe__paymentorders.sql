WITH 
source as (

    select * from {{ source('stripe', 'payment') }}

)
Select * FROM  source