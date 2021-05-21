/*
    # 데이터베이스란?
    - 데이터를 효율적으로 저장하기 위한 데이터 저장 전문 프로그램
    - 파일 시스템의 많은 문제점과 한계점을 극복하기 위해 미리 만든 프로그램
      (보안성, 일관성, 저장효율 등...)
      
    # 파일 시스템의 문제점
    - 데이터 불일치가 발생할 수 있음
      ex: 헬스장 회원 정보.txt / 수영장 회원 정보.txt 중 하나만 수정되는 경우
    - 다수 사용자를 위한 동시 제공이 불가능하다
    - 중복 데이터를 필요 이상으로 많이 저장하게 될 수 있다
    - 파일 수정 도중 시스템에 문제가 발생했을 경우 복구하는 기능이 없음
    
    ※ 위 문제가 발생하지 않는 간단한 기능 구현에는 파일 시스템을 이용하는 것도 좋다 (ex: 환경 설정)
    
    # DBMS (DataBase Management System)
    - 데이터베이스에 데이터를 관리하기 위해 필요한 프로그램
    - 데이터베이스는 데이터를 보관하는 장소이고, 데이터 추가/수정/삭제/검색은 DBMS가 하는 작업이다    
        
    # RDBMS (Relational DataBase Management System)
    - 데이터간의 관계를 이용하여 데이터의 중복을 최소화하는 DBMS
    - 질의문(Query)으로 데이터를 관리한다. 쿼리문은 국제 표준을 따른다.
    
    # 테이블
    - 관계형 데이터베이스는 데이터를 표 형태로 저장한다
    - 필드 : 속성(attribute), 열(colum), 한 열에 저장될 데이터들의 특징을 저장하는 곳
    - 레코드 : 튜플(tuple), 행(row), 한 행에 저장되는 관련된 데이터들
    
    # NO-SQL
    - 관계형 데이터베이스의 문제점을 회피하기 위해 존재하는 DBMS
    - 데이터의 중복을 해결하지 않는 대신 속도가 빠르다
    
*/
SHOW USER;

SELECT * FROM employees;