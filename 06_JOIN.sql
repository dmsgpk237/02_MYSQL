-- JOIN
-- 여러개의 분산된 표를 조합해서 하나의 표로 만드는 기능
-- 관계형 데이터베이스에서 가장 중요한 파트이다.

-- 2개 이상 테이블을 관련있는 컬럼을 통해 결합하는데 사용된다.
-- 2개 이상 테이블은 반드시 연관있는 컬럼이 존재해야 하며,
-- 이를 통해 JOIN된 테이블들의 컬럼을 모두 확인할 수 있다.

/*
ALIAS
- SQL의 컬럼 또는 테이블에 별칭을 달 수 있다.
*/

select
    -- 별칭에 띄어쓰기나 특수기호가 없다면, 홀따옴표와 as는 생략이 가능하다.
    tbl.menu_code as code,
    tbl.menu_name as 'name',
    tbl.menu_price price
-- tbl에서 참조해주는 것이기 때문에 위 내용처럼 표기가 가능하다.
from
    tbl_menu tbl -- tbl로 별칭 만든 것임
order by price;

/*
INNER JOIN
- 두 테이블의 교집합을 반환하는 SQL JOIN 유형
- INNER JOIN에서 INNER 키워드는 생략 가능하다.
- 컬럼 명이 같거나, 다를 경우 ON으로 서로 연관있는 컬럼에 대한
- 조건을 작성하여 JOIN한다.
*/

select
    a.menu_name,
    b.category_name
from
    tbl_menu a -- 보통 from에 있는 것들을 a라고 칭한다.
inner join
        tbl_category b -- 가져오는 애들
    on a.category_code = b.category_code
order by b.category_name;

-- a와 b를 바꿨지만 값은 동일하게 나온다.
-- INNER JOIN은 교집합을 반환하기 때문에 JOIN의 순서를 바꿔도 영향이 없다.
select
    a.menu_name,
    b.category_name
from
    tbl_category b
inner join tbl_menu a
    on a.category_code = b.category_code
order by
    b.category_name;

-- USING
-- 컬럼명이 같을 경우 USING으로 서로 연관있는 컬럼에 대한 조건을 작성해 JOIN할 수 있다.
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
inner join tbl_category b using(category_code)
order by
    b.category_name;

/*
LEFT JOIN
- 첫 번째(왼쪽) 테이블을 모두 조회하고, 왼쪽과 일치하는 오른쪽 테이블을 JOIN 해준다.
*/

select
    a.menu_name,
    b.category_name
from tbl_menu a
left join tbl_category b on a.category_code = b.category_code;

/*
RIGHT JOIN
- 두 번째(오른쪽) 테이블을 모두 조회하고, 오른쪽과 일치하는 왼쪽 테이블을 JOIN 해준다.
*/

select
    a.menu_name,
    b.category_name
from
    tbl_menu a
right join tbl_category b on a.category_code = b.category_code;
-- tbl_category 코드를 기준으로 a와 b를 조회했을 때 겹치는 값만 가지고 와주는 것.

/*
CROSS JOIN
- 두 테이블의 모든 가능한 조합을 반환하는 JOIN (모든 경우의 수를 다 구함)
- 카르테시안 곱이라고도 함.
*/
-- 경우의 수를 확인할 때 사용하는 거라서 데이터가 많을 수록 안 좋기 때문에 많이 사용하지는 않음.
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
cross join tbl_category b;

/*
SELF JOIN
- 같은 테이블 내에서 행과 행 사이의 관계를 찾기 위해 사용되는 JOIN
*/

select
    a.category_name, -- 카테고리
    b.category_name -- 대분류
from
    tbl_category a
join
        tbl_category b on a.ref_category_code = b.ref_category_code;