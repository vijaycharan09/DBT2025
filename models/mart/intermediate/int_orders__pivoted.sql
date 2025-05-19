{%- set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%} 

with payments as 
( 
    select * from {{ ref('stg_stripe__paymentorders') }} ), 
    
final as ( 
    select orderid, 
    {% for payment_method in payment_methods -%} sum(case when paymentmethod = '{{ payment_method }}' then amount else 0 end) 
    as {{ payment_method }}_amount 
    {%- if not loop.last -%} , 
    {% endif -%} {%- endfor %} 
    from payments group by 1 ) 
    
select * from final
