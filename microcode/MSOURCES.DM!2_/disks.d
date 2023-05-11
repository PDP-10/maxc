// Disks.D -- Common definitions for Disk Objects// These are implemented by, among others, the BFS and TFS packages.// Copyright Xerox Corporation 1979// Last modified December 22, 1979  1:19 AM by Boggs//---------------------------------------------------------------------------structure DSK:		// The structure for the disk object//---------------------------------------------------------------------------// Note that the generic operations have various other things intermixed// with them.  This is an historical artifact and can't be changed without// invalidating a lot of existing programs.[// Generic operations:ActOnDiskPages	word	// (disk, CAs, DAs, fp, firstPage, lastPage, action,			//  lvNumChars, lastAction, fixedCA, cleanupRoutine,			//  errorRtn)WriteDiskPages	word	// (disk, CAs, DAs, fp, firstPage, lastPage,			//  lastAction, lvNumChars, lastNumChars, fixedCA,			//  nil, errorRtn)CreateDiskFile	word	// (disk, name, fp, dirFp, word1, old)DeleteDiskPages	word	// (disk, CA, firstDA, fp, firstPage)AssignDiskPage	word	// (disk, virtualDA)ReleaseDiskPage	word	// (disk, virtualDA)VirtualDiskDA	word	// (disk, lvRealDA)RealDiskDA	word	// (disk, virtualDA, lvRealDA)fpSysDir	word	// -> FP for directoryInitializeDiskCBZ word	// (disk, cbz, firstPage, length, retry, errorRtn)DoDiskCommand	word	// (disk, cb, ca, da, fp, page, action, nextCb)fpWorkingDir	word	// -> FP for working directorynameWorkingDir	word	// -> string name of working dir.lnPageSize	word	// ln (base 2) of page size in wordsGetDiskCb	word	// (disk, cbz, dontClear, returnIfNoCb)CloseDisk	word	// (disk, dontFree)blank		word	// spare for another operationdiskKd		word	// -> KD (header only)fpDiskDescriptor word	// -> FP for disk descriptordriveNumber	word	// which drive working on (0, 1, ...)retryCount	word	// number of retries to attempttotalErrors	word	// error countlengthCBZ	word	// length of the fixed portion of a CBZlengthCB	word	// length of each CB// Disk implementations put additional stuff here.]// Operations on a Disk Descriptor Manager (DDMgr) object.//----------------------------------------------------------------------------structure DDMgr://----------------------------------------------------------------------------[OpenDD word		// Call0LockDD word		// Call1ReadDDPage word		// Call2UnlockDD word		// Call3FlushDD word		// Call4CloseDD word		// Call5DestroyDDMgr word	// Call6]// CBZ: format of a zone used to transfer disk sectors -- manipulated by// the InitializeDiskCBZ, DoDiskCommand, and GetDiskCb operations.// *=initialized by InitializeCbStorage; everything else is zeroed.//----------------------------------------------------------------------------structure CBZ://----------------------------------------------------------------------------[length word		// *disk word		// * -> DSKclient word = DAs word	// for client use (e.g., -> client data structure)cleanupRoutine word	// * (disk, cb, cbz) set to Noop by InitializeDiskCBZcurrentPage word	// * set only by InitializeCbStoragenextDA word =		// set by GetCb upon normal command completion   errorDA word		// set by GetCb on errorerrorRtn word		// *retry word		// *currentNumChars wordnormalWakeups worderrorWakeups worderrorCount wordqueueHead word		// * -> head for backward compatibilityhead word		// * -> first CB on queue (0 = empty)tail word		// * -> last CB on queue// Disk implementations may put additional stuff here.// CBs follow, but in an implementation-dependent manner.]manifest[// Virtual disk addresses with special meaning:eofDA = -1			// End of filefillInDA = -2			// Unknown DA// Disk actions (all have some "magic" bits to avoid accidents):diskMagic = 153000b		// High order bits.// Fields not explicitly mentioned are "checked":DCreadHLD = 0 + diskMagic	// Read header,label,dataDCreadLD = 1 + diskMagic	// Read label,dataDCreadD = 2 + diskMagic		// Read dataDCwriteHLD = 3 + diskMagic	// Write header,label,dataDCwriteLD = 4 + diskMagic	// Write label,dataDCwriteD = 5 + diskMagic	// Write dataDCseekOnly = 6 + diskMagic	// Just seek to spotDCdoNothing = 7 + diskMagic	// No-op// Some disks provide other (device dependent) commands too.]