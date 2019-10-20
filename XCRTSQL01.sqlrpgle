       //********************************************************************
       // XCRTSQL01 - Retrieve source file data length
       //********************************************************************
       ctl-opt option(*nodebugio: *srcstmt)
       dftactgrp(*no) actgrp(*caller)
       fixnbr(*zoned : *inputpacked)
       ;

       dcl-pi  XCrtSql01;
          dcl-parm   pSrcLib  char(10) const;       // IN:  Source member library
          dcl-parm   pSrcFile char(10) const;       // IN:  Source file
          dcl-parm   pLen     char(3);              // OUT: length
       end-pi;
       dcl-s  len    packed(3:0);

         Exec SQL
            SET OPTION COMMIT = *NONE,
                       CLOSQLCSR = *ENDMOD,
                       DLYPRP = *YES,
                       ALWCPYDTA = *YES
            ;

        // Get length from SYSTABLES
          Exec SQL
            SET :len = (
              SELECT row_length FROM qsys2.sysTables
               WHERE system_table_schema = :pSrcLib
                 AND system_table_name   = :pSrcFile )
            ;
          if SQLCODE <> 0;
           pLen = '100';
          else;
           monitor;
              pLen=%char(len - 12);
           on-error;
              pLen='100';
           endmon;
          endif;

        return;

