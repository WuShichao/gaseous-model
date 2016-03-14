      SUBROUTINE LOSSC
C     
      IMPLICIT REAL*8(A-H,O-Z),INTEGER(I-K,M-N),LOGICAL(L)
C     
      INCLUDE 'compar.f'
C     do not use XALPHA here because it is used for tidal massloss
      YALPHA = 1.D0
*     
      IF(I.EQ.NJ)RETURN
C     
      DO 1000 J=1,NCOMP
C     
         RLC=RTIDE(J)
         IF(R(I).LT.1.D1*R(2))RLC=RLC*R(I)/1.D1/R(2)
C     
         CALL LOSSCO(XMHOLE,RLC,J)
C     
         TCR=R(I)/DEXP((HX(I20+J)-HX(I00+J))/2.D0)
*     
         ERARG=DSQRT(YALPHA*4.D0*DOMEGA*TRX(J,J)/TCR)
         IF(ERARG.LT.1.D1)THEN
            EARG=ERARG
            PF=DERF(EARG)
            DPF=2.D0/DSQRT(PI)*DEXP(-ERARG*ERARG)
         ELSE
            PF=1.D0
            DPF=0.D0
         END IF
*     
         DXXE=DPF/PF*ERARG
         DG00=C12*(-1.D0+DXXE*(-3.D0+D0DOM/DOMEGA))
         IF(LS(13))THEN
            DG20=C12*(1.D0+DXXE*(2.D0+D2DOM/DOMEGA))
         ELSE
            DG20=C12*(1.D0+DXXE*(2.D0+D2DOM/DOMEGA
     *           -3.D0*AFAC(J)/(1.D0+2.D0*AFAC(J))))
            DG02=C12*DXXE*(DTDOM/DOMEGA
     *           +3.D0*AFAC(J)/(1.D0+2.D0*AFAC(J)))
         END IF
         DG10=C12*DXXE*D1DOM/DOMEGA
         GTERM=YALPHA*Y(J,I)*PF/TCR
*     
         DGRHO=GTERM*DOMEGA
C     
         G(I00+J)=G(I00+J)+DGRHO
C     
         D(I00+J,I00+J)=D(I00+J,I00+J)+DGRHO*(DG00+D0DOM/DOMEGA)
         D(I00+J,I20+J)=D(I00+J,I20+J)+DGRHO*(DG20+D2DOM/DOMEGA)
         D(I00+J,I02+J)=D(I00+J,I02+J)+DGRHO*(DG02+DTDOM/DOMEGA)
         D(I00+J,I10+J)=D(I00+J,I10+J)+DGRHO*(DG10+D1DOM/DOMEGA)
C     
         DGEPSR=GTERM
C     
         G(I20+J)=G(I20+J)+DGEPSR
         D(I20+J,I00+J)=D(I20+J,I00+J)+DGEPSR*(EPSR*DG00+D0DER)
         D(I20+J,I20+J)=D(I20+J,I20+J)+DGEPSR*(EPSR*DG20+D2DER)
         D(I20+J,I10+J)=D(I20+J,I10+J)+DGEPSR*(EPSR*DG10+D1DER)
*     
         IF(.NOT.LS(13))THEN
            D(I20+J,I02+J)=D(I20+J,I02+J)+DGEPSR*(DG02+DTDER/EPSR)
*     
            DGEPST=GTERM
*     
            G(I02+J)=G(I02+J)+DGEPST
            D(I02+J,I00+J)=D(I02+J,I00+J)+DGEPST*(EPST*DG00+D0DET)
            D(I02+J,I20+J)=D(I02+J,I20+J)+DGEPST*(EPST*DG20+D2DET)
            D(I02+J,I02+J)=D(I02+J,I02+J)+DGEPST*(EPST*DG02+DTDET)
            D(I02+J,I10+J)=D(I02+J,I10+J)+DGEPST*(EPST*DG10+D1DET)
*     
         END IF
*     
*     Diagnostic printout
         IF(LS(25))PRINT*,'  Class. LOSSC: COMP-',J,' G00=',DGRHO,
     *        ' G20=',DGEPSR,' G02=',DGEPST,DG00,D0DOM,DOMEGA
*     
*     Enhanced loss cone-due to non spherical symmetry
C     
         IF(LS(18))THEN
