{% test value(model, column_name) %}

    select * from 
    {{ model }}
    where not {{column_name}} >= 0 

 {% endtest %}