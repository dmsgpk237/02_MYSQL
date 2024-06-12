-- SET OPERATORS(연산자)
-- 두 개 이상의 SELECT 문의 결과 집합을 결합하는데 사용된다.
-- SET 연산자를 통해 결합하는 결과 집합의 컬럼이 동일해야 한다.

-- UNION
-- 두 개 이상의 SELECT 결과문을 결합하여 중복된 레코드를 제거한 후 반환한다.

-- 카테고리 코드가 10인 데이터 조회
    select
        *
    from
        tbl_menu
    where
        category_code = 10

    UNION

-- 메뉴 가격이 9000원보다 작은 경우 조회

    select
        *
    from
        tbl_menu
    where
        menu_price > 9000;
-- 2개의 쿼리를 합쳐서 보여주는데, 중복된 값을 빼고 보여준다.
-- 단, select 의 컬럼(조건)이 같아야 한다.

-- UNION ALL
-- 두 개 이상의 SELECT 문의 결과를 결합하여 중복된 레코드를 제거하지 않고 모두 반환

-- 카테고리 코드가 10인 데이터 조회
select
    *
from
    tbl_menu
where
    category_code = 10

UNION ALL

-- 메뉴 가격이 9000원보다 작은 경우 조회

select
    *
from
    tbl_menu
where
    menu_price > 9000;

-- INTERSECT
-- 두 SELECT 문의 결과 중 공통되는 레코드만 반환
-- MYSQL 은 INTERSECT 를 제공하지 않지만, INNER JOIN 또는 IN 연산자를 활용해 구현 가능하다.

select
    a.*
from
    tbl_menu a
inner join (
    select *
    from tbl_menu
    where menu_price < 9000 -- 이 출력 결과를 하나의 테이블로 본다, 9000원 이상인 애들
    ) b -- 이걸 b로 설정
    on (a.menu_code = b.menu_code)
where a.category_code = 10; -- 카테고리를 조인하는데, 10인 애들로만 조인하는 것.

-- IN 연산자 활용
    select
        * -- 모든 조건을 보여줘
    from
        tbl_menu a
    where
        category_code = 10 and -- 카테고리 코드가 10 인, 그리고
        menu_code in ( -- 그걸 메뉴코드 안에 넣고
            select
                menu_code -- 메뉴 코드를 보여줘
            from
                tbl_menu -- tbl 메뉴 안에서
            where
                menu_price < 9000 -- 9000원보다 작은 친구들
            );

-- MINUS
-- 첫 번째 SELECT 문의 결과에서 두 번째 SELECT 문의 결과를 포함하는 레코드를
-- 제외해서 반환하는 SQL 연산자
-- MYSQL은 MINUS를 제공하지 않지만 LEFT JOIN을 활용해서 구현 가능

    select
        a.*
    from
        tbl_menu a
    left join(
        select
            *
        from
            tbl_menu
        where
            menu_price < 9000
        ) b
        on (a.menu_code = b.menu_code)
    where
        a.category_code = 10 and b.menu_code is null;