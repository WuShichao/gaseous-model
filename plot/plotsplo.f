      CHARACTER*60 ZTEXT1,ZLINE,ZTEXT2,ZTEXT3,ZTEXT4,ZTEXT5,ZWORK
      CHARACTER*11 ZWRIT,ZCMD
      CHARACTER*12 ZCWRIT,ZINFO
      CHARACTER*5 ZCWR
      CHARACTER*80 ZPLDAT,ZNAM,ZMES1,ZMES2
      CHARACTER*1 ZLK(80),ZLL(80),ZLK2(80),ZLL2(80)
      DIMENSION ZNAM(5),ZLINE(5),ZTEXT4(5),ZTEXT5(5),ZWORK(67)
      DIMENSION MCOL(20),MOCNT(500)
      DIMENSION IWORK(240),LWORK(160),LLOG(200),XWORK(160),UNIT(200)
      DIMENSION VST(2000,IVDIM)
      COMMON/VECT/VEC(5,2000)
      COMMON/TEXT/ZNAM,ZTEXT1,ZLINE,ZMES1,ZMES2,ZTEXT2,ZTEXT3,
     * ZTEXT4,ZTEXT5,ZWRIT
      COMMON/PAR/PARY(10,40),PAR(3,5),XMINX,XMAXX,YMIN,YMAX
      COMMON/PSTEU/IMODA,IMGO,NTMIN,MOCNT,
     * NPLOT,NTIME,NMOMIN,NMOMAX,NTP,NINT,IWORK,LWORK,ZWORK,
     * MCOL,LLOG,XWORK,NCHR,NASCII,LPR,LCL,LTEST,NDATA,LSMO,LCONT,UNIT
      COMMON/TIME0/VST
