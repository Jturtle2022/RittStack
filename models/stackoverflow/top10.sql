with base  as (
   with ans_top as(Select id, 
                          answer_count,
                          comment_count,
                          favorite_count,
                          tags                           
                          from `rittman-stovflw.Rittman_dbt.posts_answer_dim`                           
                           where favorite_count >=1000
                           and comment_count is not null                           
                           and tags is not null
                           and view_count is not null
                           order by answer_count asc
                           limit 100),

        time_d as (select id, 
                          creation_date, 
                          last_activity_date 
                          from `rittman-stovflw.Rittman_dbt.posts_time_dim`),
                    
        content as (Select CD.id,
                           CD.title,
                           BC.Body,
                           CD.score
                           from `rittman-stovflw.Rittman_dbt.posts_content_dim` as CD
                           Inner join
                           `rittman-stovflw.Rittman_dbt.bodycleansed` as BC on BC.id = CD.id),

        owner as (select id,
                         owner_user_id,
                         owner_display_name
                         from `rittman-stovflw.Rittman_dbt.posts_owner_dim`)

      
                        


Select 
      
      ans_top.id, 
      content.title,
      content.body,
      ans_top.answer_count,
      ans_top.comment_count,
      ans_top.favorite_count,
      ans_top.view_count,
      cast(time_d.creation_date as date) date_created,
      cast(time_d.last_activity_date as date) last_activity_date,
      owner.owner_user_id,
      split(ans_top.tags,"|") as subject_tags
      
      from ans_top

      Inner join time_d on time_d.id = ans_top.id

      Inner join content on content.id = ans_top.id

      Inner join owner on owner.id = ans_top.id
      )

Select distinct id, 
       title,
       body,
       answer_count,
       comment_count,
       favorite_count,
       view_count
       date_created,
       base.last_activity_date,
       owner_user_id,
       subject_tag

      from base,

      unnest (subject_tags) as subject_tag

      order by answer_count asc

      limit 10