C     
C     Correction of TOUT due to small non-sphericity of the system
            IF(DEXP(X(IMR,I)).LT.XMHOLE)THEN
               TOUT=TCR*XMHOLE/DEXP(VX(IMR,I))*5.D0/6.D0/ELL          
            ELSE
               TOUT=TCR*5.D0/6.D0/ELL
            END IF
C     
            ERARG=DSQRT(YALPHA*4.D0*DOMEG1*TRX(J,J)/TOUT)
            IF(ERARG.LT.1.D1)THEN
               EARG=ERARG
               PF=DERF(EARG)
               DPF=2.D0/DSQRT(PI)*DEXP(-ERARG*ERARG)
            ELSE
               PF=1.D0
               DPF=0.D0
            END IF
C     
            DRHO=YALPHA/TOUT
            DXXE=DPF/PF*ERARG
            DG00=C12*(-1.D0+DXXE*(-3.D0+D0DOM1/DOMEG1))
            IF(LS(13))THEN
               DG20=C12*(1.D0+DXXE*(2.D0+D2DOM1/DOMEG1))
            ELSE
               DG20=C12*(1.D0+DXXE*(2.D0+D2DOM1/DOMEG1
     *              -3.D0*AFAC(J)/(1.D0+2.D0*AFAC(J))))
               DG02=C12*DXXE*(DTDOM1/DOMEG1
     *              +3.D0*AFAC(J)/(1.D0+2.D0*AFAC(J)))
            END IF
            DG10=C12*D1DOM1/DOMEG1
            GTERM=YALPHA*Y2(J,I)*PF/TOUT
*     
            DIFFOM=DOMEG1-DOMEGA
            IF(DIFFOM.LE.0.D0)DIFFOM=1.D-30
*     
            DGRHO=GTERM*DIFFOM
C     
            G(I00+J)=G(I00+J)+DGRHO
C     
            D(I00+J,I00+J)=D(I00+J,I00+J)+DGRHO*(DG00+(D0DOM1-D0DOM)/
     $           DIFFOM)
            D(I00+J,I20+J)=D(I00+J,I20+J)+DGRHO*(DG20+(D2DOM1-D2DOM)/
     $           DIFFOM)
            D(I00+J,I02+J)=D(I00+J,I02+J)+DGRHO*(DG02+(DTDOM1-DTDOM)/
     $           DIFFOM)
            D(I00+J,I10+J)=D(I00+J,I10+J)+DGRHO*(DG10+(D1DOM1-D1DOM)/
     $           DIFFOM)
C     
            DIFEPS=EPSR1-EPSR
            IF(DIFEPS.LE.0.D0)DIFEPS=1.D-30
            DGEPSR=GTERM
C     
            G(I20+J)=G(I20+J)+DGEPSR
            D(I20+J,I00+J)=D(I20+J,I00+J)+
     $           DGEPSR*(DIFEPS*DG00+(D0DER1-D0DER))
            D(I20+J,I20+J)=D(I20+J,I20+J)+
     $           DGEPSR*(DIFEPS*DG20+(D2DER1-D2DER))
            D(I20+J,I10+J)=D(I20+J,I10+J)+
     $           DGEPSR*(DIFEPS*DG10+(D1DER1-D1DER))
C     
            IF(.NOT.LS(13))THEN
               D(I20+J,I02+J)=D(I20+J,I02+J)+
     $              DGEPSR*(DG02+(DTDER1-DTDER)/DIFEPS)
*     
               DIFEPS=EPST1-EPST
               IF(DIFEPS.LE.0.D0)DIFEPS=1.D-30
               DGEPST=GTERM
C     
               G(I02+J)=G(I02+J)+DGEPST
               D(I02+J,I00+J)=D(I02+J,I00+J)+
     $              DGEPST*(DIFEPS*DG00+(D0DET1-D0DET))
               D(I02+J,I20+J)=D(I02+J,I20+J)+
     $              DGEPST*(DIFEPS*DG20+(D2DET1-D2DET))
               D(I02+J,I02+J)=D(I02+J,I02+J)+
     $              DGEPST*(DIFEPS*DG02+(DTDET1-DTDET))
               D(I02+J,I10+J)=D(I02+J,I10+J)+
     $              DGEPST*(DIFEPS*DG10+(D1DET1-D1DET))
*     
            END IF
*     
*     Diagnostic printout
            IF(LS(25))PRINT*,' Extend. LOSSC: COMP-',J,' G00=',DGRHO,
     *           ' G20=',DGEPSR,' G02=',DGEPST
*     
         END IF
*     
 1000 CONTINUE
C     
      RETURN
C     
      END
