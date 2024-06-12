-- LIMIT
-- select 문의 결과 집합에서, 반환할 행의 수를 제한할 때 사용된다.

/*
LIMIT
SELECT
    [columnName]
FORM
    [tableName]
[LIMIT] [OFFSET] [ROWCOUNT]

OFFSET : 시작할 행의 번호(인덱스 체계)
ROW_COUNT : 이후 행부터 반환 받을 행의 개수
*/

select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by menu_code desc;


-- 상위 다섯 줄의 행만 조회
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_code desc
limit 5;


-- 2번 행부터 5번 행까지 조회
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_code desc
limit 1, 4; -- 1부터 4개를 출력


/*
tbl_menu 테이블에서
menu_name 과 menu_price
가장 저렴한 순으로 3가지를 보여주세요
*/
    select
        menu_name,
        menu_code,
        menu_price
    from
        tbl_menu
    order by menu_price asc
    limit 3;