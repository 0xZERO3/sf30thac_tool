local SWAP_OFF          = 0
local SWAP_ON           = 1
local EXTRACT_NORMAL    = 0
local EXTRACT_GFX_CPS1  = 1
local EXTRACT_GFX_CPS2  = 2
local EXTRACT_XOR       = 3
local EXTRACT_ODD       = 4
local EXTRACT_EVEN      = 5
local EXTRACT_GFX_ACAC0 = 6
local EXTRACT_GFX_ACAC1 = 7


local G_buf = {}
local G_conf     = {}

local G_alt      = "-alt"
local G_gfxpatch = "-gfxpatch"
local G_debug    = "-debug"

local G_ext_list = {
	sf2hf = {
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.z80",				dir = "sf2hf",	tar = "s92_09.11a",	start = 0x00000000,	size = 0x00010000,	swap = SWAP_OFF	,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.z80",				dir = "sf2hfj",	tar = "s92_09.12a",	start = 0x00000000,	size = 0x00010000,	swap = SWAP_OFF	,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.68k",				dir = "sf2hfj",	tar = "s2tj_23.8f",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.68k",				dir = "sf2hfj",	tar = "s2tj_22.7f",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.68k",				dir = "sf2hfj",	tar = "s2tj_21.6f",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.68k",				dir = "sf2hfu",	tar = "s2tu_23.8f",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.68k",				dir = "sf2hfu",	tar = "s2tu_22.7f",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.68k",				dir = "sf2hfu",	tar = "s2tu_21.6f",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_01.3a",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_02.4a",	start = 0x00000002,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_03.5a",	start = 0x00000004,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_04.6a",	start = 0x00000006,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_05.7a",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_06.8a",	start = 0x00200002,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_07.9a",	start = 0x00200004,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s92_08.10a",	start = 0x00200006,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s2t_10.3c",	start = 0x00400000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s2t_11.4c",	start = 0x00400002,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s2t_12.5c",	start = 0x00400004,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",	dir = "sf2hfj",	tar = "s2t_13.6c",	start = 0x00400006,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-1m.3a",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-3m.5a",	start = 0x00000002,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-2m.4a",	start = 0x00000004,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-4m.6a",	start = 0x00000006,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-5m.7a",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-7m.9a",	start = 0x00200002,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-6m.8a",	start = 0x00200004,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-8m.10a",	start = 0x00200006,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-10m.3c",	start = 0x00400000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-12m.5c",	start = 0x00400002,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-11m.4c",	start = 0x00400004,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",			dir = "sf2hfu",	tar = "s92-13m.6c",	start = 0x00400006,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS1},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.oki",				dir = "sf2hf",	tar = "s92_18.11c",	start = 0x00000000,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterII_HF/StreetFighterII_HF.oki",				dir = "sf2hf",	tar = "s92_19.12c",	start = 0x00020000,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		alt_list = {
			{dir = "sf2hf",		tar = "buf1",			data = {}},
			{dir = "sf2hf",		tar = "ioa1",			data = {}},
			{dir = "sf2hf",		tar = "prg1",			data = {}},
			{dir = "sf2hf",		tar = "rom1",			data = {}},
			{dir = "sf2hf",		tar = "sou1",			data = {}},
			{dir = "sf2hf",		tar = "s9263b.1a",		data = {}},
			{dir = "sf2hf",		tar = "iob1.12d",		data = {}},
			{dir = "sf2hf",		tar = "bprg1.11d",		data = {}},
			{dir = "sf2hf",		tar = "ioc1.ic7",		data = {}},
			{dir = "sf2hf",		tar = "c632.ic1",		data = {}}
		},
		-- The ground of the Guile stage is made by inverting the left half to the right half. That can not be done with a simple patch. Therefore, it does not support
		gfx_patch = {
			{
				src   = "bundleStreetFighterII_HF/eagle_logo.vrom",
				dest  = "bundleStreetFighterII_HF/StreetFighterII_HF.j.p16.p32.vrom",
				block = 0x80,
				patch = {
					{src_offset = 0x0000, dest_offset = nil},      {src_offset = 0x0080, dest_offset = nil},      {src_offset = 0x0100, dest_offset = nil},      {src_offset = 0x0180, dest_offset = 0x554F00},
					{src_offset = 0x0200, dest_offset = 0x554F80}, {src_offset = 0x0280, dest_offset = 0x55AB80}, {src_offset = 0x0300, dest_offset = 0x582280}, {src_offset = 0x0380, dest_offset = 0x59FF00},
					{src_offset = 0x0400, dest_offset = 0x59FF80}, {src_offset = 0x0480, dest_offset = 0x5A4000}, {src_offset = 0x0500, dest_offset = nil},      {src_offset = 0x0580, dest_offset = nil},
					{src_offset = 0x0600, dest_offset = nil},      {src_offset = 0x0680, dest_offset = nil},      {src_offset = 0x0700, dest_offset = nil},      {src_offset = 0x0780, dest_offset = nil},
					{src_offset = 0x0800, dest_offset = nil},      {src_offset = 0x0880, dest_offset = 0x5A8000}, {src_offset = 0x0900, dest_offset = 0x5C7000}, {src_offset = 0x0980, dest_offset = 0x5C7980},
					{src_offset = 0x0A00, dest_offset = nil},      {src_offset = 0x0A80, dest_offset = nil},      {src_offset = 0x0B00, dest_offset = 0x5C7F80}, {src_offset = 0x0B80, dest_offset = 0x5E8000},
					{src_offset = 0x0C00, dest_offset = 0x5E8D00}, {src_offset = 0x0C80, dest_offset = nil},      {src_offset = 0x0D00, dest_offset = nil},      {src_offset = 0x0D80, dest_offset = nil},
					{src_offset = 0x0E00, dest_offset = nil},      {src_offset = 0x0E80, dest_offset = nil},      {src_offset = 0x0F00, dest_offset = nil},      {src_offset = 0x0F80, dest_offset = nil},
					{src_offset = 0x1000, dest_offset = nil},      {src_offset = 0x1080, dest_offset = 0x5EFB80}, {src_offset = 0x1100, dest_offset = 0x5EFF80}, {src_offset = 0x1180, dest_offset = 0x5F2A00},
					{src_offset = 0x1200, dest_offset = 0x5F2B80}, {src_offset = 0x1280, dest_offset = 0x5FFE80}, {src_offset = 0x1300, dest_offset = 0x5FFF00}, {src_offset = 0x1380, dest_offset = 0x5FFF80},
					{src_offset = 0x1400, dest_offset = nil},      {src_offset = 0x1480, dest_offset = nil},      {src_offset = 0x1500, dest_offset = nil},      {src_offset = 0x1580, dest_offset = nil},
					{src_offset = 0x1600, dest_offset = nil},      {src_offset = 0x1680, dest_offset = nil},      {src_offset = 0x1700, dest_offset = nil},      {src_offset = 0x1780, dest_offset = nil}
				}
			},
			{
				src   = "bundleStreetFighterII_HF/eagle_logo.vrom",
				dest  = "bundleStreetFighterII_HF/StreetFighterII_HF.u.vrom",
				block = 0x80,
				patch = {
					{src_offset = 0x0000, dest_offset = nil},      {src_offset = 0x0080, dest_offset = nil},      {src_offset = 0x0100, dest_offset = nil},      {src_offset = 0x0180, dest_offset = 0x554F00},
					{src_offset = 0x0200, dest_offset = 0x554F80}, {src_offset = 0x0280, dest_offset = 0x55AB80}, {src_offset = 0x0300, dest_offset = 0x582280}, {src_offset = 0x0380, dest_offset = 0x59FF00},
					{src_offset = 0x0400, dest_offset = 0x59FF80}, {src_offset = 0x0480, dest_offset = 0x5A4000}, {src_offset = 0x0500, dest_offset = nil},      {src_offset = 0x0580, dest_offset = nil},
					{src_offset = 0x0600, dest_offset = nil},      {src_offset = 0x0680, dest_offset = nil},      {src_offset = 0x0700, dest_offset = nil},      {src_offset = 0x0780, dest_offset = nil},
					{src_offset = 0x0800, dest_offset = nil},      {src_offset = 0x0880, dest_offset = 0x5A8000}, {src_offset = 0x0900, dest_offset = 0x5C7000}, {src_offset = 0x0980, dest_offset = 0x5C7980},
					{src_offset = 0x0A00, dest_offset = nil},      {src_offset = 0x0A80, dest_offset = nil},      {src_offset = 0x0B00, dest_offset = 0x5C7F80}, {src_offset = 0x0B80, dest_offset = 0x5E8000},
					{src_offset = 0x0C00, dest_offset = 0x5E8D00}, {src_offset = 0x0C80, dest_offset = nil},      {src_offset = 0x0D00, dest_offset = nil},      {src_offset = 0x0D80, dest_offset = nil},
					{src_offset = 0x0E00, dest_offset = nil},      {src_offset = 0x0E80, dest_offset = nil},      {src_offset = 0x0F00, dest_offset = nil},      {src_offset = 0x0F80, dest_offset = nil},
					{src_offset = 0x1000, dest_offset = nil},      {src_offset = 0x1080, dest_offset = 0x5EFB80}, {src_offset = 0x1100, dest_offset = 0x5EFF80}, {src_offset = 0x1180, dest_offset = 0x5F2A00},
					{src_offset = 0x1200, dest_offset = 0x5F2B80}, {src_offset = 0x1280, dest_offset = 0x5FFE80}, {src_offset = 0x1300, dest_offset = 0x5FFF00}, {src_offset = 0x1380, dest_offset = 0x5FFF80},
					{src_offset = 0x1400, dest_offset = nil},      {src_offset = 0x1480, dest_offset = nil},      {src_offset = 0x1500, dest_offset = nil},      {src_offset = 0x1580, dest_offset = nil},
					{src_offset = 0x1600, dest_offset = nil},      {src_offset = 0x1680, dest_offset = nil},      {src_offset = 0x1700, dest_offset = nil},      {src_offset = 0x1780, dest_offset = nil}
				}
			}
		},
	},
	ssf2t = {
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.z80",		dir = "ssf2t",		tar = "sfx.01",		start = 0x00000000,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.z80",		dir = "ssf2t",		tar = "sfx.02",		start = 0x00020000,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfxj.03c",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfxj.04a",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfxj.05",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfxj.06a",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfxj.07",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfxj.08",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68k",	dir = "ssf2xjr1",	tar = "sfx.09",		start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxjx.03c",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxjx.04a",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxjx.05",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxjx.06a",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxjx.07",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxjx.08",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.jr1.68y",	dir = "ssf2xjr1",	tar = "sfxx.09",	start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfxj.03d",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfxj.04a",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfxj.05",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfxj.06b",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfxj.07a",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfxj.08",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68k",	dir = "ssf2xj",		tar = "sfx.09",		start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxjx.03d",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxjx.04a",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxjx.05",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxjx.06b",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxjx.07a",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxjx.08",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.j.68y",	dir = "ssf2xj",		tar = "sfxx.09",	start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfxu.03e",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfxu.04a",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfxu.05",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfxu.06b",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfxu.07a",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfxu.08",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68k",	dir = "ssf2tu",		tar = "sfx.09",		start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxux.03e",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxux.04a",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxux.05",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxux.06b",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxux.07a",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxux.08",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.u.68y",	dir = "ssf2tu",		tar = "sfxx.09",	start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_XOR},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.qs",		dir = "ssf2t",		tar = "sfx.11m",	start = 0x00000000,	size = 0x00200000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.qs",		dir = "ssf2t",		tar = "sfx.12m",	start = 0x00200000,	size = 0x00200000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.13m",	start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.15m",	start = 0x00000002,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.17m",	start = 0x00000004,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.19m",	start = 0x00000006,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.14m",	start = 0x00800000,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.16m",	start = 0x00800002,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.18m",	start = 0x00800004,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.20m",	start = 0x00800006,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.21m",	start = 0x00C00000,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.23m",	start = 0x00C00002,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.25m",	start = 0x00C00004,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleSuperStreetFighterIITurbo/SuperStreetFighterIITurbo.vrom",	dir = "ssf2t",		tar = "sfx.27m",	start = 0x00C00006,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		alt_list = {
			{dir = "ssf2t",		tar = "ssf2xj.key",		data = {0x01, 0x00, 0x02, 0x40, 0x00, 0x08, 0x70, 0x43, 0x80, 0x00, 0x00, 0x11, 0xC0, 0xA0, 0xD6, 0x81, 0x03, 0xA9, 0x50, 0xA4}},
			{dir = "ssf2t",		tar = "ssf2tu.key",		data = {0x01, 0x00, 0x02, 0x40, 0x00, 0x08, 0x70, 0x43, 0x80, 0x00, 0x00, 0x13, 0xF0, 0xA3, 0xB8, 0xC9, 0x02, 0x45, 0x7C, 0xA4}},
			{dir = "ssf2t",		tar = "dl-1425.bin",	data = {}}
		}
	},
	sfa3 = {
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.z80",		dir = "sfa3",		tar = "sz3.01",		start = 0x00000000,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.z80",		dir = "sfa3",		tar = "sz3.02",		start = 0x00020000,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68x",	dir = "sfz3jr2",	tar = "sz3jx.03",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68x",	dir = "sfz3jr2",	tar = "sz3jx.04",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3j.03",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3j.04",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3.05",		start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3.06",		start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3.07",		start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3.08",		start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3.09",		start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.jr2.68k",	dir = "sfz3jr2",	tar = "sz3.10",		start = 0x00380000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68x",	dir = "sfz3j",	tar = "sz3jx.03c",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68x",	dir = "sfz3j",	tar = "sz3jx.04c",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3j.03c",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3j.04c",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3.05c",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3.06c",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3.07c",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3.08c",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3.09c",	start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.j.68k",	dir = "sfz3j",	tar = "sz3.10b",	start = 0x00380000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68x",	dir = "sfa3u",	tar = "sz3ux.03c",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68x",	dir = "sfa3u",	tar = "sz3ux.04c",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3u.03c",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3u.04c",	start = 0x00080000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3.05c",	start = 0x00100000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3.06c",	start = 0x00180000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3.07c",	start = 0x00200000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3.08c",	start = 0x00280000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3.09c",	start = 0x00300000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.u.68k",	dir = "sfa3u",	tar = "sz3.10b",	start = 0x00380000,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.qs",		dir = "sfa3",	tar = "sz3.11m",	start = 0x00000000,	size = 0x00400000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.qs",		dir = "sfa3",	tar = "sz3.12m",	start = 0x00400000,	size = 0x00400000,	swap = SWAP_ON,		ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.13m",	start = 0x00000000,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.15m",	start = 0x00000002,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.17m",	start = 0x00000004,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.19m",	start = 0x00000006,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.14m",	start = 0x01000000,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.16m",	start = 0x01000002,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.18m",	start = 0x01000004,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		{src = "bundleStreetFighterAlpha3/StreetFighterAlpha3.vrom",	dir = "sfa3",	tar = "sz3.20m",	start = 0x01000006,	size = 0x00400000,	swap = SWAP_OFF,	ext = EXTRACT_GFX_CPS2},
		alt_list = {
			{dir = "sfa3",		tar = "sfz3j.key",		data = {0x0F, 0x00, 0x02, 0x40, 0x00, 0x08, 0x04, 0xC1, 0x18, 0xE0, 0x56, 0xBE, 0x7A, 0xD1, 0xF4, 0xC3, 0x00, 0x7E, 0x4A, 0xF8}},
			{dir = "sfa3",		tar = "sfa3u.key",		data = {0x0F, 0x00, 0x02, 0x40, 0x00, 0x08, 0x04, 0xC1, 0x18, 0xE0, 0x56, 0xBC, 0x49, 0x30, 0xA7, 0x9A, 0x9C, 0x3F, 0x77, 0x9C}},
			{dir = "sfa3",		tar = "dl-1425.bin",	data = {}}
		}
	},
	sfiii3nr1 = {
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.bios",	dir = "sfiii3nr1",	tar = "sfiii3_japan_nocd.29f400.u2",	start = 0x00000000,	size = 0x00080000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s1",	dir = "sfiii3nr1",	tar = "sfiii3-simm1.0",					start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s1",	dir = "sfiii3nr1",	tar = "sfiii3-simm1.1",					start = 0x00200000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s1",	dir = "sfiii3nr1",	tar = "sfiii3-simm1.2",					start = 0x00400000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s1",	dir = "sfiii3nr1",	tar = "sfiii3-simm1.3",					start = 0x00600000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s2",	dir = "sfiii3nr1",	tar = "sfiii3-simm2.0",					start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s2",	dir = "sfiii3nr1",	tar = "sfiii3-simm2.1",					start = 0x00200000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s2",	dir = "sfiii3nr1",	tar = "sfiii3-simm2.2",					start = 0x00400000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.r1.s2",	dir = "sfiii3nr1",	tar = "sfiii3-simm2.3",					start = 0x00600000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.0",					start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.1",					start = 0x00200000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.2",					start = 0x00400000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.3",					start = 0x00600000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.4",					start = 0x00800000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.5",					start = 0x00A00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.6",					start = 0x00C00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s3",	dir = "sfiii3nr1",	tar = "sfiii3-simm3.7",					start = 0x00E00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.0",					start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.1",					start = 0x00200000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.2",					start = 0x00400000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.3",					start = 0x00600000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.4",					start = 0x00800000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.5",					start = 0x00A00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.6",					start = 0x00C00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s4",	dir = "sfiii3nr1",	tar = "sfiii3-simm4.7",					start = 0x00E00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.0",					start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.1",					start = 0x00200000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.2",					start = 0x00400000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.3",					start = 0x00600000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.4",					start = 0x00800000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.5",					start = 0x00A00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.6",					start = 0x00C00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s5",	dir = "sfiii3nr1",	tar = "sfiii3-simm5.7",					start = 0x00E00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.0",					start = 0x00000000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.1",					start = 0x00200000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.2",					start = 0x00400000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.3",					start = 0x00600000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.4",					start = 0x00800000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.5",					start = 0x00A00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.6",					start = 0x00C00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "bundleStreetFighterIII_3rdStrike/StreetFighterIII_3rdStrike.s6",	dir = "sfiii3nr1",	tar = "sfiii3-simm6.7",					start = 0x00E00000,	size = 0x00200000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		alt_list = {
		}
	},
