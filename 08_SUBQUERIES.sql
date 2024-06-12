-- SUBQUERY
-- 서브쿼리는 다른 쿼리에서 실행되는 쿼리이다.
-- 존재하지 않는 조건에 근거한 값들을 검색하고자 할 때 사용한다.
-- 메인쿼리(따로 있음)가 서브쿼리를 포함하는 종속적인 관계

-- 서브쿼리의 유형
-- 1. 일반 서브쿼리
--  1-a. 단일행 일반 서브쿼리
--  1-b. 다중행 일반 서브쿼리

-- 2. 상관 서브쿼리
--  2-a. 스칼라 서브쿼리

-- 서브쿼리의 규칙
-- 서브쿼리는 반드시 소괄호()로 묶어야 한다. (SELECT ...) 형태
-- 서브쿼리는 연산자의 오른쪽에 위치해야 한다.
-- 서브쿼리 내에서 ORDER BY 문법은 지원되지 않는다.

-- 단일 행 서브쿼리
-- 민트미역국 이랑 같은 카테고리의 메뉴를 조회(메뉴코드, 메뉴명, 가격, 주문가능여부)


    /* 쿼리 2번 사용해서 원하는 결과 조회하기*/
-- 먼저 민트미역국이 어떤 카테고리 코드를 가지고 있는지 확인한다.
select
    category_code
from
    tbl_menu
where
    menu_name = '민트미역국'; -- 4

-- 민트 미역국 코드가 4인걸 확인했으니, 이 코드를 활용해서 원하는 값을 조회한다.
select
    menu_code 메뉴코드,
    menu_name 메뉴명,
    menu_price 메뉴가격,
    orderable_status 주문가능여부
from
    tbl_menu
where
    category_code = 4;


/* 서브쿼리를 사용해 구하기 */
-- 단 서브쿼리의 결과 값이 여러 개가 나오면 안 된다.
-- 하나만 나와야 단일 서브쿼리를 구현할 수 있다.
select
    menu_code 메뉴코드,
    menu_name 메뉴명,
    menu_price 메뉴가격,
    orderable_status 주문가능여부
from
    tbl_menu
where
    category_code = (
        select
            category_code
        from
            tbl_menu
        where
            menu_name = '민트 미역국'
        );


-- 다중행 서브쿼리
-- 카테고리 코드가 식사인 모든 category_code를 조회

select
    category_code
from
    tbl_category
where
    ref_category_code = 1;

select
    *
from
    tbl_menu
where
    category_code in (
        select
            category_code
        from
            tbl_category
        where
            ref_category_code = 1
        );

-- all 연산자
-- 서브쿼리의 결과 모두에 대해 연산결과가 참이면 참을 반환한다.
-- x > ALL(..) : 모든 값보다 크면 참, 최대값보다도 크면 참
-- x >= ALL(..) : 모든 값보다 크거나 같으면 참, 최대값보다 크거나 같으면 참
-- x < ALL(..) : 모든 값보다 작으면 참, 최소값보다도 작으면 참
-- x <= ALL(..) : 모든 값보다 작거나 같으면 참, 최소값보다도 작거나 같으면 참
-- x = ALL(..) : 모든 값과 같으면 참
-- x != ALL(..) : 모든 값과 다르면 참 (NOT IN 이랑 동일하다.)

-- 가장 비싼 메뉴를 조회
select
    max(menu_price)
from
    tbl_menu;

-- 서브쿼리를 이용해 가장 비싼 메뉴를 조회
select
    *
from
    tbl_menu
where
    menu_price >= all( -- tbl_menu 안에 담겨있는 menu_price를 다 비교해서 모든 게 맞으면 참을 반환
        -- 이걸 menu_price와 비교한다. 그래서 true 가 나오는 붕어빵 초밥을 반환한다.
        select -- tbl_menu에 있는 메뉴 가격들
            menu_price
        from
            tbl_menu
    );

-- 한식보다 비싼 중식 or 중식을 찾아줘

select
    *
from
    tbl_menu
where
    category_code in (5, 6) -- 일식/중식만 조회
    and
    menu_price > all( -- 한식의 메뉴 가격들 - 을 menu_price 와 비교하는 것
                      -- 카테고리 코드가 일식 중식인 것 중에서
        select
            menu_price
        from tbl_menu
        where category_code = 4
    );

select
    *
from
    tbl_menu
where category_code in (4);

-- 상관 서브커리
-- 메인 쿼리가 서브쿼리의 결과에 영향을 주는 경우를 의미한다.
-- 메인 쿼리의 값을 서브 쿼리에게 주고 서브쿼리를 수행한 다음
-- 그 결과를 다시 메인쿼리로 반환하는 형식으로 수행되는 서브 쿼리이다.

-- 서브쿼리의 WHERE 절 수행을 위해, 메인 쿼리가 먼저 수행되는 구조
-- 메인쿼리 테이블의 행에 따라 서브쿼리의 결과값도 바뀐다.

-- 카테고리 별 평균 가격이 가장 비싼 메뉴 조회
select
    category_code,
    max(menu_price)
from
    tbl_menu
group by
    category_code;


select
    *
from
    tbl_menu a -- 이 테이블을
where menu_price = (
    select
        max(menu_price)
    from
        tbl_menu
    where
        category_code = a.category_code -- 여기서 가져다 쓴다.
    );

-- EXISTS
-- 서브쿼리 결과집합에 행이 존재하면 참, 행이 존재하지 않으면 거짓
-- NOT EXISTS
-- 서브쿼리 결과집합에 행이 존재하지 않으면 참, 행이 존재하면 거짓

-- tbl_menu 에서 사용되는 카테고리만 조회하겠다.
select
    a.category_code, a.category_name
from
    tbl_category a
where
    exists(
        select
            category_code
        from
            tbl_menu b
        where
            b.category_code = a.category_code

    );

-- 스칼라 서브쿼리
-- 결과값이 1개인 서브쿼리, 주로 select 문에서 사용된다.
-- 스칼라 = 단일값

-- 메뉴명, 카테고리명 조회

select
    a.menu_name, b.category_name
from
    tbl_menu a
left join tbl_category b
    on a.category_code = b.category_code;

-- 스칼라 서브쿼리
select
    a.menu_name,
    (select
        category_name
        from
        tbl_category b
        where b.category_code = a.category_code
    ) category_name
from
    tbl_menu a;

-- 스칼라 서브쿼리의 반환 행수가 1행보다 많을 수는 없다.
-- 스칼라 서브쿼리의 반환 행수는 1행이다.

select
    menu_name,
    (select -- 이 select에서 반환하는 값이 1개 이상이기 때문에 오류뜨는 거.
         category_name
     from
         tbl_category)
        category_name
from
    tbl_menu;

/*
CTE(Common Table Expressions)
- 서브쿼리랑 비슷한 개념
- 코드의 가독성과 재사용성을 위해 사용한다.
- FROM 절에서만 사용이 된다. (JOIN 일시 JOIN 구문에서도 가능)
*/

-- 메뉴명과 카테고리명을 함께 출력
with menucate as (
    select
        menu_name,
        category_name
    from
        tbl_menu a
    join
            tbl_category b on a.category_code = b.category_code
)
select
    *
from
    menucate
order by
    menu_name;



