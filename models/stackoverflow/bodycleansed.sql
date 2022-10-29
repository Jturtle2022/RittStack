WITH SPECBOD as(
            (With base as (SELECT 
            id,
            REGEXP_REPLACE 
            (body, r"<>", "") as body
            FROM `rittman-stovflw.Rittman_dbt.posts_content_dim`)

            Select 
            id,
            REGEXP_REPLACE 
            (body, r"<P>", "") as body

            From base))

            Select id,
            REGEXP_REPLACE 
            (body, r"<a href>", "") as body
            From SPECBOD