--[[
	nemesis = {
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d01.12a",	start = 0x00000040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},			-- diff
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d05.12c",	start = 0x00000040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},		-- diff
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d02.13a",	start = 0x00010040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d06.13c",	start = 0x00010040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d03.14a",	start = 0x00020040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d07.14c",	start = 0x00020040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d04.15a",	start = 0x00030040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_nemesis.dmp",	dir = "nemesis",	tar = "456-d08.15c",	start = 0x00030040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		alt_list = {
		}
	},
]]
	vulcan = {
		{src = "AA_AC_ArcadeClassics_vulcan.dmp",	dir = "gradius2",	tar = "785_x05.6n",		start = 0x00000040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_vulcan.dmp",	dir = "gradius2",	tar = "785_x04.4n",		start = 0x00000040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_vulcan.dmp",	dir = "gradius2",	tar = "785_x09.6r",		start = 0x00020040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_vulcan.dmp",	dir = "gradius2",	tar = "785_x08.4r",		start = 0x00020040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_w05.6n",		start = 0x00040040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_w04.4n",		start = 0x00040040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_w09.6r",		start = 0x00060040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_w08.4r",		start = 0x00060040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_p07.10n",	start = 0x00080040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_p06.8n",		start = 0x00080040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_p13.10s",	start = 0x000A0040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_ODD},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_p12.8s",		start = 0x000A0040,	size = 0x00010000,	swap = SWAP_OFF,	ext = EXTRACT_EVEN},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_g03.10a",	start = 0x000C0040,	size = 0x00008000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},		-- diff
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_f01.5a",		start = 0x000C8040,	size = 0x00020000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "AA_AC_ArcadeClassics_vulcan.dmp",	dir = "gradius2",	tar = "785_g14.d8",		start = 0x000E8040,	size = 0x00004000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785_h14.d8",		start = 0x000EC040,	size = 0x00004000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785f15.p13",		start = 0x000F0040,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_GFX_ACAC0},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785f17.p16",		start = 0x000F0040,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_GFX_ACAC1},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785f16.p15",		start = 0x001F0040,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_GFX_ACAC0},
		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "785f18.p18",		start = 0x001F0040,	size = 0x00080000,	swap = SWAP_ON,		ext = EXTRACT_GFX_ACAC1},
