       IMPLICIT REAL*8(A-H,O-Z),INTEGER(I-K,M-N),LOGICAL(L)
       DIMENSION SR1(5),ST1(5),SR2(5),ST2(5),EQUI(5)
C
       IREC=0
 1900  IREC=IREC+1
C
       READ(50,*,ERR=999,END=999)TIME,(SR1(K),K=1,5)
       READ(51,*,ERR=999,END=999)TIME,(ST1(K),K=1,5)
       READ(52,*,ERR=999,END=999)TIME,(SR2(K),K=1,5)
       READ(53,*,ERR=999,END=999)TIME,(ST2(K),K=1,5)
C
       DO 200 K=1,5
       SIG1=(SR1(K)+ST1(K))/3.D0
       SIG2=(SR2(K)+ST2(K))/3.D0
       EQUI(K)=2.D0*SIG2/SIG1-1.D0
 200   CONTINUE
*
       WRITE(54,100)TIME,(EQUI(K),K=1,5)
C
 100   FORMAT(1X,1P,6(1X,D12.5))
C
       GOTO 1900
C
 999   PRINT*,IREC-1,' Records read and written '
       STOP
       END
