CREATE TABLE Answer
(
	Question_ID  smallint  NOT NULL ,
	Answer_ID  smallint  NOT NULL 
)
go


ALTER TABLE Answer
	ADD CONSTRAINT  XPKAnswer PRIMARY KEY   NONCLUSTERED (Question_ID  ASC,Answer_ID  ASC)
go


CREATE TABLE Category
(
	Category_ID  integer  NOT NULL ,
	Category_Name  varchar(250)  NULL 
)
go


ALTER TABLE Category
	ADD CONSTRAINT  XPKCategory PRIMARY KEY   NONCLUSTERED (Category_ID  ASC)
go


CREATE TABLE Certificate
(
	Certificate_ID  smallint  NOT NULL ,
	User_ID  smallint  NULL ,
	Download  smallint  NULL ,
	Course_ID  smallint  NULL 
)
go


ALTER TABLE Certificate
	ADD CONSTRAINT  XPKCertificate PRIMARY KEY   NONCLUSTERED (Certificate_ID  ASC)
go


CREATE TABLE Courses
(
	Course_ID  integer  NOT NULL ,
	Name  varchar(250)  NULL ,
	Description  varchar(250)  NULL ,
	Lessons_List_ID  smallint  NULL ,
	Test_ID  integer  NULL ,
	Category_ID  integer  NULL ,
	Target_ID  smallint  NULL 
)
go


ALTER TABLE Courses
	ADD CONSTRAINT  XPKCourses PRIMARY KEY   NONCLUSTERED (Course_ID  ASC)
go


CREATE TABLE Lessons
(
	Lesson_ID  integer  NOT NULL ,
	Name  varchar(250)  NULL ,
	Theoretical_material  varchar(250)  NULL ,
	Source  varchar(250)  NULL 
)
go


ALTER TABLE Lessons
	ADD CONSTRAINT  XPKLessons PRIMARY KEY   NONCLUSTERED (Lesson_ID  ASC)
go


CREATE TABLE Lessons_in_List
(
	Lesson_ID  smallint  NOT NULL ,
	Lessons_List_ID  smallint  NOT NULL 
)
go


ALTER TABLE Lessons_in_List
	ADD CONSTRAINT  XPKLessons_in_List PRIMARY KEY   NONCLUSTERED (Lesson_ID  ASC,Lessons_List_ID  ASC)
go


CREATE TABLE Lessons_List
(
	Lessons_List_ID  smallint  NOT NULL 
)
go


ALTER TABLE Lessons_List
	ADD CONSTRAINT  XPKLessons_List PRIMARY KEY   NONCLUSTERED (Lessons_List_ID  ASC)
go


CREATE TABLE Question_With_Variants
(
	Question_ID  smallint  NULL ,
	Answer_ID  smallint  NULL ,
	ID_QWV  smallint  NOT NULL 
)
go


ALTER TABLE Question_With_Variants
	ADD CONSTRAINT  XPKQuestion_With_Variants PRIMARY KEY   NONCLUSTERED (ID_QWV  ASC)
go


CREATE TABLE Questions
(
	Question_ID  smallint  NOT NULL ,
	Question  varchar(250)  NULL 
)
go


ALTER TABLE Questions
	ADD CONSTRAINT  XPKQuestions PRIMARY KEY   NONCLUSTERED (Question_ID  ASC)
go


CREATE TABLE Target_Audience
(
	Target_ID  smallint  NOT NULL ,
	Age  varchar(250)  NULL ,
	Description  varchar(250)  NULL 
)
go


ALTER TABLE Target_Audience
	ADD CONSTRAINT  XPKTarget_Audience PRIMARY KEY   NONCLUSTERED (Target_ID  ASC)
go


CREATE TABLE Tests
(
	Test_ID  integer  NOT NULL ,
	Test_Name  varchar(250)  NULL 
)
go


ALTER TABLE Tests
	ADD CONSTRAINT  XPKTests PRIMARY KEY   NONCLUSTERED (Test_ID  ASC)
go


CREATE TABLE Tests_Question
(
	Test_ID  smallint  NOT NULL ,
	ID_QWV  smallint  NOT NULL 
)
go


ALTER TABLE Tests_Question
	ADD CONSTRAINT  XPKTests_Question PRIMARY KEY   NONCLUSTERED (Test_ID  ASC,ID_QWV  ASC)
go


CREATE TABLE User_
(
	User_ID  integer  NOT NULL ,
	Name  varchar(250)  NULL ,
	Surname  varchar(250)  NULL ,
	Age  smallint  NULL ,
	Phone  smallint  NULL ,
	Email  varchar(250)  NULL 
)
go


