select id, 
       accepted_answer_id,
       last_editor_user_id,
       owner_user_id,
       parent_id,
       post_type_id,
       tags
         
        from bigquery-public-data.stackoverflow.stackoverflow_posts