{% snapshot favorite_ice_cream_flavors %}

{{
    config(
        target_schema='dbt_erik_snapshots',
        unique_key='github_username',
        strategy='check',
        updated_at='updated_at',
        check_cols =['updated_at']
    )

}}

select * from {{ source('advanced_dbt_examples','favorite_ice_cream_flavors')}}

{% endsnapshot %}