--		{src = "AA_AC_ArcadeClassics_gradius2.dmp",	dir = "vulcan",		tar = "unknown01",		start = 0x00270040,	size = 0x00100000,	swap = SWAP_OFF,	ext = EXTRACT_NORMAL},		-- sound?
		alt_list = {
			{dir = "vulcan",	tar = "785_g03.10a",	data = {}},
			{dir = "vulcan",	tar = "785_f02.7c",		data = {}},
		}
	}
}

function byte_swap(t)
	local tmp
	for i = 1, #t,2 do
		tmp      = t[i]
		t[i]     = t[i + 1]
		t[i + 1] = tmp
	end
	return t
end

function extract_normal(L)
	local t = {}
	for i = 1, L.size do
		t[i] = G_buf[L.src][L.start + i]
	end
	if L.swap == SWAP_ON then
		t = byte_swap(t)
	end
	
	for i = 1, #t do
		t[i] = string.char(t[i])
	end
	out_fp = io.open(L.dir .. "/" .. L.tar, "w+b")
	out_fp:write(table.concat(t))
	out_fp:close()
end

function extract_gfx(L)
	local t = {}
	
	-- convert 30th gfx to mame gfx
	if G_buf[L.src .. "_mgfx"] == nil then
		G_buf[L.src .. "_mgfx"] = {}
		print("Converting graphic...")
		for i = 1, #G_buf[L.src], 4 do
			G_buf[L.src .. "_mgfx"][i + 0] = 
											(((G_buf[L.src][i + 0] >> 0) & 0x01) << 7) +
											(((G_buf[L.src][i + 0] >> 4) & 0x01) << 6) +
											(((G_buf[L.src][i + 1] >> 0) & 0x01) << 5) +
											(((G_buf[L.src][i + 1] >> 4) & 0x01) << 4) +
											(((G_buf[L.src][i + 2] >> 0) & 0x01) << 3) +
											(((G_buf[L.src][i + 2] >> 4) & 0x01) << 2) +
											(((G_buf[L.src][i + 3] >> 0) & 0x01) << 1) +
											(((G_buf[L.src][i + 3] >> 4) & 0x01) << 0)
			G_buf[L.src .. "_mgfx"][i + 1] =
											(((G_buf[L.src][i + 0] >> 1) & 0x01) << 7) +
											(((G_buf[L.src][i + 0] >> 5) & 0x01) << 6) +
											(((G_buf[L.src][i + 1] >> 1) & 0x01) << 5) +
											(((G_buf[L.src][i + 1] >> 5) & 0x01) << 4) +
											(((G_buf[L.src][i + 2] >> 1) & 0x01) << 3) +
											(((G_buf[L.src][i + 2] >> 5) & 0x01) << 2) +
											(((G_buf[L.src][i + 3] >> 1) & 0x01) << 1) +
											(((G_buf[L.src][i + 3] >> 5) & 0x01) << 0)
			G_buf[L.src .. "_mgfx"][i + 2] =
											(((G_buf[L.src][i + 0] >> 2) & 0x01) << 7) +
											(((G_buf[L.src][i + 0] >> 6) & 0x01) << 6) +
											(((G_buf[L.src][i + 1] >> 2) & 0x01) << 5) +
											(((G_buf[L.src][i + 1] >> 6) & 0x01) << 4) +
											(((G_buf[L.src][i + 2] >> 2) & 0x01) << 3) +
											(((G_buf[L.src][i + 2] >> 6) & 0x01) << 2) +
											(((G_buf[L.src][i + 3] >> 2) & 0x01) << 1) +
											(((G_buf[L.src][i + 3] >> 6) & 0x01) << 0)
			G_buf[L.src .. "_mgfx"][i + 3] =
											(((G_buf[L.src][i + 0] >> 3) & 0x01) << 7) +
											(((G_buf[L.src][i + 0] >> 7) & 0x01) << 6) +
											(((G_buf[L.src][i + 1] >> 3) & 0x01) << 5) +
											(((G_buf[L.src][i + 1] >> 7) & 0x01) << 4) +
											(((G_buf[L.src][i + 2] >> 3) & 0x01) << 3) +
											(((G_buf[L.src][i + 2] >> 7) & 0x01) << 2) +
											(((G_buf[L.src][i + 3] >> 3) & 0x01) << 1) +
											(((G_buf[L.src][i + 3] >> 7) & 0x01) << 0)
		end
		if G_conf.debug == true then
			local debug_fp
			local dbg = {}
			for j = 1, #G_buf[L.src] do
				dbg[j] = string.char(G_buf[L.src][j])
			end
			debug_fp = io.open(L.src .. "_dbg_sf30thac", "w+b")
			debug_fp:write(table.concat(dbg))
			debug_fp:close()
			
			local dbg = {}
			for j = 1, #G_buf[L.src .. "_mgfx"] do
				dbg[j] = string.char(G_buf[L.src .. "_mgfx"][j])
			end
			debug_fp = io.open(L.src .. "_dbg_mgfx", "w+b")
			debug_fp:write(table.concat(dbg))
			debug_fp:close()
			
		end
	end
	-- extract mame gfx to eeprom
	if L.ext == EXTRACT_GFX_CPS1 then
		for i = 1, L.size, 2 do
			--                                 start     byte offset                   2bytes
			t[i + 0] = G_buf[L.src .. "_mgfx"][L.start + math.floor((i - 1) / 2) * 8 + 1]
			t[i + 1] = G_buf[L.src .. "_mgfx"][L.start + math.floor((i - 1) / 2) * 8 + 2]
		end
	elseif L.ext == EXTRACT_GFX_CPS2 then
		for i = 1, L.size, 4 do
			--                                 start     chunk      brock offset                                 byte offset                                 2bytes
			t[i + 0] = G_buf[L.src .. "_mgfx"][L.start + 0x000000 + math.floor((i - 1) / (0x80000)) * 0x200000 + (math.floor((i - 1) % (0x80000)) / 4) * 8 + 1]
			t[i + 1] = G_buf[L.src .. "_mgfx"][L.start + 0x000000 + math.floor((i - 1) / (0x80000)) * 0x200000 + (math.floor((i - 1) % (0x80000)) / 4) * 8 + 2]
			t[i + 2] = G_buf[L.src .. "_mgfx"][L.start + 0x100000 + math.floor((i - 1) / (0x80000)) * 0x200000 + (math.floor((i - 1) % (0x80000)) / 4) * 8 + 1]
			t[i + 3] = G_buf[L.src .. "_mgfx"][L.start + 0x100000 + math.floor((i - 1) / (0x80000)) * 0x200000 + (math.floor((i - 1) % (0x80000)) / 4) * 8 + 2]
		end
	end
	for i = 1, #t do
		t[i] = string.char(t[i])
	end
	out_fp = io.open(L.dir .. "/" .. L.tar, "w+b")
	out_fp:write(table.concat(t))
	out_fp:close()
