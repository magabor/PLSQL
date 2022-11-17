DROP TABLE TEST_TABLE CASCADE CONSTRAINTS;

CREATE TABLE TEST_TABLE
(
  DISPLAY_TEXT  VARCHAR2(256 CHAR),
  DISPLAY_SEQ   NUMBER(10)
);

insert into test_table values ('FISH',1);
insert into test_table values ('CAT',2);
insert into test_table values ('LION',3);
insert into test_table values ('DOG',4);
commit;

select t.* from test_table t order by display_text;
select t.* from test_table t order by display_seq;

@"..\ReorderingTableByDisplaySeq.sql";

select t.* from test_table t order by display_text;
select t.* from test_table t order by display_seq;
