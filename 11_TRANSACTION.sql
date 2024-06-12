-- TRANSACTION
-- 데이터베이스에서 한 번에 수행되는 작업의 단위
-- 시작, 진행, 종료 단계를 가지며, 중간에 오류가 발생하면 롤백이 일어남.
-- 롤백 : 시작 이전 단계로 되돌리는 작업
-- MYSQL은 기본적으로 자동 커밋 설정이 되어 있다. (롤백이 안 된다는 걸 의미함)

-- autocommit 비활성화
set autocommit = 0;
set autocommit = OFF;

-- autocommit 활성화
set autocommit = 1;
set autocommit = ON;

select * from tbl_menu;

start transaction;
insert into tbl_menu values (null, '바나나국', 8500, 4, 'Y');
update tbl_menu set menu_name = '수정된 메뉴' where menu_code = 5;
delete from tbl_menu where menu_code = 9;

commit;
rollback;

# start transaction;
#
# commit;

