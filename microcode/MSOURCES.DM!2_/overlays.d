//// OVERLAYS.D - declarations for OVERLAYS package// last edited June 26, 1976  1:06 PM//structure OD: [	// overlay descriptor	da word	// disk address	core word	// core page (for lock)	onstack bit 1	// 1 if referenced from stack	firstPn bit 15	// first page # in file	]manifest ODsize = (size OD)/16