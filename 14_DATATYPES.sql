-- CAST FUNCTIONS

-- 명시적 형변환
-- CAST ([표현형식] as 데이터형식 [(길이)])
-- CONVERT ([표현형식], [데이터형식] [(길이)])
-- 데이터 형식으로 가능한 것
-- BINARY, CHAR, DATETIME, DECIMAL, JSON, SIGNED INTEGER
-- TIME, UNSIGNED INTEGER

-- tbl_menu 전체 가격 평균
select avg(menu_price)
from
    tbl_menu;
-- 평균 가격은 실수로 나왔음.

select cast(avg(menu_price) as signed integer) as '평균 메뉴 가격'
from tbl_menu;
-- 소수점 아래 자리를 잘라서 정수형 10881 이 나왔음.

select convert(avg(menu_price), signed integer) as '평균 메뉴 가격'
from tbl_menu;
-- 소수점 아래 자리를 잘라서 정수형 10881 이 나왔음.

-- date 형 cast
select cast('2024$06$13' as date);

-- 원하는 걸 넣어 형식을 바꿔줄 수 있음.
select cast('2024$06$13' as date);
select cast('2024/4/30' as date);
select cast('2024%5%30' as date);
select cast('2024@7@30' as date);

-- 카테고리별 메뉴 가격 합계 구하기
-- 0000원
select concat(cast(menu_price as char(5)), '원')
from tbl_menu;

select category_code, menu_name, concat(cast(sum(menu_price) as char(5)), '원') -- 메뉴의 합계를 '원'과 합치기
from tbl_menu
group by category_code, menu_name
order by category_code;

-- 암시적 형변환
select '1' + '2'; -- 12가 아니라 정수형으로 연산되어 3이 출력됨
select concat(menu_price, '원') -- menu_price가 문자로 변환됨
from tbl_menu;

-- true 1, false 0
select 3 > 'MAY'; -- 문자가 0으로 변환됨
select 5 > '6MAY'; -- 문자에서 첫 번째로 나오는 숫자는 정수로 변환됨
select 5 > 'M6AY'; -- 숫자가 뒤에 나오면 문자로 인식됨
select '2024-6-13'; -- 날짜형으로 바뀔 수 있는 문자 -> date형으로 변환됨




