# 프로젝트
Spring Framework, JAVA, Java Script, JSP를 활용한 웹 서비스

## 📜 목차
 - [개발 주제](#-개발-주제)
 - [개발 기간](#-개발기간)
 - [개발 환경](#-개발-환경)
 - [주요 기능](#-주요-기능)
 - [관계 데이터베이스 테이블 구조 및 관계도](#-관계-DB-테이블-구조-및-관계도)
 - [api 정리](#-api-정리)
 - [예시 화면](#-예시-화면)

## 💡 개발 주제
자발적으로 관리하고 서로 실시간으로 소통하는 게시판 사이트


## 🕔 개발기간
2023년 11월 15일 ~ 2024년 5월 21일
(유지보수 기간은 미포함)

## ⚙️ 개발 환경
 - **programming language** : 'Java 11', 'JavaScript ES12'
 - 'JDK 11.0.18', 'JSP 2.3'
 - **DataBase** : *Oracle DB 18*
 - **IDE** : 'STS 3.9.18.RELEASE(Eclipse 2021-09 (4.21.0))', 'SQL Developer 22.2.1.234.1810'

## 🔧 주요 기능
- 게시물 업로드, 삭제, 수정, 읽기, 게시물 리스트 읽기
- 게시판 개설, 삭제, 게시판 목록 읽기, 게시판 설명 수정
- 댓글 작성, 수정, 삭제, 읽기
- 게시물 내 파일 업로드, 다운로드, 삭제, 이미지 파일 보기, 파일 리스트 읽기
- 로그인, 로그아웃, 회원 가입, 회원 탈퇴, 아이디 찾기, 비밀번호 재설정
- 마이 페이지, 기타정보 등록, 삭제, 수정, 읽기
- 마이 페이지를 통한 게시물, 댓글, 파일 읽기, 삭제
- 회원 차단, 차단 해제, 권한 부여, 권한 회수

### 권한 리스트 
![auth_list](https://github.com/somecreater/springminiproject/assets/127456520/0e1f83e0-1506-48d5-982b-3cddeef69f0b)


- 친구 추가, 삭제
- 채팅방 생성, 입장, 나가기, 폭파, 채팅방 리스트 읽기, 채팅 메시지 전송



## 💿 관계 DB 테이블 구조 및 관계도
![Entity Relationship Diagram](https://github.com/somecreater/springminiproject/assets/127456520/0e23b804-074b-4078-9fc8-534a28863a6e)



## 📋 api 정리


| API NAME       | URL                    | Method | URL Params                                                | Data Params                                                                                                                                                      | Success Response      | Error Response | etc(부가 설명)                                       |
|----------------|------------------------|--------|-----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|----------------|--------------------------------------------------|
| Board List     | /board/listboard       | GET    | boardsearch: search, Model: model                         | -                                                                                                                                                                | -                     | -              | View, 게시물 리스트 페이지(페이징 기능, 검색에 따라 게시물 리스트를 보여준다)  |   |   |
| Board Read     | /board/readBoard       | GET    | Long: bno, boardsearch: search, Model: model              | -                                                                                                                                                                | -                     | -              | View, 게시물 읽기 페이지                                 |
| Board Insert-1 | /board/createBoard     | GET    | boardsearch: search, Model: model                         | -                                                                                                                                                                | -                     | -              | View, 게시물 작성하기 페이지                               |
| Board Insert-2 | /board/saveBoard       | POST   | board: brd, boardsearch: search, RedirectAttributes: rttr | board:{Long: bno, String: boardname, String: title String: content, String: writer, Date: regdate,  Date: udate, int: comment_num, List<attachfile>: attachlist} | String(redirect: URL) | -              | 게시물 작성하기 실행                                      |
| Board Update-1 | /board/updateBoard     | GET    | Long: bno, boardsearch: search, Model: model              |                                                                                                                                                                  | -                     | -              | View, 게시물 수정하기 페이지                               |
| Board Update-2 | /board/updatesaveBoard | POST   | board: brd, boardsearch: search, RedirectAttributes: rttr | board:{Long: bno, String: boardname, String: title String: content, String: writer, Date: regdate,  Date: udate, int: comment_num, List<attachfile>: attachlist} | String(redirect: URL) | -              | 게시물 수정하기 실행                                      | 


| API NAME            | URL                      | Method | URL Params                                                      | Data Params                                                                                                                       | Success Response                                | Error Response                                  | etc(부가 설명)             |
|---------------------|--------------------------|--------|-----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|-------------------------------------------------|------------------------|
| Board Delete -1     | /board/removeBoard       | POST   | board: brd, boardsearch: search, RedirectAttributes: rttr       | -                                                                                                                                 | String(redirect: URL)                           | -                                               | 게시물 삭제하기 실행            |
| Board Delete -2     | /board/directremoveBoard | POST   | Long: bno                                                       | -                                                                                                                                 | Map<String,Object> response (result: “success”) | Map<String,Object> response (result: “failure”) | 게시물 삭제하기(마이 페이지에서 이용)  |
| Boardlist List      | /board/selectBoardlist   | GET    | Model: model                                                    | -                                                                                                                                 | -                                               | -                                               | View, 게시판 목록 페이지       |
| Boardlist Insert -1 | /createBoardlist         | GET    | Model: model                                                    | -                                                                                                                                 | -                                               | -                                               | View, 게시판 개설하기 페이지     |
| Boardlist Insert -2 | /createBoardlistaction   | POST   | boardlist: brdli, boardsearch: search, RedirectAttributes: rttr | boardlist:{Long:boardnum, String: boardname, String: boardsubject, Date: regdate, String: reguserid, List<String>: manageridlist} | String(redirect: URL)                           | -                                               | 게시판 개설하기 실행            |
| Boardlist Delete-1  | /removeBoardlist         | GET    | Model: model                                                    | -                                                                                                                                 | -                                               | -                                               | View, 게시판 제거하기 페이지     |


| API NAME           | URL                    | Method | URL Params                        | Data Params | Success Response                                     | Error Response                                          | etc(부가 설명)               |
|--------------------|------------------------|--------|-----------------------------------|-------------|------------------------------------------------------|---------------------------------------------------------|--------------------------|
| Boardlist Delete-2 | /removeBoardlistaction | POST   | String: brdname                   | -           | Map<String,Object> response (result: “success”)      | Map<String,Object> response (result: “failure”)         | 게시판 제거하기 실행              |
| Boardlist Update   | /updatebrdlistsubac    | POST   | String: brdname, String: brdsub   | -           | Map<String,Object> response(result: “success”)       | Map<String,Object> response result: “failure”)          | 게시판 설명 수정하기 실행           |
| Manager List       | /getauthlist           | GET    | boardsearch: search, Model: model | -           | Map<String,Object> response (authlist: List<String>) | Map<String,Object> response (authlist: “해당 게시판 관리자 아님”) | 특정 게시판 관리자 리스트 가져오기 실행   |


| API NAME       | URL                      | Method | URL Params                             | Data Params                                                                       | Success Response      | Error Response | etc(부가 설명)      | 
|----------------|--------------------------|--------|----------------------------------------|-----------------------------------------------------------------------------------|-----------------------|----------------|-----------------|
| Comment List   | /comment/readcommentlist | GET    | Long: bno, int: pagenum                | -                                                                                 | -                     | -              | 댓글 리스트 가져오기 실행  |
| Comment Read   | /comment/readComment     | GET    | Long: rno                              | -                                                                                 | -                     | -              | 댓글 읽어오기 실행      |
| Comment Insert | /comment/insertcomment   | POST   | comment: cmt, RedirectAttributes: rttr | comment: { Long: rno, Long: bno, String: comments, String: writer, Date: regdate} | String(redirect: URL) | -              | 댓글 작성하기 실행      |
| Comment Update | /comment/updatecomment   | POST   | comment: cmt, RedirectAttributes: rttr | comment: { Long: rno, Long: bno, String: comments, String: writer, Date: regdate} | String(redirect: URL) | -              | 댓글 수정하기 실행      |
| Comment Delete | /comment/deletecomment   | POST   | Long: rno, String: userid              | -                                                                                 | -                     | -              | 댓글 삭제하기 실행      |


| API NAME      | URL         | Method | URL Params                         | Data Params                                                                                                                                                 | Success Response                                                                                                | Error Response | etc           |
|---------------|-------------|--------|------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|----------------|---------------|
| File Upload   | /uploadFile | POST   | MultipartFile[]: uploadFile        | memberfile[]: { String: pro_mem_file_code, String: userid, String: uuid, String:  uploadPath, String: filename, Boolean: image,  Long: bno, Date: regDate;} | Map<String,Object> response (attachfilelist: List<file>) (thumbnaillist: List<File>) (result: “upload_success”) | -              | 파일 등록하기 실행    |
| File Display  | /display    | GET    | String: fileuri                    | -                                                                                                                                                           | ResponseEntity<Resource>                                                                                        | -              | 이미지 파일 보기 실행  | 
| File Donwload | /download   | GET    | String: fileuri                    | -                                                                                                                                                           | ResponseEntity<Resource>                                                                                        | -              | 파일 다운로드 실행    | 
| File Delete   | /deletefile | POST   | String: fileuri, boolean: filetype | -                                                                                                                                                           | Map<String,Object> response (result: “success”)                                                                 | -              | 파일 삭제하기 실행    | 


| API NAME      | URL              | Method | URL Params                                                 | Data Params                                                                                                                                                                         | Success Response      | Error Response | etc               |
|---------------|------------------|--------|------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|----------------|-------------------|
| Login-1       | /loginboard      | GET    | -                                                          | -                                                                                                                                                                                   | String(URL)           | -              | View, 로그인 페이지     |
| Login-2       | /loginaction     | GET    | -                                                          | -                                                                                                                                                                                   | String(redirect: URL) | -              | 로그인 실행            |
| LoginError    | /loginerror      | GET    | -                                                          | -                                                                                                                                                                                   | -                     | -              | View, 로그인 오류 페이지  |
| Logout        | /logoutaction    | GET    | -                                                          | -                                                                                                                                                                                   | String(redirect: URL) | -              | 로그아웃 실행           |
| ServiceJoin-1 | /boardjoin       | GET    | -                                                          | -                                                                                                                                                                                   | -                     | -              | View, 회원가입 페이지    |
| ServiceJoin-2 | /boardjoinaction | POST   | String: id, String: passwd, String username, String: phone | member: {String: userid, String: userpw, String: username, String: phone, Date: regdate, Date: udate, Boolean: enabled, List<auth>: authlist}, auth: {String: userid, String: auth} | String(redirect: URL) | -              | 회원가입 실행           | 

| API NAME                    | URL                 | Method | URL Params                                            | Data Params                                                                                                                                    | Success Response                                  | Error Response                                                                           | etc                     |
|-----------------------------|---------------------|--------|-------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|------------------------------------------------------------------------------------------|-------------------------|
| ID check                    | /idcheckaction      | GET    | String: id                                            | -                                                                                                                                              | Map<String,Object> response (response: “success”) | Map<String,Object> response (result: “failure”)                                          | 아이디 존재 여부 확인            |
| User Join information Check | /etcdatacheckaction | GET    | String: passwd, String: username, String: phonenumber | -                                                                                                                                              | Map<String,Object> response (result: “success”)   | Map<String,Object> response (result: “failure”)                                          | 회원 가입시 입력정보 적합성 확인      |  
| ID and Password Search      | /idsearch           | GET    | -                                                     | -                                                                                                                                              | -                                                 | -                                                                                        | View,아이디, 비밀번호를 찾는 페이지  |
| ID Search                   | /searchauth         | GET    | String: email, String: phone                          | -                                                                                                                                              | Map<String,Object> response (result: “success”)   | Map<String,Object> response (userid: “noid”) (userid: “String”) (result: “subsuccess”)   | 아이디 찾기 실행               |
| Password Search             | /searchpass         | GET    | String: userid, String: email, String: phone          | -                                                                                                                                              | Map<String,Object> response (result: “success”)   | Map<String,Object> response (result: “failure”)                                          | 비밀번호 재설정 위한 작업 실행       | 
| Password Reset              | /resetpassword      | POST   | String: userid, String: newpass, String: renewpass    | member: {String: userid, String: userpw, String: username, String: phone, Date: regdate, Date: udate, Boolean: enabled, List<auth>: authlist}, | Map<String,Object> response (result: “success”)   | Map<String,Object> response (result: “notpass”) (result: “notmatch”) (result: “failure”) |                         |

![board api-1](https://github.com/somecreater/springminiproject/assets/127456520/61bffd38-9a44-42bc-b191-a26dd5bee61e)
![board api-2](https://github.com/somecreater/springminiproject/assets/127456520/8ead39c1-c15c-4cb9-b46f-4d34929b6499)
![board api-3](https://github.com/somecreater/springminiproject/assets/127456520/8ca93889-bd5d-45c2-bd3d-8572809059fe)

![comment api](https://github.com/somecreater/springminiproject/assets/127456520/4f4aac69-be5b-4ba7-bf3b-5470ffb97245)

![file api](https://github.com/somecreater/springminiproject/assets/127456520/07adfd15-f31e-4f10-a122-84bfbb20ea55)

![security api-1](https://github.com/somecreater/springminiproject/assets/127456520/e1880bc0-a11e-4673-ac51-da9f26326cbc)
![security api-2](https://github.com/somecreater/springminiproject/assets/127456520/3af789db-bd54-4fdb-8cc5-8f98741523e9)
![security api-3](https://github.com/somecreater/springminiproject/assets/127456520/0b0b747a-0ea0-4b5a-b9ea-5de9a5a317e4)
![security api-4](https://github.com/somecreater/springminiproject/assets/127456520/742420d1-f7e6-4950-a080-203924b26561)
![security api-5](https://github.com/somecreater/springminiproject/assets/127456520/f3611ad1-a371-43c0-b2ba-4ca002f3e5b9)

![chat api-1](https://github.com/somecreater/springminiproject/assets/127456520/676d28f9-9894-433d-adcb-35d1ec3caf64)
![chat api-2](https://github.com/somecreater/springminiproject/assets/127456520/890418f1-1c6c-4e79-b7f1-013b58df52d6)



## 🖥️ 예시 화면


## 현재까지 구현상황(2024/5/21):

