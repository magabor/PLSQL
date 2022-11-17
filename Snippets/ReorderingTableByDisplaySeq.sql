set serveroutput on;
declare
    l_seqno number(10);
    cursor seq_c is
        -- order table alphabetically by display_text
        select t.* from test_table t order by display_text
        for update;
begin
    for i in seq_c loop
        l_seqno := seq_c%rowcount;
        update test_table
            set display_seq = l_seqno
        where current of seq_c;
    end loop;
    
    commit;
end;