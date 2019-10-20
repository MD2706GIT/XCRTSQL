/* ----------------------------------------------------------------- */
/* XCRTSQL - Create objects from SQL script                          */
/*                                                                   */
/* To compile: CRTCMD CMD(lib/XCRTSQL) PGM(XCRTSQL00)                */
/*        CPP: XCRTSQL00 (CLLE)                                      */
/*                                                                   */
/* ----------------------------------------------------------------- */

             CMD        PROMPT('Create SQL object')

             PARM       KWD(OBJLIB) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Object Library')
             PARM       KWD(SRCLIB) TYPE(*NAME) LEN(10) +
                          PROMPT('Source Library')
             PARM       KWD(SRCFILE) TYPE(*NAME) LEN(10) +
                          PROMPT('Source File')
             PARM       KWD(SRCMBR) TYPE(*NAME) LEN(10)  +
                          PROMPT('Source Member')
             PARM       KWD(STMF)   TYPE(*CHAR) LEN(250) +
                          PROMPT('Stream File')
             PARM       KWD(TGTRLS)  TYPE(*CHAR) LEN(10) MIN(0) +
                          PROMPT('Target release')    +
                          DFT(V7R3M0)  +
                          VALUES((*CURRENT) (V7R1M0) (V7R2M0) (V7R3M0) (V7R4M0)) +
                          RSTD(*YES)
/* Parameter check. Specify source member or stream file         */
             DEP        CTL(SRCFILE) PARM(SRCMBR SRCLIB)  NBRTRUE(*EQ 2)
             DEP        CTL(SRCMBR)  PARM(SRCLIB SRCFILE) NBRTRUE(*EQ 2)
             DEP        CTL(SRCLIB)  PARM(SRCMBR SRCFILE) NBRTRUE(*EQ 2)
             DEP        CTL(STMF)    PARM(SRCLIB SRCMBR SRCFILE) NBRTRUE(*EQ 0)
             DEP        CTL(SRCLIB)  PARM(STMF)           NBRTRUE(*EQ 0)