end

function extract_gfx_acac(L)
	local t = {}
	local u = {}
	local offset
	
	if (L.ext == EXTRACT_GFX_ACAC0) then
		offset = 0
	elseif (L.ext == EXTRACT_GFX_ACAC1) then
		offset = 2
	else
		return
	end
	
	for i = 1, L.size*2 do
		t[i] = G_buf[L.src][L.start + i]
	end
	if L.swap == SWAP_ON then
		t = byte_swap(t)
	end
	
	for i = 1, (#t)/2, 2 do
		u[i]   = string.char(t[(i - 1)*2 +1     + offset])
		u[i+1] = string.char(t[(i - 1)*2 +1 + 1 + offset])
	end
	out_fp = io.open(L.dir .. "/" .. L.tar, "w+b")
	out_fp:write(table.concat(u))
	out_fp:close()
end

function extract_xor(L)
	local t = {}
	
	if G_buf[string.sub(L.src, 1, string.len(L.src) - 1) .. "k"] == nil then
		print("ERROR need to load " .. string.sub(L.src, 1, string.len(L.src) - 1) .. "k")
		return
	end
	
	for i = 1, L.size do
		t[i] = G_buf[L.src][L.start + i] ~ G_buf[string.sub(L.src, 1, string.len(L.src) - 1) .. "k"][L.start + i]
	end
	if L.swap == SWAP_ON then
		t = byte_swap(t)
	end
	
	for i = 1, #t do
		t[i] = string.char(t[i])
	end
	out_fp = io.open(L.dir .. "/" .. L.tar, "w+b")
	out_fp:write(table.concat(t))
	out_fp:close()
end

function extract_odd_even(L)
	local t = {}
	local u = {}
	local odd_even
	
	if (L.ext == EXTRACT_ODD) then
		odd_even = 0
	elseif (L.ext == EXTRACT_EVEN) then
		odd_even = 1
	else
		return
	end

	for i = 1, L.size *2 do
		t[i] = G_buf[L.src][L.start + i]
	end
	if L.swap == SWAP_ON then
		t = byte_swap(t)
	end
	
	for i = 1, L.size do
		u[i] = string.char(t[(i - 1) * 2 + 1 + odd_even])
	end
	out_fp = io.open(L.dir .. "/" .. L.tar, "w+b")
	out_fp:write(table.concat(u))
	out_fp:close()
end

function load_src_sub(src)
	local src_str
	local src_fp
	local t = {}
	local src_size
	print("Loading " .. src .. "...")
	G_buf[src] = {}
	src_fp = io.open(src, "rb")
	if src_fp == nil then
		print("ERROR can not open:" .. src)
		os.exit()
	end
	src_size = src_fp:seek("end")
	src_fp:seek("set")
	src_str = src_fp:read(src_size)
	src_fp:close()
	
	for i = 1, src_size do
		G_buf[src][i] = string.byte(src_str, i, i)
	end
end

function load_src(game)
	for i = 1, #game do
		if G_buf[game[i].src] == nil then
			load_src_sub(game[i].src)
		end
	end
	if game.gfx_patch ~= nil then
		for i = 1, #game.gfx_patch do
			if (G_conf.gfxpatch == true) and (game.gfx_patch[i].src ~= nil) then
				if G_buf[game.gfx_patch[i].src] == nil then
					load_src_sub(game.gfx_patch[i].src)
				end
			end
		end
	end
end

function make_dir(game)
	local dir = {}
	for i = 1, #game do
		if dir[game[i].dir] == nil then
			dir[game[i].dir] = game[i].dir
			print("Making " .. game[i].dir .. " directory...")
			os.execute("mkdir " .. game[i].dir)
		end
	end
	for i = 1, #game.alt_list do
		if dir[game.alt_list[i].dir] == nil then
			dir[game.alt_list[i].dir] = game.alt_list[i].dir
			print("Making " .. game.alt_list[i].dir .. " directory...")
			os.execute("mkdir " .. game.alt_list[i].dir)
		end
	end
end

function gfxpatch(game)
	print("Graphic patching...")
	for i = 1, #game.gfx_patch do
		for j = 1, #game.gfx_patch[i].patch do
			for k = 1, game.gfx_patch[i].block do
				if game.gfx_patch[i].patch[j].dest_offset ~= nil then
					G_buf[game.gfx_patch[i].dest][game.gfx_patch[i].patch[j].dest_offset + 1 + (k - 1)] = G_buf[game.gfx_patch[i].src][game.gfx_patch[i].patch[j].src_offset + 1 + (k - 1)]
				end
			end
		end
	end
end

function make_rom(game)
	for i = 1, #game do
		print("Making " .. game[i].tar .. "...")
		if game[i].ext == EXTRACT_NORMAL then
			extract_normal(game[i])
		elseif (game[i].ext == EXTRACT_GFX_CPS1) or (game[i].ext == EXTRACT_GFX_CPS2) then
			if G_conf.gfxpatch == true then
				gfxpatch(game)
				G_conf.gfxpatch = false
			end
			extract_gfx(game[i])
		elseif (game[i].ext == EXTRACT_XOR) then
			extract_xor(game[i])
		elseif (game[i].ext == EXTRACT_ODD) or (game[i].ext == EXTRACT_EVEN) then
			extract_odd_even(game[i])
		elseif (game[i].ext == EXTRACT_GFX_ACAC0) or (game[i].ext == EXTRACT_GFX_ACAC1) then
			extract_gfx_acac(game[i])
		else
		end
	end
end

function make_alt(game)
	local t = {}
	for i = 1, #game.alt_list do
		t = {}
		for j = 1,#game.alt_list[i].data do
			t[j] = string.char(game.alt_list[i].data[j])
		end
		if (#t > 0) or (G_conf.alt == true) then
			print("Making alt " .. game.alt_list[i].tar .. "...")
			out_fp = io.open(game.alt_list[i].dir .. "/" .. game.alt_list[i].tar, "w+b")
			out_fp:write(table.concat(t))
			out_fp:close()
		end
	end
end

function arg_chek()
	if #arg < 1 then
		local msg = ""
		for key, val in pairs(G_ext_list) do
			msg = key .. "|" .. msg
		end
		print("usage:extract_game.lua [" .. string.sub(msg, 1 , string.len(msg) - 1) .. "]" ..
								    " [" .. G_alt .. "]" ..
--								    " [" .. G_gfxpatch .. "]" ..
								    " [" .. G_debug .. "]")
		print("  " .. G_alt    .. "       "   .. ":make altanative file")
--		print("  " .. G_gfxpatch .. "  "      .. ":sf30thac graphic patch(ex:guile stage)")
		print("  " .. G_debug    .. "     "   .. ":debug output")
		os.exit()
	end
	if G_ext_list[arg[1]] == nil then
		print("ERROR unknown option:" .. arg[1])
		os.exit()
	end
	for i = 2, #arg do
		if arg[i] == G_alt then
			G_conf.alt = true
			print(G_alt .. " enabled")
		-- gfxpatch is not support
		elseif arg[i] == G_gfxpatch then
			G_conf.gfxpatch = true
			print(G_gfxpatch .. " enabled")
		elseif arg[i] == G_debug then
			G_conf.debug = true
			print(G_debug .. " enabled")
		end
	end
end

-- main
arg_chek()
load_src(G_ext_list[arg[1]])
make_dir(G_ext_list[arg[1]])
make_rom(G_ext_list[arg[1]])
make_alt(G_ext_list[arg[1]])
