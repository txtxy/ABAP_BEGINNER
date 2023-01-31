*&---------------------------------------------------------------------*
*& Report ZABAP_E01_020
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_e01_020.

DATA: gt_bdcdata TYPE TABLE OF bdcdata,
      gs_bdcdata LIKE LINE OF gt_bdcdata.

gs_bdcdata-program = 'SAPBC402_PGCD_CREATE_CUSTOMER'. " 프로그램이름
gs_bdcdata-dynpro = '0100'. " 스크린번호
gs_bdcdata-dynbegin = 'X'.
APPEND gs_bdcdata TO gt_bdcdata.

CLEAR : gs_bdcdata. "해당 스트럭쳐 데이터 삭제
gs_bdcdata-fnam = 'SCUSTOM-NAME'.
gs_bdcdata-fval = '길동'.
APPEND gs_bdcdata TO gt_bdcdata.

CLEAR : gs_bdcdata. "해당 스트럭쳐 데이터 삭제
gs_bdcdata-fnam = 'SCUSTOM-FORM'.
gs_bdcdata-fval = 'Mr'.
APPEND gs_bdcdata TO gt_bdcdata.

CLEAR : gs_bdcdata. "해당 스트럭쳐 데이터 삭제

gs_bdcdata-fnam = 'SCUSTOM-STREET'.
gs_bdcdata-fval = '종로구 관철동'.
APPEND gs_bdcdata TO gt_bdcdata.

CLEAR : gs_bdcdata. "해당 스트럭쳐 데이터 삭제

gs_bdcdata-fnam = 'SCUSTOM-POSTCODE'.
gs_bdcdata-fval = '1235'.
APPEND gs_bdcdata TO gt_bdcdata.

CLEAR : gs_bdcdata. "해당 스트럭쳐 데이터 삭제

gs_bdcdata-fnam = 'SCUSTOM-NAME'.
gs_bdcdata-fval = '길동'.
APPEND gs_bdcdata TO gt_bdcdata.


CLEAR : gs_bdcdata. "해당 스트럭쳐 데이터 삭제

gs_bdcdata-fnam = 'SCUSTOM-CITY'.
gs_bdcdata-fval = '서울'.
APPEND gs_bdcdata TO gt_bdcdata.

CLEAR : gs_bdcdata.

CALL TRANSACTION 'BC402_CALD_CRE_CUST'
  USING gt_bdcdata.