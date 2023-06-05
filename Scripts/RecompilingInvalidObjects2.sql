BEGIN
    dbms_utility.compile_schema(
        schema         => user ,
        compile_all    =>FALSE,
        reuse_settings =>TRUE
    );

END;
