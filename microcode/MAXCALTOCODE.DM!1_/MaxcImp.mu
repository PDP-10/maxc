; MaxcImp.mu -- Microcode for driving Maxc2 Alto Imp interface;	Last modified April 13, 1978  7:45 PM; Derived from Alto-1822 microcode by Larry Stewart.; The software interface is the same, but the implementation is more; time-efficient due to the use of a number of additional S-registers.; This microcode runs only on Alto-I.; Data structures:; Imp Command Block (ICB); word	0	control word -- command;	1	unused;	2	input pointer -- next word to be used;	3	input buffer end -- first word not in buffer;	4	output pointer -- next word to be used;	5	output buffer end -- first word not in buffer;	6	control post location;	7	control interrupt channels;	10	input post location;	11	input interrupt channels;	12	output post location;	13	output interrupt channels; Microcode status codes:$ISDone	$777;	Normal completion.$ISOvf	$1377;	Buffer overflow (input only)$ISIBLZ	$1777;	Block length zero (input only); Imp Task-specific functions:$IREAD	$L 000000, 070017, 000100;	F1=17	_ Input data, branch if end$IWRITE	$L 020016, 000000, 120000;	F1=16	Output data _$IOCLR	$L 016015, 000000, 000000;	F1=15	Clear output wakeup$IPOSTF	$L 016014, 000000, 000100;	F1=14	_ Status$ISWAKC	$L 024014, 000000, 000000;	F2=14	Clear SIO-generated wakeup$IBRNCH	$L 024013, 000000, 000000;	F2=13	4-way branch on wakeup$IIENBL	$L 024012, 000000, 000000;	F2=12	Start read (turn on RFNIB)$ISETCS	$L 026011, 000000, 120000;	F2=11	Set control _$IPTMOD	$L 024010, 000000, 000000;	F2=10	2-way branch on throwaway mode; S-registers dedicated to this task$ICBPtr	$R70;		Imp Command Block pointer$IPtr	$R71;		Input Pointer -- last word stored$IEPtr	$R72;		Input end pointer -- first word beyond end of buffer$OPtr	$R73;		Output Pointer -- last word fetched$OEPtr	$R74;		Output end pointer -- first word beyond end of buffer%14, 14, 0, IIStart, IControl, IOData, IIData;	00xx, 01xx, 10xx, 11xx!1, 2, IPost, IReset;!1, 2, IIEnab, IIZero;%4, 4, 0, IIAcpt, IIDisc;			x0xx, x1xx%5, 5, 0, IIMore, IIFull, IILast, IIFLst;	x0x0, x0x1, x1x0, x1x1%4, 5, 1, IIDMor, IIDLst;			x0x1, x1x1!1, 2, IOMain, IOInit;!1, 2, IOMore, IOEnd;!1, 2, IONLst, IOLast;$12	$12;; *** Imp Task starting address and main loop ***ImpTask:	L_ 0, TASK, :IOFin;		Indicate no output in progress; Task always blocks here and wakes up when there is something to do.ImpLoop:	T_ ICBPtr, IBRNCH;		Branch on wakeup condition	:IIStart;			[IIStart, IControl, IOData, IIData]; *** Common Post routine ***; Expects offset of post location in T and post code in M.IPost:	MAR_ ICBPtr+T;			Reference post location	T_ NWW;	MD_ M, IPOSTF;			Bus AND hardware status with post code	L_ MD OR T, TASK;		OR interrupt bits into NWW	NWW_ L, :ImpLoop;; *** Imp Control/Status command ***; Establishes command block pointer, issues command given in command word,; and posts control status.IControl:	MAR_ L_ AC1;			Fetch control word	ICBPtr_ L, ISWAKC;		Save control block ptr, clear wakeup	ISETCS_ MD, L_ MD-1;		Issue control function; Master Reset?	T_ 6, SH=0;			T_ control post offsetIPDone:	L_ ISDone, :IPost;		[IPost, IReset] L_ done status; Here if Master Reset was issued.IReset:	L_ 0;				Note no output in progressIODone:	OPtr_ L, :IPDone;; *** Input initialization ***; Reads pointers from control block and enables Imp input.IIStart:	MAR_ 2+T;			Reference ICB word 2	ISWAKC;				Clear SIO-generated wakeup	T_ MD-1;			T_ input pointer -1	L_ MD;				T_ end pointer	IEPtr_ L;			IEPtr_ end pointer	L_ IEPtr-T-1;			Test for zero-length buffer	L_ T, T_ 10, SH=0;		T_ input post offset	IPtr_ L, :IIEnab;		[IIEnab, IIZero] IPtr_ input ptr -1IIEnab:	TASK, :IIDMor;; Here if input buffer length is zero.IIZero:	L_ ISIBLZ, :IPost;		Post buffer length zero error; *** Input main loop ***; Note that the instruction at IIAcpt has two branches:  a NEXT[9] branch; for SH=0 (buffer full) and a NEXT[7] branch for IREAD (last word).IIData:	MAR_ T_ IPtr+1;			Start data store	L_ IEPtr-T, IPTMOD;		Test buffer full, test discard mode	L_ T, T_ IREAD, SH=0, :IIAcpt;	[IIAcpt, IIDisc] Read data wordIIAcpt:	IPtr_ L, L_ T, :IIMore;		[IIMore, IIFull, IILast, IIFLst]IIMore:	MD_ M, TASK;			Store data wordIIDMor:	IIENBL, :ImpLoop;		Enable input of next word; Here after reading last word.IILast:	MD_ M;				Store data word	T_ ICBPtr;	MAR_ 2+T;			Reference ICB word 2	L_ IPtr+1, TASK;		Store pointer to last word used +1	MD_ M;; Note that our wakeup is still asserted because the IREAD that reads the; last word doesn't clear it.  It is necessary to issue another IREAD; in this case.IILst1:	SINK_ IREAD;			Clear the wakeup (can't branch)	T_ 10, :IPDone;			T_ input post offset, post done; Here when we are in discard mode.; There is a NEXT[7] branch for IREAD (last word), which we take, and; a NEXT[9] branch for SH=0 (buffer full), which we squash.IIDisc:	TASK, :IIDMor;			[IIDMor, IIDLst]IIDLst:	:IILst1;; Here when input buffer overflows.IIFLst:	SINK_ IREAD;			Also last word, clear wakeupIIFull:	T_ 10;				T_ input post offset	L_ ISOvf, :IPost;		Post input overflow status; *** Output main loop ***; OPtr contains zero when no output is in progress.; That is how we decide whether we are initializing or in the main loop.IOData:	MAR_ T_ OPtr+1, BUS=0;		Start data fetch, see if first	L_ OEPtr-T, :IOMain;		[IOMain, IOInit]IOMain:	L_ M-1, IOCLR, SH=0;		Last word already sent?	L_ 0, SH=0, :IOMore;		[IOMore, IOEnd] Is this last word?IOMore:	IWRITE_ MD, L_ T, :IONLst;	[IONLst, IOLast] Send the data wordIOLast:	ISETCS_ 2;			Set last word flop if appropriateIONLst:	TASK;IOFin:	OPtr_ L, :ImpLoop;		Update output pointer; Here when woken up after last word sent.IOEnd:	T_ 12, :IODone;			T_ Output post offset;;					Zero OPtr and post normal done; Here when woken up with no output in progress.IOInit:	T_ ICBPtr;			Reference ICB word 4	MAR_ 4+T;	NOP;	L_ MD-1;			L_ output pointer -1	T_ MD;				T_ end pointer	OPtr_ L, L_ T, TASK;	OEPtr_ L, :IOData;		Now send first word