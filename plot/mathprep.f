       IMPLICIT REAL*4(A-H,O-Z),INTEGER(I-K,M-N),LOGICAL(L)
C
       IREC=0
       IWRITE=0
C
 1999  IREC=IREC+1
C
       IF(MOD(IREC,500).EQ.0)PRINT*,IREC,' Records read from unit 50...'
C
C       READ(50,*,ERR=700,END=700)RHO,SIG,XI
       READ(50,*,ERR=700,END=700)TIME,TTRX,RHO,SIG,XI
C
       IWRITE=IWRITE+1
C
       WRITE(51,5005)RHO,SIG,XI
 5005 FORMAT(1P,3(E14.7,1X))
C
       GOTO 1999
C
 700   CONTINUE
       PRINT*,IWRITE-1,' Records written to unit 51'
       STOP
       END