ALTER TABLE User_
	ADD CONSTRAINT  XPKUser PRIMARY KEY   NONCLUSTERED (User_ID  ASC)
go


CREATE TABLE Variants
(
	Answer_ID  integer  NOT NULL ,
	Answer  varchar(250)  NULL 
)
go


ALTER TABLE Variants
	ADD CONSTRAINT  XPKAnswer PRIMARY KEY   NONCLUSTERED (Answer_ID  ASC)
go



ALTER TABLE Answer
	ADD CONSTRAINT  R_15 FOREIGN KEY (Question_ID) REFERENCES Questions(Question_ID)
		ON UPDATE CASCADE
go


ALTER TABLE Answer
	ADD CONSTRAINT  R_15 FOREIGN KEY (Answer_ID) REFERENCES Variants(Answer_ID)
		ON UPDATE CASCADE
go



ALTER TABLE Certificate
	ADD CONSTRAINT  R_4 FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE Certificate
	ADD CONSTRAINT  R_32 FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go



ALTER TABLE Courses
	ADD CONSTRAINT  R_9 FOREIGN KEY (Lessons_List_ID) REFERENCES Lessons_List(Lessons_List_ID)
		ON UPDATE CASCADE
go


ALTER TABLE Courses
	ADD CONSTRAINT  R_13 FOREIGN KEY (Test_ID) REFERENCES Tests(Test_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE Courses
	ADD CONSTRAINT  R_14 FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
		ON UPDATE CASCADE
go


ALTER TABLE Courses
	ADD CONSTRAINT  R_30 FOREIGN KEY (Target_ID) REFERENCES Target_Audience(Target_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go



ALTER TABLE Lessons_in_List
	ADD CONSTRAINT  R_24 FOREIGN KEY (Lesson_ID) REFERENCES Lessons(Lesson_ID)
		ON UPDATE CASCADE
go


ALTER TABLE Lessons_in_List
	ADD CONSTRAINT  R_24 FOREIGN KEY (Lessons_List_ID) REFERENCES Lessons_List(Lessons_List_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go



ALTER TABLE Question_With_Variants
	ADD CONSTRAINT  R_16 FOREIGN KEY (Question_ID) REFERENCES Questions(Question_ID)
		ON UPDATE CASCADE
go


ALTER TABLE Question_With_Variants
	ADD CONSTRAINT  R_16 FOREIGN KEY (Answer_ID) REFERENCES Variants(Answer_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go



ALTER TABLE Tests_Question
	ADD CONSTRAINT  R_21 FOREIGN KEY (Test_ID) REFERENCES Tests(Test_ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE Tests_Question
	ADD CONSTRAINT  R_21 FOREIGN KEY (ID_QWV) REFERENCES Question_With_Variants(ID_QWV)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go



CREATE TRIGGER tD_Answer ON Answer FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Answer */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Questions R/15 Answer on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00026f1e", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Question_ID" */
    IF EXISTS (SELECT * FROM deleted,Questions
      WHERE
        /* %JoinFKPK(deleted,Questions," = "," AND") */
        deleted.Question_ID = Questions.Question_ID AND
        NOT EXISTS (
          SELECT * FROM Answer
          WHERE
            /* %JoinFKPK(Answer,Questions," = "," AND") */
            Answer.Question_ID = Questions.Question_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Answer because Questions exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Variants R/15 Answer on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Answer_ID" */
    IF EXISTS (SELECT * FROM deleted,Variants
      WHERE
        /* %JoinFKPK(deleted,Variants," = "," AND") */
        deleted.Answer_ID = Variants.Answer_ID AND
        NOT EXISTS (
          SELECT * FROM Answer
          WHERE
            /* %JoinFKPK(Answer,Variants," = "," AND") */
            Answer.Answer_ID = Variants.Answer_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Answer because Variants exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Answer ON Answer FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Answer */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insQuestion_ID smallint, 
           @insAnswer_ID smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Questions R/15 Answer on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="000243fc", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Question_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Question_ID)
  BEGIN
    INSERT Questions (Question_ID)
      SELECT Question_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        
        NOT EXISTS (
          SELECT * FROM Questions
          WHERE
            /* %JoinFKPK(inserted,Questions," = "," AND") */
            inserted.Question_ID = Questions.Question_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Variants R/15 Answer on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Answer_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Answer_ID)
  BEGIN
    INSERT Variants (Answer_ID)
      SELECT Answer_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        
        NOT EXISTS (
          SELECT * FROM Variants
          WHERE
            /* %JoinFKPK(inserted,Variants," = "," AND") */
            inserted.Answer_ID = Variants.Answer_ID
        )
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Category ON Category FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Category */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Category R/14 Courses on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f369", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/14", C2P_VERB_PHRASE="R/14", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Category_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Courses
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Category_ID = deleted.Category_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Category because Courses exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Category ON Category FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Category */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCategory_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Category R/14 Courses on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000171f6", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/14", C2P_VERB_PHRASE="R/14", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Category_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Category_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insCategory_ID = inserted.Category_ID
        FROM inserted
      UPDATE Courses
      SET
        /*  %JoinFKPK(Courses,@ins," = ",",") */
        Courses.Category_ID = @insCategory_ID
      FROM Courses,inserted,deleted
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Category_ID = deleted.Category_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Category update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Certificate ON Certificate FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Certificate */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* User R/4 Certificate on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00025556", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="R/4", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="User_ID" */
    IF EXISTS (SELECT * FROM deleted,User_
      WHERE
        /* %JoinFKPK(deleted,User," = "," AND") */
        deleted.User_ID = User.User_ID AND
        NOT EXISTS (
          SELECT * FROM Certificate
          WHERE
            /* %JoinFKPK(Certificate,User," = "," AND") */
            Certificate.User_ID = User.User_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Certificate because User exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Courses R/32 Certificate on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/32", C2P_VERB_PHRASE="R/32", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="Course_ID" */
    IF EXISTS (SELECT * FROM deleted,Courses
      WHERE
        /* %JoinFKPK(deleted,Courses," = "," AND") */
        deleted.Course_ID = Courses.Course_ID AND
        NOT EXISTS (
          SELECT * FROM Certificate
          WHERE
            /* %JoinFKPK(Certificate,Courses," = "," AND") */
            Certificate.Course_ID = Courses.Course_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Certificate because Courses exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Certificate ON Certificate FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Certificate */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCertificate_ID smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* User R/4 Certificate on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00022c09", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="R/4", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="User_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(User_ID)
  BEGIN
    INSERT User_ (User_ID)
      SELECT User_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.User_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM User_
          WHERE
            /* %JoinFKPK(inserted,User," = "," AND") */
            inserted.User_ID = User.User_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Courses R/32 Certificate on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/32", C2P_VERB_PHRASE="R/32", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="Course_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Course_ID)
  BEGIN
    INSERT Courses (Course_ID)
      SELECT Course_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Course_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Courses
          WHERE
            /* %JoinFKPK(inserted,Courses," = "," AND") */
            inserted.Course_ID = Courses.Course_ID
        )
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tI_Courses ON Courses FOR INSERT AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* INSERT trigger on Courses */
BEGIN
	DECLARE @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons_List R/9 Courses on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="0002fe71", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="R/9", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Lessons_List_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Lessons_List_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Lessons_List
        WHERE
          /* %JoinFKPK(inserted,Lessons_List) */
          inserted.Lessons_List_ID = Lessons_List.Lessons_List_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," and") */
    select @nullcnt = count(*) from inserted where
      inserted.Lessons_List_ID IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30002,
             @errmsg = 'Cannot insert Courses because Lessons_List does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Category R/14 Courses on child insert restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/14", C2P_VERB_PHRASE="R/14", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Category_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Category_ID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Category
        WHERE
          /* %JoinFKPK(inserted,Category) */
          inserted.Category_ID = Category.Category_ID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," and") */
    select @nullcnt = count(*) from inserted where
      inserted.Category_ID IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30002,
             @errmsg = 'Cannot insert Courses because Category does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tD_Courses ON Courses FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Courses */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Courses R/32 Certificate on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0005f729", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/32", C2P_VERB_PHRASE="R/32", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="Course_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Certificate
      WHERE
        /*  %JoinFKPK(Certificate,deleted," = "," AND") */
        Certificate.Course_ID = deleted.Course_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Courses because Certificate exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Lessons_List R/9 Courses on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="R/9", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Lessons_List_ID" */
    IF EXISTS (SELECT * FROM deleted,Lessons_List
      WHERE
        /* %JoinFKPK(deleted,Lessons_List," = "," AND") */
        deleted.Lessons_List_ID = Lessons_List.Lessons_List_ID AND
        NOT EXISTS (
          SELECT * FROM Courses
          WHERE
            /* %JoinFKPK(Courses,Lessons_List," = "," AND") */
            Courses.Lessons_List_ID = Lessons_List.Lessons_List_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courses because Lessons_List exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Tests R/13 Courses on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/13", C2P_VERB_PHRASE="R/13", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Test_ID" */
    IF EXISTS (SELECT * FROM deleted,Tests
      WHERE
        /* %JoinFKPK(deleted,Tests," = "," AND") */
        deleted.Test_ID = Tests.Test_ID AND
        NOT EXISTS (
          SELECT * FROM Courses
          WHERE
            /* %JoinFKPK(Courses,Tests," = "," AND") */
            Courses.Test_ID = Tests.Test_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courses because Tests exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Category R/14 Courses on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/14", C2P_VERB_PHRASE="R/14", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Category_ID" */
    IF EXISTS (SELECT * FROM deleted,Category
      WHERE
        /* %JoinFKPK(deleted,Category," = "," AND") */
        deleted.Category_ID = Category.Category_ID AND
        NOT EXISTS (
          SELECT * FROM Courses
          WHERE
            /* %JoinFKPK(Courses,Category," = "," AND") */
            Courses.Category_ID = Category.Category_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courses because Category exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Target_Audience R/30 Courses on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Target_Audience"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/30", C2P_VERB_PHRASE="R/30", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Target_ID" */
    IF EXISTS (SELECT * FROM deleted,Target_Audience
      WHERE
        /* %JoinFKPK(deleted,Target_Audience," = "," AND") */
        deleted.Target_ID = Target_Audience.Target_ID AND
        NOT EXISTS (
          SELECT * FROM Courses
          WHERE
            /* %JoinFKPK(Courses,Target_Audience," = "," AND") */
            Courses.Target_ID = Target_Audience.Target_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Courses because Target_Audience exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror e @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Courses ON Courses FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Courses */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCourse_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Courses R/32 Certificate on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00063082", PARENT_OWNER="", PARENT_TABLE="Courses"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/32", C2P_VERB_PHRASE="R/32", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="Course_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Course_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insCourse_ID = inserted.Course_ID
        FROM inserted
      UPDATE Certificate
      SET
        /*  %JoinFKPK(Certificate,@ins," = ",",") */
        Certificate.Course_ID = @insCourse_ID
      FROM Certificate,inserted,deleted
      WHERE
        /*  %JoinFKPK(Certificate,deleted," = "," AND") */
        Certificate.Course_ID = deleted.Course_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Courses update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons_List R/9 Courses on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="R/9", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Lessons_List_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Lessons_List_ID)
  BEGIN
    INSERT Lessons_List (Lessons_List_ID)
      SELECT Lessons_List_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Lessons_List_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Lessons_List
          WHERE
            /* %JoinFKPK(inserted,Lessons_List," = "," AND") */
            inserted.Lessons_List_ID = Lessons_List.Lessons_List_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Tests R/13 Courses on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/13", C2P_VERB_PHRASE="R/13", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Test_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Test_ID)
  BEGIN
    INSERT Tests (Test_ID)
      SELECT Test_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Test_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Tests
          WHERE
            /* %JoinFKPK(inserted,Tests," = "," AND") */
            inserted.Test_ID = Tests.Test_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Category R/14 Courses on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/14", C2P_VERB_PHRASE="R/14", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Category_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Category_ID)
  BEGIN
    INSERT Category (Category_ID)
      SELECT Category_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Category_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Category
          WHERE
            /* %JoinFKPK(inserted,Category," = "," AND") */
            inserted.Category_ID = Category.Category_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Target_Audience R/30 Courses on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Target_Audience"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/30", C2P_VERB_PHRASE="R/30", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Target_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Target_ID)
  BEGIN
    INSERT Target_Audience (Target_ID)
      SELECT Target_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Target_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Target_Audience
          WHERE
            /* %JoinFKPK(inserted,Target_Audience," = "," AND") */
            inserted.Target_ID = Target_Audience.Target_ID
        )
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror e @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Lessons ON Lessons FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Lessons */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Lessons R/24 Lessons_in_List on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0001051b", PARENT_OWNER="", PARENT_TABLE="Lessons"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lesson_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Lessons_in_List
      WHERE
        /*  %JoinFKPK(Lessons_in_List,deleted," = "," AND") */
        Lessons_in_List.Lesson_ID = deleted.Lesson_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Lessons because Lessons_in_List exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Lessons ON Lessons FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Lessons */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insLesson_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons R/24 Lessons_in_List on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00017916", PARENT_OWNER="", PARENT_TABLE="Lessons"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lesson_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Lesson_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insLesson_ID = inserted.Lesson_ID
        FROM inserted
      UPDATE Lessons_in_List
      SET
        /*  %JoinFKPK(Lessons_in_List,@ins," = ",",") */
        Lessons_in_List.Lesson_ID = @insLesson_ID
      FROM Lessons_in_List,inserted,deleted
      WHERE
        /*  %JoinFKPK(Lessons_in_List,deleted," = "," AND") */
        Lessons_in_List.Lesson_ID = deleted.Lesson_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Lessons update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Lessons_in_List ON Lessons_in_List FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Lessons_in_List */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Lessons R/24 Lessons_in_List on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0002a459", PARENT_OWNER="", PARENT_TABLE="Lessons"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lesson_ID" */
    IF EXISTS (SELECT * FROM deleted,Lessons
      WHERE
        /* %JoinFKPK(deleted,Lessons," = "," AND") */
        deleted.Lesson_ID = Lessons.Lesson_ID AND
        NOT EXISTS (
          SELECT * FROM Lessons_in_List
          WHERE
            /* %JoinFKPK(Lessons_in_List,Lessons," = "," AND") */
            Lessons_in_List.Lesson_ID = Lessons.Lesson_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Lessons_in_List because Lessons exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Lessons_List R/24 Lessons_in_List on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lessons_List_ID" */
    IF EXISTS (SELECT * FROM deleted,Lessons_List
      WHERE
        /* %JoinFKPK(deleted,Lessons_List," = "," AND") */
        deleted.Lessons_List_ID = Lessons_List.Lessons_List_ID AND
        NOT EXISTS (
          SELECT * FROM Lessons_in_List
          WHERE
            /* %JoinFKPK(Lessons_in_List,Lessons_List," = "," AND") */
            Lessons_in_List.Lessons_List_ID = Lessons_List.Lessons_List_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Lessons_in_List because Lessons_List exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    ------raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Lessons_in_List ON Lessons_in_List FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Lessons_in_List */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insLesson_ID smallint, 
           @insLessons_List_ID smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons R/24 Lessons_in_List on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="0002480b", PARENT_OWNER="", PARENT_TABLE="Lessons"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lesson_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Lesson_ID)
  BEGIN
    INSERT Lessons (Lesson_ID)
      SELECT Lesson_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        
        NOT EXISTS (
          SELECT * FROM Lessons
          WHERE
            /* %JoinFKPK(inserted,Lessons," = "," AND") */
            inserted.Lesson_ID = Lessons.Lesson_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons_List R/24 Lessons_in_List on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lessons_List_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Lessons_List_ID)
  BEGIN
    INSERT Lessons_List (Lessons_List_ID)
      SELECT Lessons_List_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        
        NOT EXISTS (
          SELECT * FROM Lessons_List
          WHERE
            /* %JoinFKPK(inserted,Lessons_List," = "," AND") */
            inserted.Lessons_List_ID = Lessons_List.Lessons_List_ID
        )
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Lessons_List ON Lessons_List FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Lessons_List */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Lessons_List R/9 Courses on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0002079c", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="R/9", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Lessons_List_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Courses
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Lessons_List_ID = deleted.Lessons_List_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Lessons_List because Courses exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Lessons_List R/24 Lessons_in_List on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lessons_List_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Lessons_in_List
      WHERE
        /*  %JoinFKPK(Lessons_in_List,deleted," = "," AND") */
        Lessons_in_List.Lessons_List_ID = deleted.Lessons_List_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Lessons_List because Lessons_in_List exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    ----raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Lessons_List ON Lessons_List FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Lessons_List */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insLessons_List_ID smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons_List R/9 Courses on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003268c", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="R/9", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Lessons_List_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Lessons_List_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insLessons_List_ID = inserted.Lessons_List_ID
        FROM inserted
      UPDATE Courses
      SET
        /*  %JoinFKPK(Courses,@ins," = ",",") */
        Courses.Lessons_List_ID = @insLessons_List_ID
      FROM Courses,inserted,deleted
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Lessons_List_ID = deleted.Lessons_List_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Lessons_List update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Lessons_List R/24 Lessons_in_List on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Lessons_List"
    CHILD_OWNER="", CHILD_TABLE="Lessons_in_List"
    P2C_VERB_PHRASE="R/24", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Lessons_List_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Lessons_List_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insLessons_List_ID = inserted.Lessons_List_ID
        FROM inserted
      UPDATE Lessons_in_List
      SET
        /*  %JoinFKPK(Lessons_in_List,@ins," = ",",") */
        Lessons_in_List.Lessons_List_ID = @insLessons_List_ID
      FROM Lessons_in_List,inserted,deleted
      WHERE
        /*  %JoinFKPK(Lessons_in_List,deleted," = "," AND") */
        Lessons_in_List.Lessons_List_ID = deleted.Lessons_List_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Lessons_List update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    ------raiserror e @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Question_With_Variants ON Question_With_Variants FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Question_With_Variants */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Question_With_Variants R/21 Tests_Question on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003d836", PARENT_OWNER="", PARENT_TABLE="Question_With_Variants"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_QWV" */
    IF EXISTS (
      SELECT * FROM deleted,Tests_Question
      WHERE
        /*  %JoinFKPK(Tests_Question,deleted," = "," AND") */
        Tests_Question.ID_QWV = deleted.ID_QWV
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Question_With_Variants because Tests_Question exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Questions R/16 Question_With_Variants on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Question_ID" */
    IF EXISTS (SELECT * FROM deleted,Questions
      WHERE
        /* %JoinFKPK(deleted,Questions," = "," AND") */
        deleted.Question_ID = Questions.Question_ID AND
        NOT EXISTS (
          SELECT * FROM Question_With_Variants
          WHERE
            /* %JoinFKPK(Question_With_Variants,Questions," = "," AND") */
            Question_With_Variants.Question_ID = Questions.Question_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Question_With_Variants because Questions exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Variants R/16 Question_With_Variants on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Answer_ID" */
    IF EXISTS (SELECT * FROM deleted,Variants
      WHERE
        /* %JoinFKPK(deleted,Variants," = "," AND") */
        deleted.Answer_ID = Variants.Answer_ID AND
        NOT EXISTS (
          SELECT * FROM Question_With_Variants
          WHERE
            /* %JoinFKPK(Question_With_Variants,Variants," = "," AND") */
            Question_With_Variants.Answer_ID = Variants.Answer_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Question_With_Variants because Variants exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Question_With_Variants ON Question_With_Variants FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Question_With_Variants */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_QWV smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Question_With_Variants R/21 Tests_Question on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003dfa3", PARENT_OWNER="", PARENT_TABLE="Question_With_Variants"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_QWV" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_QWV)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insID_QWV = inserted.ID_QWV
        FROM inserted
      UPDATE Tests_Question
      SET
        /*  %JoinFKPK(Tests_Question,@ins," = ",",") */
        Tests_Question.ID_QWV = @insID_QWV
      FROM Tests_Question,inserted,deleted
      WHERE
        /*  %JoinFKPK(Tests_Question,deleted," = "," AND") */
        Tests_Question.ID_QWV = deleted.ID_QWV
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Question_With_Variants update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Questions R/16 Question_With_Variants on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Question_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Question_ID)
  BEGIN
    INSERT Questions (Question_ID)
      SELECT Question_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Question_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Questions
          WHERE
            /* %JoinFKPK(inserted,Questions," = "," AND") */
            inserted.Question_ID = Questions.Question_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Variants R/16 Question_With_Variants on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Answer_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Answer_ID)
  BEGIN
    INSERT Variants (Answer_ID)
      SELECT Answer_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        inserted.Answer_ID IS NOT NULL AND
        NOT EXISTS (
          SELECT * FROM Variants
          WHERE
            /* %JoinFKPK(inserted,Variants," = "," AND") */
            inserted.Answer_ID = Variants.Answer_ID
        )
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Questions ON Questions FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Questions */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Questions R/15 Answer on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0002204f", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Question_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Answer
      WHERE
        /*  %JoinFKPK(Answer,deleted," = "," AND") */
        Answer.Question_ID = deleted.Question_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Questions because Answer exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Questions R/16 Question_With_Variants on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Question_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Question_With_Variants
      WHERE
        /*  %JoinFKPK(Question_With_Variants,deleted," = "," AND") */
        Question_With_Variants.Question_ID = deleted.Question_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Questions because Question_With_Variants exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Questions ON Questions FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Questions */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insQuestion_ID smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Questions R/15 Answer on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000323fd", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Question_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Question_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insQuestion_ID = inserted.Question_ID
        FROM inserted
      UPDATE Answer
      SET
        /*  %JoinFKPK(Answer,@ins," = ",",") */
        Answer.Question_ID = @insQuestion_ID
      FROM Answer,inserted,deleted
      WHERE
        /*  %JoinFKPK(Answer,deleted," = "," AND") */
        Answer.Question_ID = deleted.Question_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Questions update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Questions R/16 Question_With_Variants on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Questions"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Question_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Question_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insQuestion_ID = inserted.Question_ID
        FROM inserted
      UPDATE Question_With_Variants
      SET
        /*  %JoinFKPK(Question_With_Variants,@ins," = ",",") */
        Question_With_Variants.Question_ID = @insQuestion_ID
      FROM Question_With_Variants,inserted,deleted
      WHERE
        /*  %JoinFKPK(Question_With_Variants,deleted," = "," AND") */
        Question_With_Variants.Question_ID = deleted.Question_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Questions update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Target_Audience ON Target_Audience FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Target_Audience */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Target_Audience R/30 Courses on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000fa10", PARENT_OWNER="", PARENT_TABLE="Target_Audience"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/30", C2P_VERB_PHRASE="R/30", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Target_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Courses
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Target_ID = deleted.Target_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Target_Audience because Courses exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Target_Audience ON Target_Audience FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Target_Audience */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insTarget_ID smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Target_Audience R/30 Courses on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000169d2", PARENT_OWNER="", PARENT_TABLE="Target_Audience"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/30", C2P_VERB_PHRASE="R/30", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Target_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Target_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insTarget_ID = inserted.Target_ID
        FROM inserted
      UPDATE Courses
      SET
        /*  %JoinFKPK(Courses,@ins," = ",",") */
        Courses.Target_ID = @insTarget_ID
      FROM Courses,inserted,deleted
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Target_ID = deleted.Target_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Target_Audience update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Tests ON Tests FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Tests */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Tests R/13 Courses on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000204ab", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/13", C2P_VERB_PHRASE="R/13", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Test_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Courses
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Test_ID = deleted.Test_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Tests because Courses exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Tests R/21 Tests_Question on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Test_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Tests_Question
      WHERE
        /*  %JoinFKPK(Tests_Question,deleted," = "," AND") */
        Tests_Question.Test_ID = deleted.Test_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Tests because Tests_Question exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Tests ON Tests FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Tests */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insTest_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Tests R/13 Courses on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0002ecbb", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Courses"
    P2C_VERB_PHRASE="R/13", C2P_VERB_PHRASE="R/13", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Test_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Test_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insTest_ID = inserted.Test_ID
        FROM inserted
      UPDATE Courses
      SET
        /*  %JoinFKPK(Courses,@ins," = ",",") */
        Courses.Test_ID = @insTest_ID
      FROM Courses,inserted,deleted
      WHERE
        /*  %JoinFKPK(Courses,deleted," = "," AND") */
        Courses.Test_ID = deleted.Test_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Tests update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Tests R/21 Tests_Question on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Test_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Test_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insTest_ID = inserted.Test_ID
        FROM inserted
      UPDATE Tests_Question
      SET
        /*  %JoinFKPK(Tests_Question,@ins," = ",",") */
        Tests_Question.Test_ID = @insTest_ID
      FROM Tests_Question,inserted,deleted
      WHERE
        /*  %JoinFKPK(Tests_Question,deleted," = "," AND") */
        Tests_Question.Test_ID = deleted.Test_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Tests update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Tests_Question ON Tests_Question FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Tests_Question */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Tests R/21 Tests_Question on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00029385", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Test_ID" */
    IF EXISTS (SELECT * FROM deleted,Tests
      WHERE
        /* %JoinFKPK(deleted,Tests," = "," AND") */
        deleted.Test_ID = Tests.Test_ID AND
        NOT EXISTS (
          SELECT * FROM Tests_Question
          WHERE
            /* %JoinFKPK(Tests_Question,Tests," = "," AND") */
            Tests_Question.Test_ID = Tests.Test_ID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Tests_Question because Tests exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Question_With_Variants R/21 Tests_Question on child delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Question_With_Variants"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_QWV" */
    IF EXISTS (SELECT * FROM deleted,Question_With_Variants
      WHERE
        /* %JoinFKPK(deleted,Question_With_Variants," = "," AND") */
        deleted.ID_QWV = Question_With_Variants.ID_QWV AND
        NOT EXISTS (
          SELECT * FROM Tests_Question
          WHERE
            /* %JoinFKPK(Tests_Question,Question_With_Variants," = "," AND") */
            Tests_Question.ID_QWV = Question_With_Variants.ID_QWV
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Tests_Question because Question_With_Variants exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Tests_Question ON Tests_Question FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Tests_Question */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insTest_ID smallint, 
           @insID_QWV smallint,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Tests R/21 Tests_Question on child update cascade */
  /* ERWIN_RELATION:CHECKSUM="00027932", PARENT_OWNER="", PARENT_TABLE="Tests"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="Test_ID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Test_ID)
  BEGIN
    INSERT Tests (Test_ID)
      SELECT Test_ID
      FROM   inserted
      WHERE
        /* %NotnullFK(inserted," IS NOT NULL AND") */
        
        NOT EXISTS (
          SELECT * FROM Tests
          WHERE
            /* %JoinFKPK(inserted,Tests," = "," AND") */
            inserted.Test_ID = Tests.Test_ID
        )
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Question_With_Variants R/21 Tests_Question on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Question_With_Variants"
    CHILD_OWNER="", CHILD_TABLE="Tests_Question"
    P2C_VERB_PHRASE="R/21", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_QWV" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_QWV)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Question_With_Variants
        WHERE
          /* %JoinFKPK(inserted,Question_With_Variants) */
          inserted.ID_QWV = Question_With_Variants.ID_QWV
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Tests_Question because Question_With_Variants does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_User ON User_ FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on User */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* User R/4 Certificate on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f316", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="R/4", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="User_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Certificate
      WHERE
        /*  %JoinFKPK(Certificate,deleted," = "," AND") */
        Certificate.User_ID = deleted.User_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete User because Certificate exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_User ON User_ FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on User */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insUser_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* User R/4 Certificate on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00015cd9", PARENT_OWNER="", PARENT_TABLE="User"
    CHILD_OWNER="", CHILD_TABLE="Certificate"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="R/4", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="User_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(User_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insUser_ID = inserted.User_ID
        FROM inserted
      UPDATE Certificate
      SET
        /*  %JoinFKPK(Certificate,@ins," = ",",") */
        Certificate.User_ID = @insUser_ID
      FROM Certificate,inserted,deleted
      WHERE
        /*  %JoinFKPK(Certificate,deleted," = "," AND") */
        Certificate.User_ID = deleted.User_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade User update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go


CREATE TRIGGER tD_Variants ON Variants FOR DELETE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* DELETE trigger on Variants */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Variants R/15 Answer on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="00020f79", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Answer_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Answer
      WHERE
        /*  %JoinFKPK(Answer,deleted," = "," AND") */
        Answer.Answer_ID = deleted.Answer_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Variants because Answer exists.'
      GOTO ERROR
    END

    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    /* Variants R/16 Question_With_Variants on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Answer_ID" */
    IF EXISTS (
      SELECT * FROM deleted,Question_With_Variants
      WHERE
        /*  %JoinFKPK(Question_With_Variants,deleted," = "," AND") */
        Question_With_Variants.Answer_ID = deleted.Answer_ID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Variants because Question_With_Variants exists.'
      GOTO ERROR
    END


    /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
    RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

CREATE TRIGGER tU_Variants ON Variants FOR UPDATE AS
/* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
/* UPDATE trigger on Variants */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insAnswer_ID integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Variants R/15 Answer on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0002f85d", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Answer"
    P2C_VERB_PHRASE="R/15", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="Answer_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Answer_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insAnswer_ID = inserted.Answer_ID
        FROM inserted
      UPDATE Answer
      SET
        /*  %JoinFKPK(Answer,@ins," = ",",") */
        Answer.Answer_ID = @insAnswer_ID
      FROM Answer,inserted,deleted
      WHERE
        /*  %JoinFKPK(Answer,deleted," = "," AND") */
        Answer.Answer_ID = deleted.Answer_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Variants update because more than one row has been affected.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  /* Variants R/16 Question_With_Variants on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Variants"
    CHILD_OWNER="", CHILD_TABLE="Question_With_Variants"
    P2C_VERB_PHRASE="R/16", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="Answer_ID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Answer_ID)
  BEGIN
    IF @NUMROWS = 1
    BEGIN
      SELECT @insAnswer_ID = inserted.Answer_ID
        FROM inserted
      UPDATE Question_With_Variants
      SET
        /*  %JoinFKPK(Question_With_Variants,@ins," = ",",") */
        Question_With_Variants.Answer_ID = @insAnswer_ID
      FROM Question_With_Variants,inserted,deleted
      WHERE
        /*  %JoinFKPK(Question_With_Variants,deleted," = "," AND") */
        Question_With_Variants.Answer_ID = deleted.Answer_ID
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Variants update because more than one row has been affected.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin 12 ìàÿ 2018 ã. 13:03:15 */
  RETURN
ERROR:
    --raiserror @errno @errmsg
    rollback transaction
END
go

