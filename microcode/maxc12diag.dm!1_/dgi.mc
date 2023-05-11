%TO ASSEMBLE:	MICRO/L LANG DGI -OR- @MI@ DGITO RUN:		MIDAS RDGI -OR- MIDAS DGI		START;GCURRENT SOURCES ON MAXC <ERF> DIRECTORY%*TEST OF THE INTERRUPT SYSTEM AND PARTS OF THE PROCESSOR AFFECTED BY INTERRUPTSINSERT[DGIB.MC];LVN[LTEMP];*TEST THAT ARM_ AND ARM AGREE FOR INTERRUPT CHANNELS 0 THROUGH 15.**INTERRUPT CHANNEL 17 (INTERRUPTS AT 17, REPRESENTED BY BIT 35 IN ARM)**PERMANENTLY REQUESTS AN INTERRUPT.**INTERRUPT CHANNEL 16 (INTERRUPTS AT 16, REPRESENTED BY BIT 34 IN ARM)**ENABLES LOCAL MEMORY PARITY ERROR TRAP.*THE TEST OF CHANNELS 0 THROUGH 15 DOES NOT TEST THE INTERRUPT SYSTEM*ITSELF BUT ONLY THE ARM REGISTER.  CHANNEL 17 IS THE HIGHEST PRIORITY*INTERRUPT, CHANNEL 0 THE LOWEST PRIORITY.TARM:	ARM_P_NULL;	Q_ARM;	Q_(NOT Q) U (377700 000000S), CALL[NQZT]; *ARM REG. WON'T CLEAR TO 0	Q_P+1, CALL[QLCY17], CLEARF[-1S];TARML:	ARM_Q;	P_ARM;	P_(NOT P) U (377700 000000S), CALL[PEQZ]; *ARM REG WON'T SET TO [Q]	Q RSH 1;	GOTO[TARML,Q EVEN];*NOW TEST OUT THE INTERRUPT CHANNEL WHICH ALWAYS REQUESTS AN INTERRUPTINT0:	ARM_P_NULL;	CLEARF[-1S];	ARM_Q_P+1;		*ARM THE INTERRUPT CHANNEL.	NOTHING SHOULD				*HAPPEN BECAUSE IENABLE=0	X_P_NULL;		*WASTE TIME TO ALLOW INTERRUPT TO OCCUR IF	Y_P_NULL;		*IT WANTS TO	P_MDR_NULL;	SETF[IENABLE&G];*FIRST CHECK THAT THE STACK AND CONTROL IS MAINTAINED CORRECTLY ACCROSS*INTERRUPTS.	DETERMINE THAT THE TOP ENTRY ON THE STACK IS FROM THE*CORRECT PLACE AND THAT THE NEXT ENTRY ON THE STACK WASN'T SMASHED.MC[XCT0&G,XCT0,G]; *XCT0 SIGNALS THE INTERRUPT ROUTINE WHAT TO CHECKSLC[@TC0: E1[TC0]];	SLC[@TC0A: E1[TC0A]];SLC[@TG0: E1[TG0]];	SLC[@2001: E1[2001]];SLC[@TR0: E1[TR0]];	SLC[@TR0A: E1[TR0A]];	SETF[XCT0&G], INHINT;	Q_@TC0, INHINT;	STEMP_Q, INHINT;	Q_@TC0A, INHINT;	STEMP1_Q, INHINT;	CALL[TC0A];	*INTERRUPT OCCURS AFTER THIS INSTRTC0:	BREAK;	*STK 0 SHOULD POINT HERETC0A:	BREAK;	*NO INTERRUPT OCCURRED	Q_@TR0, INHINT; *STK 1 SHOULD POINT HERE	STEMP_Q, INHINT, CALL[.+1];TR0:	Q_@TR0A, INHINT, DGOTO[TR0A];	STEMP1_Q, INHINT, CALL[.+1];	RETURN;	*INTERRUPT OCCURS AFTER THIS	BREAK; *INTERRUPT DIDN'T TAKE AND RETURN DIDN'T COMPLETE	BREAK;TR0A:	BREAK;	*NO INTERRUPT OCCURRED	Q_@TG0, INHINT, DGOTO[2001];	STEMP1_Q, INHINT, CALL[.+1];	Q_@2001, INHINT;	STEMP_Q, INHINT;	GOTO[TG0];	*INTERRUPT OCCURS AFTER THIS	BREAK;	*GOTO DIDN'T TAKE AND INTERRUPT FAILED	BREAK;TG0:	BREAK;	*NO INTERRUPT OCCURRED	CLEARF[-1S], INHINT;	INHINT;	INHINT;*NOW CHECK THE PRESERVATION OF BRANCH CONDITIONS AND REGISTERS ACCROSS*INTERRUPTS AND THE PROPER OPERATION OF THESE REGISTERS DURING INTERRUPTS	X_P_NULL;	Y_P_NULL;	P_NULL, L7_A0;	SETF[IENABLE&G];	CALL[INTX];*INTERRUPT ROUTINE COMES BACK HERE FROM BELOW WHEN K=1 WITH K=0.	REGISTER*COMPARISON VALUE IS IN L7.	Q_L7, FRZBALUBC, GOTO[.+2,ALU=0], INHINT;FBC0:	BREAK;	*ALU=0 WASN'T PRESERVED DURING INTERRUPT	GOTO[.+2,ALU>=0], FRZBALUBC, INHINT;	BREAK;			*ALU>=0 WASN'T PRESERVED	GOTO[.+2,ALU8=0], FRZBALUBC, INHINT;	BREAK;			*ALU8=0 WASN'T PRESERVED	GOTO[.+2,ALU<=0], FRZBALUBC, INHINT;	BREAK;			*ALU<=0 WASN'T PRESERVED	GOTO[.+2,B>=0], FRZBALUBC, INHINT;FBC1:	BREAK;	*B>=0 WASN'T PRESERVED	CALL[CBRK,ALU#0], FRZBALUBC, INHINT; *ALU=0 WASN'T PRESERVED	CALL[CBRK,ALU<0], FRZBALUBC, INHINT; *ALU>=0 WASN'T PRESERVED	CALL[CBRK,ALU8=1], FRZBALUBC, INHINT; *ALU8=0 WASN'T PRESERVED	CALL[CBRK,ALU>0], FRZBALUBC, INHINT; *ALU<=0 WASN'T PRESERVED	CALL[CBRK,B<0], FRZBALUBC, INHINT, Q_MDR; *B>=0 WASN'T PRESERVED	P#Q, INHINT, CLEARF[IENABLE&G];	GOTO[.+2,ALU=0], INHINT;FBC2:	BREAK;	*P NOT PRESERVED ACROSS INT	P_X, CALL[PZT];	 *X NOT PRESERVED	P_Y, CALL[PZT];	 *Y NOT PRESERVED	X_P_B, B_A1, SETF[IENABLE&G];	CALL[INTY], MDR_A1;*RETURN HERE FROM THE INTERRUPT WHICH TAKES ONE INSTRUCTION AFTER THE*INSTRUCTION ABOVE	Q_MDR, FRZBALUBC, INHINT, GOTO[.+2,ALU#0];FBC3:	BREAK;	*ALU#0 WASN'T PRESERVED DURING INTERRUPT	GOTO[.+2,ALU<0], FRZBALUBC, INHINT;	BREAK;			*ALU<0 WASN'T PRESERVED	GOTO[.+2,ALU8=1], FRZBALUBC, INHINT;	BREAK;			*ALU8#0 WASN'T PRESERVED	GOTO[.+2,ALU<=0], FRZBALUBC, INHINT;	BREAK;			*ALU<=0 WASN'T PRESERVED***NOTE THAT THE OTHER STATE OF ALU<=0 HASN'T BEEN TESTED	GOTO[.+2,B<0], FRZBALUBC, INHINT;FBC4:	BREAK;	*B<0 WASN'T PRESERVED	CALL[CBRK,ALU=0], FRZBALUBC, INHINT; *ALU#0 WASN'T PRESERVED	CALL[CBRK,ALU>=0], FRZBALUBC, INHINT; *ALU<0 WASN'T PRESERVED	CALL[CBRK,ALU8=0], FRZBALUBC, INHINT; *ALU8=1 WASN'T PRESERVED	CALL[CBRK,ALU>0], FRZBALUBC, INHINT; *ALU<=0 WASN'T PRESERVED	CALL[CBRK,B>=0], FRZBALUBC, INHINT; *B<0 WASN'T PRESERVED	P#Q, INHINT, CLEARF[IENABLE&G];	GOTO[.+2,ALU=0], INHINT;FBC5:	BREAK;	*P NOT PRESERVED ACROSS INT	INCX;	P_X, INCY, CALL[PZT];	*X NOT PRESERVED ACROSS INT	P_Y, CALL[PZT];	 *Y NOT PRESERVED ACROSS INT	SETF[IENABLE&G], CALL[.+2];FBC6:	BREAK;	*INT. OCCURRED DURING DGOTO, NPC_, F2[2], F2[3], RMW_	DGOTO[.+2], SETF[K], P_NULL;	DGOTO[.+2], P_P+1;	DGOTO[.+2], P_P+1, P_P+1;	DGOTO[.+2], P_P+1;	P_NPC_NPC;	GOTO[.+1], P_P+1, INHINT;	RMW_NULL, P_P+1, INHINT;	REPEAT[13,ILC[(P_P+1, Q_Q)]];	P_P+1, WRESTART;*F2[2] AND F2[3] ARE CURRENTLY NOT IMPLEMENTED BUT ARE SUPOSED TO STOP*INTERRUPTS JUST AS F2[0] AND F2[1] (INHINT AND NPC_) DO	P_P+1, F2[2]; P_P+1, F2[2]; P_P+1, F2[2];	P_P+1, F2[3]; P_P+1, F2[3]; P_P+1, F2[3];%INTERRUPTS CURRENTLY NOT INHIBITED DURING KRMW_	KRMW_NULL, INHINT;	REPEAT[13,ILC[(Q_Q)]];	KWRESTART;%	DGOTO[.+1], P_P+1;	DGOTO[.+2], P_P+1, ARM_NULL;	P_NPC_NPC;	GOTO[.+1], P_P+1, INHINT;	GOTO[DGIEND], ARM_NULL, INHINT;INTX:	SETF[H], Q_NULL;	*INTERRUPT SHOULD OCCUR AFTER THIS INSTR.	BREAK;			*INTERRUPT FAILED TO OCCUR*INTERRUPT COMES BACK HERE WITHOUT PREIRET SO PRECISELY ONE INSTRUCTION*SHOULD OCCUR.	H=0 ON THE RETURN.INT1:	SETF[J];	BREAK;			*INTERRUPT FAILED TO OCCUR*INTERRUPT COMES BACK HERE WITH PREIRET AND K=1 WHEN J=1INT2:	BREAK;			*SHOULD NOT BE EXECUTED SINCE PREIRET				*WAS USED.INTY:	Y_L7_A1, SETF[K];	BREAK;			*INTERRUPT DIDN'T OCCUR%"INTROU" IS THE INTERRUPT ROUTINE FOR CHANNEL 17 (LOCATION 17 IS ITSINTERRUPT LOCATION) AND SHOULD ONLY BE ENTERED DURING THE INTERRUPT TEST."INTROU" BREAKS IF IENABLE=0, IF INT=0, OR IF THE INTERRUPT CHANNEL IS#17 IN ARM.  THEN IT GOES TO EITHER INTA, INTB, INTC, OR INTD DEPENDINGUPON THE BRANCH CONDITIONS H=1, J=1, K=1, OR NONE OF THESE.  THEINTERRUPT ROUTINE ALSO STORES THE COMPLEMENT OF L7 IN X, Y, AND P ANDPUTS THIS VALUE THROUGH THE ALU AND ONTO THE BUS BEFORE RETURNING SO THATTHE PRESERVATION OF REGISTERS AND BRANCH CONDITIONS ACROSS INTERRUPTSCAN BE VERIFIED.%INTROU:	SETSF[IENABLE&G], Q_ARM;	Q_(NOT Q) U (377700 000000S), GOTO[.+2,G=1];	BREAK;			*INTERRUPT OCCURRED WHEN IENABLE=0	Q_NOT Q, CALL[PQCOMP], P_400000 000001S; *ARM REG. SET IMPROPERLY.  WRONG RESULT IN Q.	GOTO[INTA, H=1], CLEARF[H], Q_L7;	GOTO[INTB,J=1], CLEARF[J];	GOTO[INTC,K=1], CLEARF[K];	SETSF[XCT0&G];	GOTO[.+2,G=1];	BREAK;	*INTERRUPT OCCURRED AT UNANTICIPATED PLACE*XCT0 SIGNALS TEST OF STACK*STK 1 SHOULD BE EQUAL TO "STEMP" AND STK 0 TO "STEMP1". CHECK.	P_STACK;	Q_STEMP1, CALL[PQCOMP]; *INTERRUPT FROM WRONG ADDRESS	POP;	P_STACK;	Q_STEMP, CALL[PQCOMP]; *TOP OF STACK CLOBBERED BY ONSET OF INTERRUPT	P_STEMP1;	B_P+1, NPC_B; *RETURN TO PLACE OF INTERRUPT +1 TO AVOID CONFUSION		*OF NO INTERRUPT OCCURRING AT ALL WITH SUCCESSFUL INTERRUPT	IRET, POP; *ABSENCE OF PREIRET SHOULD INSURE ONE NON-INT		*INSTRUCTION BEFORE ANOTHER INTERRUPT OCCURS.INTA:	CALL[XBCT]; *CALL DIAG TO CHECK PROCESSOR OPERATION DURING INTER.	IRET, GOTO[INT1], P_P1, B_NOT Q, POP;INTB:	CALL[XBCT]; *CALL DIAG	SETF[K];	PREIRET, POP;	IRET, P_P1, B_NOT Q, GOTO[INT2];INTC:	CALL[XBCT];	*CALL DIAG	POP;	IRET, P_P1, RETURN; *TO INTX+1 OR INTY+1%INCLUDE THE DIAGNOSTICS OF X, Y, ALU HERE TO VERIFY THAT FUNCTIONS STILLWORK DURING INTERRUPTS.	THE ONLY FUNCTIONS WHICH DO NOT WORK DURINGINTERRUPTS ARE AS FOLLOWS:	FRZBALUBC;	B>=0 AND B<0 BRANCH CONDITIONS;	PQ RCY [44-Y];	P1_P;%*X>=0 AND X<0 BC TESTSXBCT:	X_NULL;	GOTO[.+2,X>=0];	BREAK;			*X>=0 FAILED ON 0 OR X[28] FAILED	CALL[CBRK,X<0];	 *X<0 FAILED ON 0 OR X[28] FAILED	X_A1;	GOTO[.+2,X<0];	BREAK;			*X<0 FAILED ON 377 OR X[28] FAILED	CALL[CBRK,X>=0];	*X>=0 FAILED ON 377 OR X[28] FAILED	P_NULL;	Q_P+1, CALL[QLCY7];	X_Q;	GOTO[.+2,X<0];	BREAK;		*X<0 BC FAILED ON 200	CALL[CBRK,X>=0];	*X>=0 FAILED ON 200*Y>=0 AND Y<0 BC TESTSYBCT:	Y_NULL;	GOTO[.+2,Y>=0];	BREAK;			*Y>=0 FAILED ON 0 OR Y[27] FAILED	CALL[CBRK,Y<0], X_A1; *Y<0 FAILED ON 0 OR Y[27] FAILED	Y_A1;	GOTO[.+2,Y<0];	BREAK;			*Y<0 FAILED ON 777 OR Y[27] FAILED	CALL[CBRK,Y>=0];	*Y>=0 FAILED ON 777 OR Y[27] FAILED	Y_X;	GOTO[.+2,Y>=0];	BREAK;			*Y>=0 FAILED ON 377 OR Y STORAGE FAILED	CALL[CBRK,Y<0], INCY;	*Y<0 FAILED ON 377	GOTO[.+2,Y<0];	BREAK;			*Y<0 FAILED ON 400 OR INCY FAILED OR				*X STORAGE FAILED OR Y STORAGE FAILED ON 377	CALL[CBRK,Y>=0];	*Y>=0 FAILED ON 400*TEST INCX AGAINST INCYIXIYT:	X_NULL;	Y_NULL;IXIYL:	P_X;	Q_Y, CALL[PQCOMP];	*X_B, Y_B, INCX, OR INCY FAILED	INCY, DGOTO[.+3];	INCX, GOTO[IXIYL,Y>=0];	BREAK;			*GOTO[Y>=0] OR DGOTO[ALWAYS] FAILED	P_X, CALL[PZT];	 *INCY FAILED COUNTING 0 TO 400*TEST INCY AGAINST P+1	Y_P_NULL, GOTO[IYP2];IYP1:	P#Q;	GOTO[.+2,ALU=0], P_B, B_P+1, INCY;	BREAK;			*CARRY1=F2 OR ALUF=37 (P) OR P_P1 FAILEDIYP2:	GOTO[IYP1,Y>=0], Q_Y;IYP3:	P#Q;	GOTO[.+2,ALU=0], INCY, P_B, B_P+1;	BREAK;			*CARRY1=F2 OR ALUF = 37 OR P_P1 FAILED	GOTO[IYP3,Y<0], Q_Y;	AQ, CALL[AZT];		*INCY FAILED GOING 777 TO 0*ALU CHECKOUT OF ONE FUNCTIONANDT:	P_Q_NULL;	Q_P AND Q, CALL[AZT];	*AND FAILED ON 0,0	Q_A1;	Q_P AND Q, CALL[AZT];	*AND FAILED ON P=0, Q=-1	P_B, B_A1;	Q_NULL;	Q_P AND Q, CALL[AZT];	*AND FAILED ON P=-1, Q=0	P_Q_B, B_A1;	P_B, B_P AND Q;	Q_P+1, CALL[AZT];	*AND FAILED ON -1,-1*TEST ALU BRANCH CONDITIONSALUBC:	A0;	CALL[CBRK,ALU#0], A0;	*ALU#0 FAILED ON FALSE	GOTO[.+2,ALU=0];	BREAK;			*ALU=0 FAILED ON TRUE	Q_A1;	Q RSH 1;	B_AQ, P_B;	GOTO[.+2,ALU>=0], AQ;	BREAK;			*ALU>=0 BC FAILED ON TRUE	CALL[CBRK,ALU<0];	*ALU<0 BC FAILED ON FALSE	Q_P+1;	GOTO[.+2,ALU<0], AQ;	BREAK;			*ALU<0 BC FAILED ON TRUE	CALL[CBRK,ALU>=0];	*ALU>=0 BC FAILED ON FALSE	P_NULL;	Q_P+1;ALUGLP:	GOTO[.+2,ALU>0], AQ;	BREAK;			*ALU>0 BC FAILED ON TRUE VALUE IN Q	CALL[CBRK,ALU<=0], AQ;	*ALU<=0 BC FAILED ON FALSE VALUE IN Q	GOTO[.+2,ALU#0], AQ;	BREAK;			*ALU#0 BC FAILED ON TRUE VALUE IN Q	CALL[CBRK,ALU=0];	*ALU=0 BC FAILED ON FALSE	Q LSH 1;	AQ;	GOTO[ALUGLP,ALU>=0], AQ;	GOTO[.+2,ALU<=0], AQ;	BREAK;			*ALU<=0 BC FAILED ON 400000 000000	GOTO[.+2,ALU#0];	BREAK;			*ALU#0 BC FAILED ON TRUE VALUE IN Q	CALL[CBRK,ALU>0], A0;	*ALU>0 BC FAILED ON 400000 000000	GOTO[.+2,ALU<=0], A0;	BREAK;			*ALU<=0 BC FAILED ON 0	CALL[CBRK,ALU>0];	*ALU>0 BC FAILED ON 0ALU8T:	P_A0;	GOTO[.+2,ALU8=0], A0;	BREAK;			*ALU8=0 FAILED ON 0	CALL[CBRK,ALU8=1],A1;	*ALU8=1 FAILED ON 0	GOTO[.+2,ALU8=1], A1;	BREAK;			*ALU8=1 FAILED ON -1	CALL[CBRK,ALU8=0];	*ALU8=0 FAILED ON -1	Q_P+1, CALL[QLCY33];	AQ;	GOTO[.+2,ALU8=1], AQ;	BREAK;			*ALU8=1 FAILED ON 1000 000000	CALL[CBRK,ALU8=0], Q_NOT Q; *ALU8=0 FAILED ON 1000 000000	GOTO[.+2,ALU8=0], AQ;	BREAK;			*ALU8=0 FAILED ON 776777 777777	CALL[CBRK,ALU8=1];	*ALU8=1 FAILED ON 776777 777777*NOW TEST LOADING Y FROM BUS.	(Y_NULL WAS TESTED EARLIER)YBUST:	Y_P_NULL;	Q_Y, CALL[PQCOMP];	*Y_0 FAILED	P_Y_B, B_P+1;	Q_Y, CALL[PQCOMP];	*Y_1 FAILED	REPEAT[10,ILC[(P_Y_B, B_2P)] ILC[(Q_Y, CALL[PQCOMP])]];	Q_A1;	Q LSH 1, CALL[YBT1];	*Y_776 FAILED	Q LSH 1;	Q LCY 1, CALL[YBT1];	*Y_775 FAILED	Q LSH 1, CALL[QLCY2];	CALL[YBT1];	*Y_773 FAILED	Q LSH 1, CALL[QLCY2];	Q LCY 1, CALL[YBT1];	*Y_767 FAILED	Q LSH 1, CALL[QLCY3];	Q LCY 1, CALL[YBT1];	*Y_757 FAILED	Q LSH 1, CALL[QLCY4];	Q LCY 1, CALL[YBT1];	*Y_737 FAILED	Q LSH 1, CALL[QLCY5];	Q LCY 1, CALL[YBT1];	*Y_677 FAILED	Q LSH 1, CALL[QLCY6];	Q LCY 1, CALL[YBT1];	*Y_577 FAILED	Q LSH 1, CALL[QLCY7];	Q LCY 1, CALL[YBT1];	*Y_377 FAILED	GOTO[XBUST];YBT1:	B_Q, Y_P_B, Q_A1, CALL[Q11];	Q_P AND Q, P_Y, CALL[PQCOMP];	* Y FAILED AT [STK 1]	Q_A1, RETURN;XBT1:	B_Q, X_P_B, Q_A1, CALL[Q10];	Q_P AND Q, P_X, CALL[PQCOMP];	*X FAILED AT [STK 1]	Q_A1, RETURN;*NOW TEST OUT LOADING X FROM BUS.	(X_NULL TESTED EARLIER)XBUST:	X_P_NULL;	Q_X, CALL[PQCOMP];	*X_0 FAILED	P_X_B, B_P+1;	Q_X, CALL[PQCOMP];	*X_1 FAILED	REPEAT[7,ILC[(P_X_B, B_2P)] ILC[(Q_X, CALL[PQCOMP])]];	Q_A1;	Q LSH 1, CALL[XBT1];	*X_376 FAILED	Q LSH 1;	Q LCY 1, CALL[XBT1];	*X_375 FAILED	Q LSH 1, CALL[QLCY2];	CALL[XBT1];	*X_373 FAILED	Q LSH 1, CALL[QLCY2];	Q LCY 1, CALL[XBT1];	*X_367 FAILED	Q LSH 1, CALL[QLCY3];	Q LCY 1, CALL[XBT1];	*X_357 FAILED	Q LSH 1, CALL[QLCY4];	Q LCY 1, CALL[XBT1];	*X_337 FAILED	Q LSH 1, CALL[QLCY5];	Q LCY 1, CALL[XBT1];	*X_277 FAILED	Q LSH 1, CALL[QLCY6];	Q LCY 1, CALL[XBT1];	*X_177 FAILED*NOW TEST OUT DECYDECYT:	P_Y_NULL, CALL[Q11], Q_A1;	DECY, P_B, B_Q;	Q_Y, CALL[PQCOMP], DECY;	GOTO[.-1,Y<0], P_B, B_P-1;	Q_Y, CALL[PQCOMP], DECY;	GOTO[.-1,Y>=0], P_B, B_P-1;	INCY;	Q_Y, CALL[QZT];	 *DECY FAILED GOING 0 TO 777*TEST OF DECXDECXT:	P_X_NULL, Q_A1, CALL[Q10];	DECX, P_B, B_Q;	Q_X, DECX, CALL[PQCOMP];	*DECX FAILED	GOTO[.-1,X<0], P_B, B_P-1;	Q_X, DECX, CALL[PQCOMP];	GOTO[.-1,X>=0], P_B, B_P-1;	INCX;	Q_X, CALL[QZT];	 *DECX FAILED GOING 0 TO 377*XTOP BUS SOURCE PUTS X[30,35] ONTO B[0,5]XTOPT:	Q_A1, CALL[Q6];	*Q_77	X_Q, CALL[QLCY36];	P_XTOP, CALL[PQCOMP];	*XTOP FAILED ON 77 IN X.	WRONG VALUE IN P	INCX;	Q_XTOP, CALL[QZT];	*XTOP FAILED ON 100 IN X.	WRONG VALUE IN Q*YSHIFT_ LOADS Y[27] FROM B[18] AND Y[28,35] FROM B[28,35]YSHIFTT:	P_NULL;	Q_P+1, CALL[QLCY21];	YSHIFT_Q, CALL[Q33];	P_Y, CALL[PQCOMP];	*P SHOULD HAVE 400 IN IT.	YSHIFT_ FAILED	P_NULL;	Q_P+1, CALL[QLCY21];	YSHIFT_Q_NOT Q, CALL[Q10];	P_Y, CALL[PQCOMP];	*P SHOULD HAVE 377 IN IT.	YSHIFT_ FAILED*YKPTR_ IS SUPPOSED TO LOAD Y FROM 400 + B[41,43]*20TYKPTR:	P_NULL;	B_Q_P+1, P_B;	B_2P+1, P_B, Q LCY 1, DGOTO[YKP1];	B_2P+1, P_B, Q LCY 1, CALL[QLCY2];*P_7, Q_20 NOWYKPLP:	CALL[PQCOMP], R7_P-1, P_Y, Q LCY 1;	P_R7, Q_STEMP;YKP1:	YKPTR_P;	DGOTO[YKPLP,ALU>=0], Q_P+Q, STEMP_Q;	Q LCY 1, P_B, B_P, CALL[QLCY2];*TEST ADDRESSING FROM X AND DATA STORAGE OF BOTH LB AND RBLRXT:	Y_Q_17S, P_A0; *Y HOLDS 17 DURING THE LM AND RM TESTS	Q_P+1;*FIRST TEST THE REGISTERS ON THE 44 PATTERNS WHICH CONTAIN A SINGLE 1*WITH 43 ZEROES.	THE PATTERN IS LCY'ED 1 IN PASSING FROM REGISTER TO*REGISTER.	X_Y, CALL[LRBT1];	*RETURN FROM LRBT1 WITH ORIGINAL Q RCY 1	GOTO[.-1,Q EVEN];*NOW TEST 44 PATTERNS OF A SINGLE 0 WITH 43 1'S	Q_NOT Q;	X_Y, CALL[LRBT1];	*RETURN FROM LRBT1 WITH ORIGINAL Q RCY 1	GOTO[.-1,Q ODD];*[X]>17 IS REALLY A DON'T CARE FOR LINDX	GOTO[SMTEST];*FILL THE LOWER 20 REGISTERS OF RM, ADDRESSING FROM XLRBT1:	RX_Q, Q LCY 1, DECX, P_17S;	GOTO[LRBT1,X>=0];*FILL THE LOWER 20 REGISTERS OF LM, ADDRESSING FROM X	X_Y;LRBT2:	LX_Q, Q LCY 1, DECX, P_17S;	GOTO[LRBT2,X>=0];*AT THIS POINT THE ORIGINAL VALUE IN Q HAS BEEN LCY'ED AFTER EACH OF 40*LOADS SO IT CAN BE RESTORED TO THE ORIGINAL VALUE BY LCYING 4 MORE TIMES.*NOW READ AND CHECK RM	Q LCY 1, CALL[QLCY3], X_Y;LRBTA:	P_RX, DECX, CALL[PQCOMP]; *RB[X-1] FAILED ON [Q]	GOTO[LRBTA,X>=0], Q LCY 1;*NOW READ AND CHECK LM	X_Y;LRBTB:	P_LX, DECX, CALL[PQCOMP]; *LB[X-1] FAILED ON [Q]	Q LCY 1, GOTO[LRBTB,X>=0];	Q LCY 1, GOTO[QLCY2]; *RETURN TO CALLER OF LRBT1 WITH ORIGINAL Q RCY 1*TEST OF SM*SUBROUTINE "SMTC" INITIALIZES ALL SM AND DM REGISTERS TO VALUES BEGINNING*WITH [R7] AND [Q] AND THEN CYCLED BY 1 FOR EACH SUCCESSIVE WORD.  AFTER*INITIALIZING ALL 2000-100 REGISTERS IT READS THEM BACK AND CHECKS FOR ERRORS.*DM[I] IS ALWAYS SET TO NOT[SM[I]].SMTC:	SY_Q, Q_NOT Q;	D_Q, Q_NOT Q, INCY;	Q LCY 1, GOTO[.-2,Y>=0];	SY_Q, Q_NOT Q;	D_Q, Q_NOT Q, INCY;	Q LCY 1, GOTO[.-2,Y<0];	Y_220S;SMTC0:	Q_R7, P_SY, CALL[PQCOMP]; *SY_B OR B_SY FAILEDSMTC1:	Q_NOT Q, P_D, CALL[PQCOMP], INCY; *D_B OR B_D FAILED	Q_NOT Q, DGOTO[.-1,Y>=0];SMTC2:	Q LCY 1, P_SY, CALL[PQCOMP]; *SY_B OR B_SY FAILEDSMTC3:	Q_NOT Q, P_D, CALL[PQCOMP], INCY; *D_B OR B_D FAILED	Q_NOT Q, DGOTO[.-1,Y<0];SMTC4:	Q LCY 1, P_SY, CALL[PQCOMP,Y<0]; *SY_B OR B_SY FAILED	Q_R7, RETURN;*TEST OF SM AND DM ADDRESSED FROM YSMTEST:	Y_P_220S, DGOTO[SMT0];	R7_Q_P+1, CALL[SMTC];	GOTO[SMT1,ALU<=0], R7_Q, Y_220S;	CALL[SMTC];SMT0:	GOTO[.-2], Q RCY 1, AQ;SMT1:	P_B, B_A1;	R7_Q_2P, CALL[SMTC];	AQ, Q LCY 1;	DGOTO[.-1,ALU<0];	CALL[SMTC], R7_Q, Y_220S;	GOTO[MPTEST];*SUBROUTINES TO FILL 2000 MAP ENTRIES WITH Q, Q LCY 1, Q LCY 2, ETC.*AND THEN READ BACK AND CHECK THE RESULTS.  ORIGINAL Q IS*RETURNED IN Q. [Y]=0, CUM=0, [P]=777777 AT CALL.MC[UM&CUM,UM,CUM];MPTCX:	Q_P AND Q, P_B, B_Q;	MAP_Q, Q_P, INCY;	Q LCY 1, GOTO[.-2,Y>=0], P_777777S;	Q_P AND Q, P_B, B_Q;	MAP_Q, Q_P, INCY, DGOTO[.-1];	Q LCY 1, P_777777S, RETURN[Y>=0];MPTCY:	R11_L7_P AND Q, Q LCY 1;	P_MAP, INCY, R10_Q, Q_L7, CALL[PQCOMP]; *[MAP] AT Y-1 WRONG	Q_R10, P_777777S, GOTO[.-2,Y>=0];	R11_L7_P AND Q, Q LCY 1, P_MAP, INCY;	R10_Q, Q_L7, CALL[PQCOMP];	*[MAP] AT Y-1 WRONG	Q_R10, P_777777S, GOTO[.-2,Y<0];	RETURN;*HERE WITH [Y]=0, 777777 IN P, AND NUMBER BASE IN R7MPTC:	CLEARF[CUM], CALL[MPTCX];	*MON. MAP WRITES	SETF[CUM], CALL[MPTCX];	*USER MAP WRITES	CLEARF[CUM], Q_R7, CALL[MPTCY]; *MON. MAP READS	SETF[CUM], GOTO[MPTCY];	*USER MAP READSMPTEST:	Y_P_NULL, CLEARF[UM&CUM];	Q_P+1, CALL[QLCY10];	CUM_Q, Q_A1, CALL[Q22];*TEST 18 PATTERNS OF A SINGLE 1 WITH 17 ZEROES AND 18 PATTERNS OF ALL ZEROES	777777S_Q, DGOTO[MPT0];	R7_Q_P+1, CALL[MPTC], P_777777S;MPT2:	GOTO[MPT1,ALU<=0], R7_Q, Y_NULL;	CALL[MPTC], P_777777S;MPT0:	Q LCY 1, AQ, GOTO[MPT2];*TEST 18 PATTERNS OF A SINGLE 0 WITH 17 1'S AND 18 PATTERNS OF 777777MPT1:	P_B, B_A1, DGOTO[MPT3];	R7_Q_2P, CALL[MPTC], P_777777S;MPT4:	GOTO[M4TEST,ALU>=0], R7_Q, Y_NULL;	CALL[MPTC], P_777777S;MPT3:	Q LCY 1, AQ, GOTO[MPT4];*M4CHK CALLED WITH Y, CUM, AND Q LOADED WITH SOME VALUES.  IT PERFORMS*MAP4_ AND CHECKS IT.  LH[Q] MUST BE 0M4CHK:	P_Y;	MAP4_Q, R7_Q;	REPEAT[4,ILC[(DECY)]];	Q_Y, CALL[PQCOMP];	*MAP4_ FAILED TO INCREMENT Y BY 4				*CORRECT VALUE IN P, WRONG VALUE IN Q	P_MAP, INCY, Q_R7, CALL[PQCOMP]; *MAP4_ FAILED ON 0TH WORD	P_MAP, INCY, Q_R7, CALL[PQCOMP]; *MAP4_ FAILED ON 1ST WORD	P_MAP, INCY, Q_R7, CALL[PQCOMP]; *MAP4_ FAILED ON 2ND WORD	P_MAP, INCY, Q_R7, GOTO[PQCOMP]; *MAP4_ FAILED ON 3RD WORD*RETURN WITH Y INCREMENTED BY 4, Q UNCHANGEDM4TX:	Q_Y_NULL, CALL[M4CHK];	Q_NULL, CALL[M4CHK];	GOTO[.-1, Y>=0];	Q_NULL, CALL[M4CHK];	GOTO[.-1,Y<0], Q_777777S;	Y_NULL, CALL[M4CHK];	Q_777777S, CALL[M4CHK];	GOTO[.-1,Y>=0];	Q_777777S, CALL[M4CHK];	GOTO[.-1,Y<0];	RETURN;M4TEST:	CLEARF[CUM], CALL[M4TX];	SETF[CUM], CALL[M4TX];***PQ RCY [Y] NOT TESTED	RETURN; *RETURN FROM DIAG TO MAKE INTERRUPT RETURNDGIEND:	INHINT, P_COUNT;	Q_P+1, INHINT;	COUNT_Q, INHINT, GOTO[MCYCLE];IM[ILC,ADD[IP[ILC],-1]];