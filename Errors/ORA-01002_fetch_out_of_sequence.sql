set serveroutput on;
declare
    l_nodeid    NODE.NODE_ID%TYPE;
    t_ids       types.t_id_ass_array;
    cursor c1 is
        select NODE_ID
        from NODE
        where NODE_ID in (select ID from MAP_DBA.GTMP_IDENTIFIERS); -- comment for solving the error
--        where NODE_ID in (select column_value from table(t_ids) t); --uncomment for solving the error
begin
    t_ids(1) := 44271;
    t_ids(2) := 44272;
    
    execute immediate 'TRUNCATE TABLE MAP_DBA.GTMP_IDENTIFIERS';
    forall i in t_ids.first..t_ids.last
        insert into MAP_DBA.GTMP_IDENTIFIERS values (t_ids(i));
        
    open c1;
    loop   
        fetch c1 into l_nodeid;
        exit when c1%NOTFOUND;
        dbms_output.put_line(l_nodeid);
        execute immediate 'TRUNCATE TABLE MAP_DBA.GTMP_IDENTIFIERS';
    end loop;
    close c1;
    
    exception
    when others
    then
        dbms_output.put_line(SQLERRM);
        
end;