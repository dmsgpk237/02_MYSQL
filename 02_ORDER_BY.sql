-- ORDER BY
-- select 문과 함께 사용하며
-- 결과 집합을 특정 열이나 값에 따라 '정렬'할 때 사용된다.

select
    menu_code,
    menu_name,
    menu_price
from tbl_menu
order by
--    menu_price desc; -- desc는 내림차순으로 정렬
--    menu_price asc; -- asc는 오름차순 정렬
--    menu_name; -- 아무 것도 안 써주면 오름차순으로 정렬됨 (default)
    menu_price;

-- 컬럼에 따라 여러 번 정렬 할 수 있다.
-- 메뉴 price를 기준으로 내림차순 정렬을 하고,
-- 같은 가격이 있다면, menu_name에 따라 오름차순 정렬

select
    menu_code,
    menu_name,
    menu_price
from tbl_menu
order by
    menu_price desc,
    menu_name;

-- 컬럼을 연산해서, 연산 결과와 함께 정렬을 할 수 있다.
-- order by 절을 이용해서 연산 결과와 함께 정렬

select
    menu_code,
    menu_price,
    menu_name,
    menu_code * menu_price as multiple
from
    tbl_menu
order by
    multiple desc;

/*
FIELD('비교할 값', '비교대상', '비교대상', ...)
-- 첫 번째 인자가 두 번째 인자 이후의 값들과 비교해서 일치하면
-- 해당 위치의 값을 보여준다.
*/

select field('A', 'B', 'C', 'A'); -- 인덱스 값이 나온다.
-- 일치하는 위치값을 반환해준다. 'A'가 있는 위치가 인덱스 3번이기 때문에 실행하면 3이 나오는 것.

select field('B', 'B', 'A');

-- 데이터베이스에 들어있는 데이터를 비교할 수 있다.
select
    field(orderable_status, 'N', 'Y')
from tbl_menu;

-- 이건 내가 궁금해서 이름이랑 오더러블 추가해서 출력한 것임.
select
    menu_name,
    orderable_status,
    field(orderable_status, 'N', 'Y')
from tbl_menu;

-- order by, field 같이 써서 사용하기

select
    menu_name,
    orderable_status
from tbl_menu
order by field(orderable_status, 'N', 'Y');
-- orderable을 select 안에 넣었다면 인덱스 값이 나타났겠지만,
-- orderable을 order by에 넣었기 때문에 'N', 'Y' 둘 중 하나로 나타나는 것.

-- null 값이 있는 컬럼에 대한 정렬
select
    category_code,
    category_name,
    ref_category_code
from tbl_category
order by
    ref_category_code; -- 오름차순 정렬했을 때 null이 상단으로 올라온다.

-- null 값 위치에 따라 정렬할 때,
-- asc : 오름차순 정렬시 null이 마지막으로 위치된다. (default)
-- desc : 내림차순 정렬시 null이 첫 번째 번호부터 위치된다.

select
    category_code,
    category_name,
    ref_category_code
from
    tbl_category
order by
    ref_category_code is null desc;

-- 한 개를 조회해서 두 번 정렬 할 때
select
    category_code,
    category_name,
    ref_category_code
from tbl_category
order by
    ref_category_code is null desc, -- null 값의 위치를 먼저 정하고
    ref_category_code asc; -- ref_category_code를 오름차순으로 정렬

