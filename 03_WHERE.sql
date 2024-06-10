-- WHERE
-- 특정 조건에 맞는 레코드(데이터)만을 선택하는데 사용된다.
-- 방법이 다양하다.

-- 같음(=) 연산자를 활용한 WHERE

select -- 보여줘
       menu_name,
       menu_price,
       orderable_status
from -- 여기에 있는
     tbl_menu
where -- 이 조건에 맞는
      orderable_status = 'Y';

/*
tbl_menu 테이블에 있는 컬럼
menu_name, menu_price, orderable_status를 조회할 건데,
단, menu_price가 13000인 데이터만 조회해줘.
*/

select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where menu_price = 13000;

-- select에 담지 않아도, 다른 컬럼의 속성으로 제한 할 수 있다.

select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where orderable_status = 'Y';

-- 같지 않음(!=, <>) 연산자를 사용하는 WHERE
-- ColumnA ! = B 컬럼에 있는 내용 중 B와 같지 않은 데이터만 보여주기
-- ColumnA ! <> B 컬럼에 있는 내용 중 B와 같지 않은 데이터만 보여주기

select
    menu_code,
    menu_name,
    orderable_status
from
    tbl_menu
where orderable_status != 'Y';


select
    menu_code,
    menu_name,
    orderable_status
from
    tbl_menu
where orderable_status <> 'Y';

-- 대소비교 연산자 (>, >=, <, <=)를 사용하는 WHERE

select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price <= 20000;

-- AND 연산자와 함께 WHERE 절 사용
-- 둘 중에 하나라도 false 면 false, 둘 다 true 여야지 true

/*
true = 1; // false = 0
null = 값이 없다.
*/

-- true 되는 조건
select 1 and 1; -- true랑 true랑 AND 연산자를 하면 -> true가 나온다.

-- false 되는 조건
select 1 and 0, 0 and 0, 0 and null; -- true랑 false랑 AND 연산자를 하면 -> false가 나온다.

-- null 되는 조건
select 1 and null, null and null; -- 두 조건 다 null이 나온다.

-- WHERE에서 AND 조건은 두 조건을 모두 충족시키는 것을 조회한다.
select
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where orderable_status = 'Y' and -- 주문 가능 여부가 'Y'이면서
      category_code = 10; -- 카테고리 코드가 10인 데이터만 출력

/*
tbl_menu 테이블에 있는 menu_name, menu_price, category_code,
orderable_status를 조회하는데,
주문 가능여부가 Y이고, 가격이 10000원 이하인 데이터 조회
*/

select
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
    tbl_menu
where orderable_status = 'Y' and
      menu_price <= 10000;

-- OR 연산자와 함께 WHERE 절 사용

-- true가 되는 조건
select 1 or 1, 0 or 1, 1 or null; -- 하나만 1이어도 가능하다.

-- false가 되는 조건
select 0 or 0; -- 둘 다 0이어야 한다.

-- null이 되는 조건
select 0 or null, null or null;

-- WHERE 에서의 OR 조건
-- 두 조건 중 하나라도 중복하면 조회한다.

select
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu
where
    orderable_status = 'y' or
    category_code = 12;

/*
AND와 OR 연산의 우선순위
- AND가 OR 보다 우선순위가 높다.
- OR의 우선순위를 높이고 싶으면 () 소괄호를 이용한다.
*/

select 1 or 0 AND 0; -- 0 AND 0이 먼저 진행되므로 두 번째 연산은 1 or 0이 된다. 그래서 결과값 => 1
select (1 or 0) and 0; -- 1 OR 0 이 먼저 연산되므로 1 AND 0 두 번째 연산 1 AND 0 => 0

select
    *
from
    tbl_menu
where
    category_code = 4 or
    (menu_price = 9000 and
    menu_code >10);

-- 모든 컬럼들을 조회해 오는데, 카테고리 코드가 4이고, 메뉴 가격이 9000원이거나, 메뉴 코드가 10 이상인 칼럼? 엥?

-- BETWEEN 연산자를 사용한 WHERE
select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price >= 10000 and -- menu_price가 만원 이상이고
    menu_price <= 25000     -- menu_price가 이만오천원 이하

/*
BETWEEN 연산자
- 경계값을 포함하고 사이의 값을 포함한다.
BETWEEN 사용법
[column_name] BETWEEN [A] and [B]
*/

select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price between 10000 and 25000; -- menu_price 가 10000 이상 25000 이하인 칼럼

-- BETWEEN 부정표현
-- 경계값을 포함하지 않는다.

select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price not between 10000 and 25000; -- menu_price 가 10000 이상 25000 이하가 아닌 데이터만 조회

/*
LIKE 연산자
- 특정 패턴과 일치하는 행을 검색해준다.

패턴
- % : 0개 이상의 문자를 의미한다.
ex) '%apple%' => apple이 포함된 모든 문자열을 의미한다.
-- alsdjwknfgnappleskdn 이라도 apple이 포함되어 있으면 조회 가능

- _ : 1개의 문자를 나타낸다.
ex) 'a_k' => 'a'로 시작하고 'k'로 끝나는 세글자 문자열을 의미한다.
*/

select
    *
from
    tbl_menu
where
    menu_name like '%갈치%' or
    menu_name like '민트%';

-- LIKE 부정표현
select
    *
from
    tbl_menu
where menu_name not like '%갈치%'; -- 갈치가 포함되어 있지 않은 데이터만 보여준다.

/*
IN 연산자
- 특정 열의 값이 지정된 목록 중 하나와 일치하는지 확인하는데 사용된다.

IN 사용법
[column_name] in (4, 5, 6, ...)
*/

select
    menu_name,
    category_code
from tbl_menu
where category_code in (4, 5, 6); -- category_code가 4, 5, 6인 데이터만 뽑아서 보여준다.
-- category_code가 (4, 5, 6) 목록중에 있는 데이터만 조회해줘


-- IN 연산자의 부정표현
select
    menu_name,
    category_code
from
    tbl_menu
where
    category_code not in (4, 5, 6);
-- category_code가 (4, 5, 6) 목록 중에 없는 데이터만 조회해줘

/*
IS NULL 연산자
-- 값이 null인지 아닌지를 확인하여 조회한다.
*/

select
    category_code,
    category_name,
    ref_category_code
from
    tbl_category
where
    ref_category_code is null;
-- ref_category_code가 null 값인 데이터만 보여줘

-- IS NULL 연산자의 부정표현
select
    category_code,
    category_name,
    ref_category_code
from
    tbl_category
where
    ref_category_code is not null;
-- ref_category_code가 null이 아닌 데이터만 보여줘


