with  a as 

(select distinct fct.id,
       fct.tags,
       cast(tme.last_activity_date as date) last_activity_date,
       cast(tme.creation_date as date) created_date,
       ans.answer_count

       from 
       
      `rittman-stovflw.Rittman_dbt.posts_fact`as fct

       inner join

      `rittman-stovflw.Rittman_dbt.posts_time_dim` as tme on fct.id = tme.id

       inner join 

      `rittman-stovflw.Rittman_dbt.posts_answer_dim` as ans on ans.id = fct.id

  )

  Select * from a