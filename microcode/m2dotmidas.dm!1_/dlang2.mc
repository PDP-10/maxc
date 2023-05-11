BUILTIN[M,2];		*DECLARE MACROBUILTIN[N,3];		*DECLARE NEUTRALBUILTIN[MEMORY,4];	*DECLARE MEMORYBUILTIN[TARGET,5];BUILTIN[DEFAULT,6];BUILTIN[F,7];		*DECLARE FIELDBUILTIN[PF,10];		*PREASSIGN VALUE TO FIELDBUILTIN[SET,11];	*DECLARE INTEGER AND SET VALUEBUILTIN[ADD,12];	*ADD UP TO 8 INTEGERSBUILTIN[IP,13];		*INTEGER PART OF ADDRESSBUILTIN[IFSE,14];	*IF STRING EQUALBUILTIN[IFA,15];	*IF ANY BITS OF FIELD ASSIGNEDBUILTIN[IFE,16];	*IF INTEGERS EQUALBUILTIN[IFG,17];	*IF INTEGER 1 > INTEGER 2BUILTIN[IFDEF,20];	*IF SYMBOL IN SYMBOL TABLE & NOT UNBOUND ADDRESSBUILTIN[IFME,21];	*IF MEMORY PART OF ADDRESS = STRINGBUILTIN[ER,22];		*TYPE ERROR MESSAGEBUILTIN[LIST,23];	*SET LISTING MODE FOR MEMORYBUILTIN[INSERT,24];	*INSERT FILEBUILTIN[NOT,25];	*1'S COMPLEMENTBUILTIN[REPEAT,26];	*REPEAT THE TEXT #2 #1 TIMESBUILTIN[OR,27];		*INCLUSIVE OR UP TO 8 INTEGERSBUILTIN[XOR,30];	*EXCLUSIVE OR UP TO 8 INTEGERSBUILTIN[AND,31];	*AND UP TO 8 INTEGERSBUILTIN[COMCHAR,32];	*SET COMMENT CHAR FOR CONDITIONAL ASSEMBLIES*BUILTIN[BITTABLE,33];	*#1 = TABLE, #2 = LENGTH*BUILTIN[GETBIT,34];	*#1 = TABLE, #2 = INDEX (0 TO LENGTH-1)*BUILTIN[SETBIT,35];	*#1 = TABLE, #2 = FIRSTBIT, #3 = NBITS,			*#4 = DISTANCE (DEF 1), #5 = VALUE (0 OR 1 DEF 1)*BUILTIN[FINDBIT,36];	*#1 = TABLE, #2 = FIRSTBIT, #3 = NUM 0 BITS NEEDED,			*#4 = DIST BETWEEN BITS, #5 = HOP DIST, #6 = NHOPS*BUILTIN[MEMBT,37];	*#1 = MEMORY, #2 = TABLE (UNIMPLEMENTED)*BUILTIN[LSHIFT,40];	*INTEGER RESULT = #1 LSHIFT #2*BUILTIN[RSHIFT,41];	*INTEGER RESULT = #1 RSHIFT #2*BUILTIN[FVAL,42];	*INTEGER RESULT = CONTENTS OF FIELD #1 IN WORD BEING			*ASSEMBLED*BUILTIN[SELECT,43];	*EVALUATE ARG #1+1%MEMORY DECLARATIONS MUST HAVE NAMES AND SIZES AGREEING WITH THOSE IN MIDAS.***MIDAS REQUIRES MEMORIES < 44 BITS WIDE TO BE CREATED AS 44-BIT MEMORIES.%MEMORY[LDR,120,600,LDSRC,LDSINK];MEMORY[SM,44,1000,SSRC,SSINK];MEMORY[LM,44,40,LSRC,LSINK];MEMORY[RM,44,40,RSRC,RSINK];*PRINCIPAL LOCATION COUNTERS FOR MEMORIESLDR[LDRLC,0];*LDR MEMORY FIELD DEFINITIONSF[BT,0,1];		*BRANCH TYPEF[C,2,6];		*BRANCH CONDITIONF[LA,7,13];		*LEFT BANK ADDRESSF[RA,14,20];		*RIGHT BANK ADDRESSF[PS,21,26];		*P INPUT SELECTF[QS,27,31];		*Q INPUT SELECTF[A,32,36];		*ALU FUNCTION SELECTF[O,37,43];		*BUS SOURCEF[T,44,50];		*BUS DESTINATIONF[Z,51,56];		*FUNCTION 1F[F2,57,62];		*FUNCTION 2F[SA,63,72];		*SCRATCH MEMORY ADDRESSF[SCP,73,73];		*SCOPE TRIGGERF[EIC,100,100];		*ENABLE INSTRUCTION CONTROLLED CHANGESF[EB,101,101];		*ENABLE BUS AND ALU BC CHANGESF[EIMA,102,102];	*ENABLE CHANGES IN IMAF[ENPC,103,103];	*ENABLE CHANGES IN NPCF[NOTSS,104,104];	*IF ZERO, CLEAR RUN ONE CYCLE AFTER SETTINGF[SETRUN,105,105];	*SET RUNF[RESET,106,106];	*RESET MEMORY INTERFACEF[XPIR,107,107];	*IF ONE, EXECUTE INSTRUCTIONS FROM ALTO;			*IF ZERO, EXECUTE FROM IMF[REGTOB,110,110];	*PUT THE BUS REGISTER ON THE PROCESSOR BUSF[INTON,111,111];	*ENABLE PROCESSOR INTERRUPTSF[STROBE,112,112];	*ALTO-TO-MAXC PROCESSOR STROBE%BRANCH MACROS"@" IS FOR A TYPE CHECK.  MACROS ACCEPTING C ARGUMENTSINSERT THE "@" IN FRONT OF THE NAME SUPPLIED BY THE PROGRAM.IF THE C ARG IS OMITTED, SET C=ALWAYS.%M[CALL,BT[0] IFSE[#1,,@A,@#1]];M[GOTO,BT[1] IFSE[#1,,@A,@#1]];M[RETURN,BT[2]];M[DGOTO,BT[3] IFSE[#1,,@A,@#1]];%BRANCH CONDITIONS<C+20> IS THE COMPLEMENT OF C.  0 (NEVER) AND 20 (ALWAYS) ARE GIVENIMPLICITLY, NEVER EXPLICITLY.  THE DEFAULT FOR IM IS C = NEVER.GOTO, DGOTO, CALL, OR RETURN SET C=ALWAYS IF NO C ARGUMENT ISWITH THE CALL.  THE EXTRA CHARACTER "@" IS PROVIDED SO THAT ANARGUMENT TYPE CHECK CAN BE MADE.%M[@A,C[20]];		M[@NEVER,C[0]];M[@ALU#0,C[21]];	M[@ALU=0,C[1]];M[@ALU>=0,C[22]];	M[@ALU<0,C[2]];M[@ALU>0,C[23]];	M[@ALU<=0,C[3]];M[@ALU8=1,C[24]];	M[@ALU8=0,C[4]];M[@B>=0,C[25]];		M[@B<0,C[5]];M[@X>=0,C[26]];		M[@X<0,C[6]];M[@Y>=0,C[27]];		M[@Y<0,C[7]];M[@QEVEN,C[30]];	M[@QODD,C[10]];M[@G=1,C[31]];		M[@G=0,C[11]];M[@H=1,C[32]];		M[@H=0,C[12]];M[@J=1,C[33]];		M[@J=0,C[13]];M[@K=1,C[34]];		M[@K=0,C[14]];M[@NEWWORD,C[36]];	M[@OLDWORD,C[16]];*BC'S 15, 17, 35, AND 37 UNUSED*ALU FUNCTION SELECTM[P-1,A[0]U];M[P-NJ,(A[0],CJ&SJC)U];M[2P,A[3]U];M[2P+1,(A[3],CARRY1)U];M[2P+J,(A[3],CJ&SJC)U];M[P AND NOT Q - 1,A[4]U];M[P-Q-1,A[6]U];    *=P+NOT QM[P-Q-NJ,(A[6],CJ&SJC)U];M[P-Q,(A[6],CARRY1)U];*M[P AND NOT Q + P,A[7]U];M[P AND Q - 1,A[10]U];M[P + Q,A[11]U];M[P+Q+1,(A[11], CARRY1)U];M[P+Q+J,(A[11], CJ&SJC)U];*M[P AND Q + P,A[13]U];M[P+1,(A[17], CARRY1)U];M[P+J,(A[17], CJ&SJC)U];M[NOT P,A[20]U];M[NOT P AND Q,A[21]U];M[NOT P AND NOT Q,A[22]U];M[A0,A[23]U];		***0 NOT POSSIBLE--CONFUSED WITH INTEGERM[NOT P OR Q,A[24]U];M[AQ,A[25]U];		*** Q IS AMBIGUOUS AND IS DEFINED WITH BUS SOURCESM[P=Q,A[26]U];M[P AND Q,A[27]U];M[NOT P OR NOT Q,A[30]U];M[P#Q,A[31]U];M[NOT Q,A[32]U];M[P AND NOT Q,A[33]U];M[A1,A[34]U];		*** -1 NOT POSSIBLE--CONFUSED WITH INTEGERM[P OR Q,A[35]U];M[P OR NOT Q,A[36]U];M[P,A[37]U];N[U]; N[Q];		*THE ALU AND THE Q-REGISTER ARE OBJECT CLASSES%THE LEGAL CYCLER STATEMENTS ARE:   PQ RCY [Y]         WHERE 0 <= [Y] <= 44 OR G GETS SET   PQ RCY [44-Y]   PQ RCY [INTEGER]   WHERE 0 <= INTEGER <= 46   PQ LCY [INTEGER]   WHERE 0 <= INTEGER <= 3   LB LSH [INTEGER]   WHERE 0 <= INTEGER <= 3   LB RSH [INTEGER]   RB LSH [INTEGER]   RB RSH [INTEGER]AND ALSO EACH OF THE ABOVE WITH "PQ" REPLACED BY "0Q", "QQ", OR "NOTUQ".%M[PQ RCY, IFSE[#1,Y,PS[1],IFSE[#1,44-Y,PS[2],PS[XOR[77,#1]]CHK[46,#1]]]CY?];M[QQ RCY,(PQ RCY [#1], RCYQQ)];M[0Q RCY,(PQ RCY [#1],RCY0Q)]; *ONLY USED IMPLICITLYM[NOTUQ RCY,Z[7] PQ RCY [#1]]; *ONLY USED IMPLICITLYM[PQ LCY,PS[XOR[77,ADD[74,-#1]]]CHK[3,#1]CY?]; *ONLY USED IMPLICITLYM[QQ LCY,(PQ LCY [#1], RCYQQ)];M[0Q LCY,(PQ LCY [#1],RCY0Q)];M[NOTUQ LCY,Z[7] PQ LCY [#1]];*MACRO TO GIVE ERROR IF #2 > #1 OR #2 < 0.M[CHK,IFG[#2,#1,ER[CY?],IFG[0,#2,ER[CY?]]]];N[LB]; N[RB]; N[P_]; N[P1];N[CY?]; N[P_CY?];M[P_LB,PS[21]LB];M[P_RB,PS[12]RB];M[LB LSH,PS[XOR[77,ADD[56,-#1]]]CHK[3,#1]CY?];M[LB RSH,PS[XOR[77,ADD[56,#1]]]CHK[3,#1]CY?];M[RB LSH,PS[XOR[77,ADD[65,-#1]]]CHK[3,#1]CY?];M[RB RSH,PS[XOR[77,ADD[65,#1]]]CHK[3,#1]CY?];M[P_B,PS[30]B];		M[P_BN,PS[30]BN];M[P_SS,PS[30]SS];	M[P_SSN,PS[30]SSN];M[P_$,PS[30]SB];	M[P_H$,PS[30]HSB];M[P_P1,PS[27]?];M[P_U,PS[26]U];M[U ARSHC 1,PS[25]CY?];M[P_Q,PS[33]Q];		*USES THE CYCLER PQ RCY [44] BUT			***BEWARE IF RCYQQ, RCY0Q, OR RCY NOTUQ*Q INPUT SELECTIONM[Q_LB,QS[0]LB];M[Q_RB,QS[4]RB];M[Q_U,QS[2]U];M[Q_B,QS[7]B];		M[Q_BN,QS[7]BN];M[Q_SS,QS[7]SS];	M[Q_SSN,QS[7]SSN];M[Q_$,QS[7]SB];		M[Q_H$,QS[7]HSB];M[Q_Q,QS[5]Q];M[RB RCY 1,QF(QS[6] RCYQQ)];	***TOO CLEVER? (ALSO SEE BELOW)M[RB RSH 1,QS[6]QF?];M[Q RSH 1,QS[3]QF?];M[Q RCY 1,QF(QS[3] RCYQQ)];M[Q LSH 1,QS[1]QF?];M[Q LCY 1,QF(QS[1] RCYQQ)];N[Q_]; N[QF?]; N[Q_QF?];*MAINTENANCE INTERFACE STUFFM[BR,REGTOB[1]SSN];N[?];		*FOR ERROR CHECK WHEN Z OR F2 USED AS A SOURCEN[$-SA??];	*FOR ERROR CHECK WHEN NON-SM ADDRESS USED*FUNCTIONS REALIZED BY BOTH Z AND F2M[NOF2,F2[10]];	*NO FUNCTIONM[SETSF,IFA[F2,Z[1],F2[11]](#1)-SA??];***NOTE THAT KNEWCOMM IS ALSO Z[22] AND F2[5]*READS=Z[22]=F2[5]=KNEWCOMM NEVER GIVEN EXPLICITLY, ONLY USED BY SB,*ASB, AND QLS MACROS.M[KNEWCOMM,IFA[F2,Z[22],F2[5]]];*LOADS=Z[61]=F2[6] NEVER GIVEN EXPLICITLY, ONLY USED BY SSINK*NOTE THAT RCY0Q AND RCYQQ PREVENT US FROM USING PQ RCY 0 AS THE DEFAULT*LOADING RULE FOR THE P REGISTER.  HENCE CHANGE TO P_P1.M[RCY0Q,IFA[F2,Z[6],F2[12]]];M[RCYQQ,IFA[F2,Z[50],F2[15]] PF[PS,27]?];M[CARRY1,IFA[F2,Z[20],F2[13]]?];M[POP,IFA[F2,Z[67],F2[16]]?];M[WRESTART,IFA[F2,Z[42],F2[7]]?];*F2 ONLYM[ASHOVF,F2[14]?];M[ACFS,F2[17]?];M[INHINT,F2[0]?];M[NPC_,F2[1]B_];               *AUTOMATICALLY INHIBITS INTERRUPTS*FUNCTIONS REALIZED ONLY BY ZM[NOZ,Z[0]];*SETSF=Z[1]=F2[11]M[YKPTR_,Z[2]B_];M[SIGNOVA,Z[3]?];M[SETHOVF,Z[4]?];M[SETOVPC01,Z[5]?];*RCY0Q=Z[6]=F2[12]*RCYNOTALUQ=Z[7] USED ONLY IMPLICITLY BY NOT(ALU FUNCTION)Q RCY [INTEGER]*AND NOT(ALU FUNCTION)Q LCY [INTEGER].M[IREF,Z[10]?];*11 UNUSEDM[RREF,Z[12]?];M[RREFDXK,Z[13]?];M[RMWREF,Z[14]PF[F2,0]];	*INHINT NOT FORCED BECAUSE OF DGOTO, NPC_M[RMWREFDXK,Z[15]PF[F2,0]];	*INHINT NOT FORCED BECAUSE OF DGOTO, NPC_M[WREF,Z[16]?];M[WREFDXK,Z[17]?];*CARRY1=Z[20]=F2[13]M[CJ&SJC,Z[21]?];*READS=Z[22]=F2[5]=O[6]*KNEWCOMM=READS ALSO A F2 BUT NOT A BUS SOURCEM[INCY,Z[23]?];M[DECY,Z[24]?];M[NEGY,Z[25]?];M[ARM,Z[26]B];			*B[20,35]_ARM, B[14,17]_INTNO, B[0]_INT*READSH=Z[27]=O[17] ONLY USED BY HSB AND HASB MACROSM[INCX,Z[30]?];M[DECX,Z[31]?];M[INCAC,Z[32]?];M[DECAC,Z[33]?];M[SETF,Z[34](#1)-SA??];M[SETFC,(Z[35] PF[BA,Y.+1] @#2)(#1)-SA??];M[CLEARF,Z[36](#1)-SA??];M[CLEARFC,(Z[37] PF[BA,Y.+1] @#2)(#1)-SA??];*Z=40 UNUSEDM[MDRL_,Z[41]B_];*WRESTART=Z[42]=F2[7]M[KMDRL_,Z[43]B_];M[KWRESTART,Z[44]?];M[KRDATA,Z[45]SS];M[KWDATA,Z[46]B];M[XREF,Z[47]?];*RCYQQ=Z[50]=F2[15]*DEFAULT PS IS PQ RCY [0] WHICH  DOES NOT CHANGE P UNLESS RCYQQ OR RCY0Q*OCCURS, IN WHICH CASE CHANGE TO P_P1.***INTERRUPT ROUTINES BEWARE OF CLOBBERING P WHEN USING RCYQQ OR RCY0Q.M[LDPALUH,Z[51]?];		*DON'T LOAD P IF ALU0=HM[Q35ALUG,Z[52]?];		*Q35_(ALU0#G) IF Q LSH 1*READALU=Z[53]=O[25] ALWAYS USED IMPLICITLY*BA IS COMPLEMENTED BY THE LOADERM[BAMASK,Z[54] BA[XOR[#1,77]] ?];M[SAMASK,Z[55] SA[#1] ?];M[XMASK,Z[56]?];M[AMASK,Z[57] A[#1] ?];*BAT=Z[60]=O[36] ONLY USED IN IB LITERALS*LOADS=Z[61]=F2[6]=T[6]M[ARM_,Z[62]B_];		*ARM[20,35]_B[20,35]M[SETFB,(Z[63] PF[BA,Y.+1] @#2)(#1)-SA??];M[PREIRET,Z[64]?];M[IRET,Z[65]?];M[FRZBALUBC,Z[66]?];*POP=Z[67]=F2[16]M[BAX,BA[ADD[NOT[#1],10000]] IFA[Z,O[37],Z[70]] ?];M[SAX,Z[71] SA[#1] ?];*72 UNUSEDM[AX,Z[73] A[XOR[37,#1]] ?];*74-77 UNUSED%BUS CONNECTION MACROSEACH CLASS OF OBJECTS FOR THE MICROPROCESSOR IS REPRESENTED BY A NEUTRALSYMBOL, AND THE LEGAL CONNECTIONS OF THESE CLASSES (BY "_" OR BY "U")ARE REPRESENTED BY MACROS WHICH REDUCE TO A NEUTRAL SYMBOL.  ILLEGALCONNECTIONS ARE NOT DEFINED AND CAUSE ERRORS.  CONNECTION TO THE BUSIS COMPLICATED BY THE LARGE NUMBER OF COMBINATIONS OF OBJECT CLASSESWHICH CONNECT TO THE BUS.  THESE ARE LISTED BELOW:   U	THE ALU LEAVES THIS NEUTRAL SYMBOL BEHIND   $	SM ADDRESSES < 400 LEAVE THIS NEUTRAL SYMBOL BEHIND   H$	SM ADDRESSES >= 400 LEAVE THIS NEUTRAL SYMBOL BEHIND   SS	SLOW SOURCES   B	FAST SOURCES   SSN	SLOW UNMERGABLE SOURCES   BN	FAST UNMERGABLE SOURCES   Q	Q REGISTER (SEPARATE CLASS BECAUSE OF AMBIGUOUS ROUTINGS)   P_	P REGISTER   Q_	Q REGISTER   B_	FAST DESTINATIONS   SD_	SLOW DESTINATIONSTHE CONNECTION MACROS HAVE TO BE FAIRLY COMPLICATED BECAUSE, WHILESOME CONNECTIONS CAN ONLY BE ACCOMPLISHED IN ONE WAY, OTHERS CAN BEACCOMPLISHED IN SEVERAL.  FOR EXAMPLE, THE SCRATCH MEMORY CAN BECONNECTED AS A BUS SOURCE USING EITHER THE O, Z, OR F2 FIELDS.  IT CANBE CONNECTED AS A BUS DESTINATION USING EITHER THE T, Z, OR F2 FIELDS.ALSO, THE ALU AND BAT CONSTANT CAN BE BUS SOURCES USING EITHER O OR Z,AND THE Q-REGISTER CAN BE CONNECTED TO THE BUS EITHER BY ROUTING ITTHROUGH THE ALU OR DIRECTLY.  NEARLY ALL THE OTHER BUS-CONNECTEDOBJECTS CONNECT IN ONLY ONE WAY (EITHER BY O, Z, OR T).%N[B]; N[B_]; N[SD_]; N[SS]; N[$]; N[H$]; N[BN]; N[SSN];  *OBJECT CLASSESM[B_B,B];		M[B_Q,O[24]Q];		M[B_BN,BN];M[SD_B,B];		M[SD_Q,O[24]Q];		M[B_SSN,SSN];M[B_SS,SS];		M[B_U,O[25]U];		M[SD_BN,BN];M[B_$,O[6]SS];		M[B_H$,O[17]SS];*SD_SS IS ILLEGAL*MULTIPLE SOURCE REDUCTION MACROSM[B U $, SB];		M[B U H$, HSB];M[SS U $, SB];		M[SS U H$, HSB];M[U U $, ASB];		M[U U H$, HASB];M[B U U, AB];M[SS U U, AB];M[$ U U, ASB];		M[H$ U U, HASB];M[$ U B, SB];		M[H$ U B, HSB];M[$ U SS,SB];		M[H$ U SS,HSB];M[U U B, AB];M[U U SS, AB];M[Q U $,O[24]SB];	M[Q U H$,O[24]HSB];M[$ U Q,O[24]SB];	M[H$ U Q,O[24]HSB];M[Q U U,O[24]AB];M[U U Q,O[24]AB];M[Q U B,QB];M[B U Q,QB];M[Q U SS,SS(,QB)];M[SS U Q,SS(,QB)];M[Q U B U $,QO];M[Q U $ U B,QO];M[B U Q U $,QO];M[B U $ U Q,QO];M[$ U B U Q,QO];M[$ U Q U B,QO];M[Q U SS U $,QO];M[Q U $ U SS,QO];M[$ U Q U SS,QO];M[$ U SS U Q,QO];M[SS U Q U $,QO];M[SS U $ U Q,QO];M[Q U U U $,QLS];M[Q U $ U U,QLS];M[U U Q U $,QLS];M[U U $ U Q,QLS];M[$ U Q U U,QLS];M[$ U U U Q,QLS];M[B U $ U U,ASB];M[SS U $ U U,ASB];M[B U U U $,ASB];M[SS U U U $,ASB];M[$ U B U U,ASB];M[$ U U U B,ASB];M[U U B U $, ASB];M[U U $ U B,ASB];M[$ U SS U U,ASB];M[$ U U U SS,ASB];M[U U SS U $,ASB];M[U U $ U SS,ASB];M[B U B,B];M[B U SS,SS];M[SS U B,SS];M[SS U SS,SS];M[QO,IFA[O,ASB(,AQ),O[24]SB]];M[QLS,O[24]Z[53]F2[5]SS];M[SB,IFA[O,IFA[F2,Z[22],F2[5]],O[6]]SS];M[AB,IFA[O,Z[53],O[25]]SS];M[ASB,IFA[O,Z[53]F2[5]SS,O[25]SB]];M[QB,IFA[O,AB(,AQ),O[24]B]];M[HSB,IFA[O,Z[27],O[17]]SS];M[HASB,O[17] Z[53]SS];*BUS SOURCES AND DESTINATIONSM[NULL,O[0]B];		*DEFAULT BUS DESTINATION IS 0, NEVER GIVEN EXPLICITLYM[X,O[1]B];		M[X_,T[1]B_];M[Y,O[2]B];		M[Y_,T[2]B_];M[AC,O[3]B];		M[AC_,T[3]B_];M[D1,O[4]SS];		M[D1_,T[4]SD_];M[D,O[5]SS];		M[D_,T[5]SD_];*** NO ERROR CHECK FOR BOTH DM AND SM USED IN SAME INSTRUCTION*** FORWARD REFERENCES IMPOSSIBLE FOR ADDRESS SOURCESM[SSRC,IFDEF[#1,SA[AND[IP[#1],377]]IFG[IP[#1],377,H$,$],SA[#1]]];*NOTE THAT AN SM ADDRESS SHOULD BE TO THE LEFT OF A BUS DESTINATION IN*A MULTIPLE LEFT-ARROW EXPRESSIONM[SSINK, IFA[T, IFA[F2, Z[61], F2[6]], T[6]] SA[#1] SD_];M[D2,O[7]SS];		M[D2_,T[7]SD_];M[MDR,O[10]B];		M[MDR_,T[10]B_];M[MDRL,O[11]BN];	M[READ_,T[11]B_];M[MAR,O[12]BN];		M[RMW_,B_(T[12],PF[F2,0])];M[MDR&SETTAG,O[13]B];	M[WRITE_,T[13]B_];M[KMDR,O[14]BN];	M[KMDR_,T[14]B_];M[KMDRL,O[15]BN];	M[KREAD_,T[15]B_];M[KMAR,O[16]BN];	M[KWRITE_,T[16]B_];			M[KRMW_,T[17]B_];M[KUNIT,O[20]SSN];	M[KUNIT_,T[20]B_];M[KSTAT,O[21]SSN];	M[KSET_,T[21]B_];M[EREG,O[22]SSN];	M[KCSET_,T[22]B_];M[XTOP,O[23]B];	M[ISPLIT_,T[23]B_];M[BQ,O[24]B];		M[FSPLIT_,T[24]B_];			M[BSPLIT_,T[25]B_];M[STACK,O[26]B];	M[STACK_,T[26]B_];M[NPC,O[27]B];		M[MAPVA_,T[27]B_];			M[MAP4_,T[30]SD_];M[FLAGS,O[31]B];	M[XSPLIT_,T[31]B_];M[TENF,O[32]B];		M[YSHIFT_,T[32]B_];M[MAP,O[33]SS];		M[MAP_,T[33]SD_];M[I,O[34]?];		N[I_]; M[I_SSN,T[34]SSN];M[BPC,O[35]SS];		M[BPC_,T[35]B_];*6 S AND S_ USED IMPLICITLY ONLY*17 SH IMPLICITLY*25 ALU IMPLICITLY*SOURCE 17 UNUSED, DESTINATIONS 36-37 UNUSED*36 BAT, 37 BAX IMPLICITLY%MACROS TO CREATE CONSTANTS.  SEVERAL PROPERTIES ARE DESIRABLE:   1)  IF A LITERAL OF THE SAME VALUE HAS BEEN DEFINED, POINT       THE CONSTANT AT THE SAME LOCATION.   2)  OTHERWISE, DEFINE THE CONSTANT AS AN ADDRESS AND       INITIALIZE THAT LOCATION TO THE CONSTANT VALUE.   3)  ALL CONSTANTS OF THE SAME VALUE SHOULD WIND UP POINTING AT       THE SAME LOCATION.  THIS MEANS THAT THE LITERAL EQUIVALENT OF       THE SYMBOL SHOULD ALSO BE PUT INTO THE SYMBOL TABLE AND THAT       THE PROCESS OF DEFINING A CONSTANT SHOULD INCLUDE CHECKING       FOR PREVIOUS ENTRY OF THE LITERAL EQUIVALENT INTO THE SYMBOL TABLE.   4)  IT WOULD ALSO BE DESIRABLE TO HAVE SOME CHECKS FOR THE       MISTAKEN USE OF THE CONSTANT AS A DESTINATION SINCE       CONSTANTS SHOULD NOT BE DIRTIED BY STORES.   5)  ABILITY TO CONSTRUCT THE CONSTANT IN A NATURAL WAY FROM       MORE BASIC PARAMETERS.  FOR EXAMPLE, IT IS IMPORTANT TO BE       ABLE TO DEFINE THE BITS IN THE F REGISTER SYMBOLICALLY       (BECAUSE THESE ASSIGNMENTS HAVE BEEN VOLATILE IN THE       PAST AND ARE LIKELY TO BE VOLATILE IN THE FUTURE) AND       TO DEFINE EVERY AGGREGATE OF THESE FLAGS FROM THE MORE FUNDA-       MENTAL DEFINITIONS.AT THE MOMENT (1), (3), AND (4) ABOVE ARE NOT IMPLEMENTED.  SOMEFACILITY FOR MULTI-WORD INTEGER ARITHMETIC IS REQUIRED.MEANWHILE, FOUR MACROS ARE IMPLEMENTED:   PM[NAME,OCTALSTRING] MAKES A PARAMETER OF NAME;   MP[NAME,INTEGER] MAKES A ONE-BIT PARAMETER OF NAME WITH A ONE IN THE BITSELECTED BY INTEGER;   SP[NAME,P1,P2,P3,P4,P5,P6] MAKES A PARAMETER NAME EQUAL TO THE SUMOF PARAMETERS P1, P2, P3, P4, P5, AND P6;THE PARAMETER "NAME" IS DEFINED BY THE INTEGERS NAME. (BITS[30-43]),NAME! (BITS[14-27]), AND NAME@ (BITS[0-13]).%*DEFINE 36-BIT PARAMETERM[PRS,IFE[TT.,,,SET[#1.,TT.]] IFE[TT!,,,SET[#1!,TT!]]   IFE[TT@,,,SET[#1@,TT@]]];M[PM,(PRS[#1],#2PMM)];M[PMM,(SET[TT.,#1], SET[TT!,#2], SET[TT@,#3])];*DEFINE A ONE-BIT PARAMETERM[BX,B#1];M[MP,IFG[#2,27,SET[#1.,ADD[#2,-30]BX],IFG[#2,13,SET[#1!,ADD[#2,-14]BX],   SET[#1@,ADD[#2]BX]]]];SET[B0000,4000];SET[B0001,2000];SET[B0002,1000];SET[B0003,400];SET[B0004,200];SET[B0005,100];SET[B0006,40];SET[B0007,20];SET[B0010,10];SET[B0011,4];SET[B0012,2];SET[B0013,1];*0 IF UNDEFINED, #1 OTHERWISEM[RZ,IFDEF[#1,#1]];M[AZ,SET[TT#1,ADD[RZ[#2#1],RZ[#3#1],RZ[#4#1],RZ[#5#1],RZ[#6#1],   RZ[#7#1]]]];   *ADD UP PART OF A PARAMETERM[TZ,AZ[.,#1,#2,#3,#4,#5,#6]AZ[!,#1,#2,#3,#4,#5,#6]AZ[@,#1,#2,#3,#4,#5,#6]];*MAKE A PARAMETER FROM PARAMETERSM[SP,IFG[#0,7,ER[TOO.MANY.ARGS.FOR.#1]]    TZ[#2,#3,#4,#5,#6,#7] PRS[#1]];*FIELDS FOR INITIALIZING 36-BIT WIDE MEMORIESF[E3,0,13]; F[E2,14,27]; F[E1,30,43];*MACRO TO INITIALIZE (36-BIT) VARIABLES IN THE TARGET MEMORY.  THIS IS*DONE BY WRITING 432156732100V (I.E., AS A LITERAL).M[V,IFSE[#4,,E1[#1] E2[#2] E3[#3], ER[#4#3#2#1V???]]];M[RSRC,RA[#1]RB];M[RSINK,RA[#1]RB_]; N[RB_]; M[RB_U,U]; M[RB_Q,(Q,AQ)];RM[RX,2];*****RAC, LINDX, LAC, AND LACS COMMENTED OUT BECAUSE THE LOADER DOESN'T****USE THEM AND WANT TO KEEP Midas.SymTab SMALL FOR EFFICIENT BLOCKSPLIT.*RM[RAC,0];M[LSRC,LA[#1]LB];M[LSINK,LA[#1]LB_]; N[LB_]; M[LB_U,U]; M[LB_Q,(Q,AQ)];LM[LX,3];*LM[LINDX,2]; LM[LAC,1]; LM[LACS,0];SM[SY,0];%LDR MEMORY DEFAULT IS NO-OP, SINGLE-STEP, INSTRUCTION-CONTROLLED CHANGES OK,NPC AND IMA CHANGES INHIBITED, INSTRUCTIONS FROM MAINTENANCE INTERFACE.%DEFAULT[LDR,(GOTO[NEVER], Q_Q, PQ RCY [0], LA[4], RA[4], A0, SA[0], B_NULL,   NOF2, NOZ, EIC[1] EB[0] EIMA[0] ENPC[0] NOTSS[0] SETRUN[1] RESET[1]   XPIR[1] REGTOB[0] INTON[0] STROBE[0])];*F REGISTER PARAMETER DECLARATIONSMP[OVF,0];	*OVERFLOW = (PC0#PC1) (HARDWARE DEPENDENT)MP[PC0,1];	*ALU CARRY OUT OF BIT 0 (H.D.)MP[PC1,2];	*ALU CARRY OUT OF BIT 1 (H.D.)MP[FOVF,3];	*FLOATING OVERFLOWMP[BIS,4];	*BYTE INCREMENT SUPPRESS ON NEXT ILDB OR IDPBMP[UM,5];	*USER MODE (H.D.)MP[PARCMODE,6];	*ENABLES USER MODE OPTIONS (USER I/O MODE N.I.)MP[CFM,7];	*CALL-FROM-MONITOR.  DIRECTS FORCED REFERENCES TO USER		*ADDRESSES TO THE MONITOR (I.E., SUPPRESSES UMOVE, UXCT)MP[MD0,10];	*MACHINE MODE BITSMP[MD1,11];MP[MD2,12];MP[FUNF,13];	*FLOATING UNDERFLOWMP[NODIV,14];	*NO DIVIDEMP[PDOVF,15];	*PUSH-DOWN OVERFLOWMP[XCT0,16];	*DIRECTS INDIRECT READS TO USER SPACE (H.D.)MP[XCT1,17];	*READS AND RMW'S TO USER (H.D.)MP[XCT2,20];	*BYTE POINTER INDIRECT READS TO USERMP[XCT3,21];	*WRITES TO USER (H.D.)SP[XCTN,XCT0,XCT1,XCT2,XCT3];MP[INCMP,22];	*ENABLES PRIVILEGED OPTIONSMP[PIACTIVE,23];	*P.I. SYSTEM TURNED ONMP[TAG0,24];	*MEMORY TAG BITS AFTER MDR&SETTAG (H.D.)MP[TAG1,25];	*(H.D.)MP[TAG2,26];	*(H.D.)MP[TAG3,27];	*(H.D.)*MONALT AND THIRDPT ARE REUSABLE BY ROUTINES WHICH DON'T OVERLAP MAP LOADINGMP[MONALT,25];	*MONITOR AFTER-LOADING TRAP (USED ONLY DURING MAP LOADING)MP[THIRDPT,26];	*CHECKING THIRD P.T.E. DURING MAP LOADINGMP[TTYBSY,30];	*CONSOLE TTY OUTPUT BUSYMP[LOGF,31];	*ENABLE OPTIONAL MAIN LOOP BRANCHMP[PICYCLE,32];	*P.I. OR TRAP CYCLE IN PROGRESSMP[CUM,33];	*CURRENT USER MODE (H.D.)MP[MICRO,34];	*P.I. CHECKS SHOULD BE MADEMP[IENABLE,35];	*ENABLES MICROINTERRUPTS (H.D.)*36 UNUSED.MP[NOVA,37];	*NOVA HAS LEFT A MESSAGE (H.D.)MP[K,40];	*(H.D.)MP[J,41];	*(H.D.)MP[H,42];	*(H.D.)MP[G,43];	*(H.D.)%2ND ARG OF LIST CONTROLS OUTPUT AS FOLLOWS:1 = (TAG) NNNN NNNN NNNN ...2 = (TAG) F1_3, F2_4, ...4 = NUMERICALLY-ORDERED LIST OF ADDRESS SYMBOLS10 = ALPHABETICALLY-ORDERED LIST OF ADDRESS SYMBOLS%LIST[LDR,5]; LIST[,17];