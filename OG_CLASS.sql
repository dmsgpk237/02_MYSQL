create database ogclass; -- db 생성
show databases; -- 전체 db 목록 조회
grant all privileges on ogclass.* to 'ohgiraffers'@'%'; -- 권한 부여
show grants for 'ohgiraffers'@'%'; -- 권한 조회
use ogclass; -- user_db 사용

-- autocommit 비활성화
set autocommit = 0;
set autocommit = OFF;

-- autocommit 활성화
set autocommit = 1;
set autocommit = ON;

delete
from favorite_subject
where subject_no > 0;

drop table if exists class;
drop table if exists favorite_subject;


create table if not exists favorite_subject (
subject_no int auto_increment primary key,
subject_name varchar(255) not null unique
) ENGINE = INNODB;

    insert into favorite_subject
    values(null, 'SPRING'),
          (null, 'JDBC'),
          (null, 'JAVA'),
          (null, 'MYSQL'),
          (null, 'MYBATIS'),
          (null, ' ');

    select * from favorite_subject;
    select * from class;

    create table if not exists class (
        student_no int auto_increment primary key,
        student_name varchar(255) not null,
        gender varchar(255) check(gender in('남', '여')),
        github_id varchar(255) not null unique,
        email varchar(255) not null unique,
        mbti varchar(10),
        subject_no int,
            foreign key(subject_no)
                references favorite_subject (subject_no)
    );

    insert into class
    (student_no, student_name, gender, github_id, email, mbti, subject_no)
    values (null, '박태근', '남', 'Ohgiraffers-bear', 'bear.ohgiraffers@gmail.com', 'ENFJ', 1),
           (null, '지동현', '남', 'Bring2it2on', 'yjkl0516@gmail.com', null, 2),
           (null, '김강현', '남', 'kimkinghyeon', 'modan8199@gmail.com', null, 3),
           (null, '이득규', '남', 'MANTISKYU', 'asdaron44@gmail.com', null, 4),
           (null, '홍주연', '여', 'juyeon99', 'juyeon0806@gmail.com', 'ISFP', 3),
           (null, '양혜연', '여', 'yanghyeyeon', 'yhy4058@gmail.com', 'ISFP', 1),
           (null, '이규섭', '남', 'LKS9616', 'lks609591@gmail.com', null, 4),
           (null, '전유안', '남', 'euuuuuuan', 'euan.may24@gmail.com', 'ENFP', 5),
           (null, '박성은', '여', 'seongeun223', 'jklun080921@gmail.com', 'ISTJ', 4),
           (null, '박하얀', '여', 'parkhayarn', 's0224y92@gmail.comm', 'INFP', 6),
           (null, '위성민', '남', 'wdh970616', 'wdh970616@naver.com', null, 6),
           (null, '박효찬', '남', 'qwes5674', 'qwes5674@gmail.com', null, 4),
           (null, '이의정', '남', 'himisterlee', 'lejlej100418@gmail.com', null, 4),
           (null, '권은혜', '여', 'dmsgpk237', 'a01027947353@gmail.com', 'ENFP', 4),
           (null, '권보현', '남', 'Kwonbohyun', 'kwon18923@gmail.com', null, 4),
           (null, '배하은', '여', 'HEun0420', 'usialeta@gmail.com', 'INTP', 4),
           (null, '강연진', '여', 'kangyeonjin', 'yeonjin917n.n@gmail.com', 'INTP', 1),
           (null, '강진영', '남', 'weed97', 'weed9935@gmail.com', null, 4);

