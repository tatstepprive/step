select * from user_tables where table_name like 'ORD%';
CREATE TABLE orders
( order_id number(5),
  quantity number(4),
  cost_per_item number(6,2),
  total_cost number(8,2)
);
commit;

CREATE TABLE orders_child
( order_child_id number(5),
  order_id number(4)
);
commit;

alter table orders add CONSTRAINT order_pk PRIMARY KEY (order_id);
commit;

alter table orders_child add constraint orders_child_order_fk foreign key(order_id) references orders (order_id);



CREATE TABLE orders_audit
( order_id number(5),
  quantity number(4),
  cost_per_item number(6,2),
  total_cost number(8,2),
  action_type varchar(6),
  action_date date,
  action_by varchar2(10)
);
commit;

---------------
--trigger creation (monitor deleted values)
CREATE OR REPLACE TRIGGER orders_before_delete
BEFORE DELETE
   ON orders
   FOR EACH ROW

DECLARE
   v_username varchar2(10);

BEGIN

   -- Find username of person performing the DELETE on the table
   SELECT user INTO v_username
   FROM dual;

   -- Insert record into audit table
   INSERT INTO orders_audit
   ( order_id,
     quantity,
     cost_per_item,
     total_cost,
     action_type,
     action_date,
     action_by )
   VALUES
   ( :old.order_id,
     :old.quantity,
     :old.cost_per_item,
     :old.total_cost,
      'DELETE',
      sysdate,
      v_username );
  EXCEPTION
   WHEN others then
 INSERT INTO orders_audit
   ( order_id,
     quantity,
     cost_per_item,
     total_cost,
     action_type,
     action_date,
     action_by )
   VALUES
   ( :old.order_id,
     :old.quantity,
     :old.cost_per_item,
     :old.total_cost,
      'ERR_DEL',
      sysdate,
      v_username );
    RAISE;
   

END;
/
commit;
--end trigger creation
-----------------------------------------
insert into orders values(2,3,4,5);
commit;

insert into orders_child values(1,1);
commit;

delete from orders where order_id=2;
select * from orders;

select * from orders_audit;

select * from orders_child;

delete from orders where order_id=1;
--output ORA-02292: integrity constraint (HR.ORDERS_CHILD_ORDER_FK) violated - child record found 
--trigger will not capture the error on delete and no rows in audit table on delete with error, because nothig is deleted
------------
--to trace delete with errors use show bind variables when level set to 4
ALTER SYSTEM SET EVENTS '2292 trace name errorstack level 4';
delete from orders where order_id=1;
--cd to trace log directory
--cd $ORACLE_BASE/diag/rdbms/<sid>/<sid>/trace
--grep 2292
------------
