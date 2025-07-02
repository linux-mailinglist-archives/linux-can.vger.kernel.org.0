Return-Path: <linux-can+bounces-3934-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9935AF14F8
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F7918918F7
	for <lists+linux-can@lfdr.de>; Wed,  2 Jul 2025 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88426D4D9;
	Wed,  2 Jul 2025 12:05:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C326C3B8;
	Wed,  2 Jul 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457955; cv=none; b=VExL/KJmK251puw4k5IwJE8q01jh0ZbdHIy6FpiRxn5DJ35hEuMR/lQzjJxvqdhEU5cLmMJRyZFvYKiPriIGjLxNUNUJ2DJyVOXN2uRtUMZYa3xrc/yAmp9k/pw3o6GUBemlPQ24lQ3GgLbyto532Psjesgdf2AYPpJQdgzyq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457955; c=relaxed/simple;
	bh=otXCCYDqXbZXzkKorXyslIDNgdIqmIjtatTHokyVyaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBq5w8j6oC/A45Cj/nHnArTEiWW14kqBY6ri3T6zGwEmISdgqBJTY+jLkqkWeVSDZZPH/Syg0Va4disaRH6m8OJV0ThW+nUJSFXPYGgdZUryfeOVAj+M0+UKFVNrf21qOzkZfVzHQknOcxtTpsWGQo8zZA40TFWquCublYjwCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: r+eVYdDBQ12wGVrnc62sUw==
X-CSE-MsgGUID: jwJuG788SIe8xFaxH6/DJw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jul 2025 21:05:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.89])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5BBDC41F551C;
	Wed,  2 Jul 2025 21:05:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2] can: rcar_canfd: Drop unused macros
Date: Wed,  2 Jul 2025 13:05:29 +0100
Message-ID: <20250702120539.98490-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unused macros from the rcar_canfd.c.

Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped the Rb tags.
 * Restored simple simple bit definitions as it serve as documentation.
 * Restored register offsets will become anonymous gaps when the register
   offsets are replaced by C structs.
---
 drivers/net/can/rcar/rcar_canfd.c | 93 -------------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 417d9196f41e..b3c8c592fb0e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -224,8 +224,6 @@
 
 /* RSCFDnCFDRFPTRx */
 #define RCANFD_RFPTR_RFDLC(x)		(((x) >> 28) & 0xf)
-#define RCANFD_RFPTR_RFPTR(x)		(((x) >> 16) & 0xfff)
-#define RCANFD_RFPTR_RFTS(x)		(((x) >> 0) & 0xffff)
 
 /* RSCFDnCFDRFFDSTSx */
 #define RCANFD_RFFDSTS_RFFDF		BIT(2)
@@ -257,12 +255,9 @@
 /* RSCFDnCFDCFIDk */
 #define RCANFD_CFID_CFIDE		BIT(31)
 #define RCANFD_CFID_CFRTR		BIT(30)
-#define RCANFD_CFID_CFID_MASK(x)	((x) & 0x1fffffff)
 
 /* RSCFDnCFDCFPTRk */
 #define RCANFD_CFPTR_CFDLC(x)		(((x) & 0xf) << 28)
-#define RCANFD_CFPTR_CFPTR(x)		(((x) & 0xfff) << 16)
-#define RCANFD_CFPTR_CFTS(x)		(((x) & 0xff) << 0)
 
 /* RSCFDnCFDCFFDCSTSk */
 #define RCANFD_CFFDCSTS_CFFDF		BIT(2)
@@ -328,59 +323,6 @@
 #define RCANFD_CFPCTR(gpriv, ch, idx) \
 	((gpriv)->info->regs->cfpctr + (0x0c * (ch)) + (0x04 * (idx)))
 
-/* RSCFDnCFDFESTS / RSCFDnFESTS */
-#define RCANFD_FESTS			(0x0238)
-/* RSCFDnCFDFFSTS / RSCFDnFFSTS */
-#define RCANFD_FFSTS			(0x023c)
-/* RSCFDnCFDFMSTS / RSCFDnFMSTS */
-#define RCANFD_FMSTS			(0x0240)
-/* RSCFDnCFDRFISTS / RSCFDnRFISTS */
-#define RCANFD_RFISTS			(0x0244)
-/* RSCFDnCFDCFRISTS / RSCFDnCFRISTS */
-#define RCANFD_CFRISTS			(0x0248)
-/* RSCFDnCFDCFTISTS / RSCFDnCFTISTS */
-#define RCANFD_CFTISTS			(0x024c)
-
-/* RSCFDnCFDTMCp / RSCFDnTMCp */
-#define RCANFD_TMC(p)			(0x0250 + (0x01 * (p)))
-/* RSCFDnCFDTMSTSp / RSCFDnTMSTSp */
-#define RCANFD_TMSTS(p)			(0x02d0 + (0x01 * (p)))
-
-/* RSCFDnCFDTMTRSTSp / RSCFDnTMTRSTSp */
-#define RCANFD_TMTRSTS(y)		(0x0350 + (0x04 * (y)))
-/* RSCFDnCFDTMTARSTSp / RSCFDnTMTARSTSp */
-#define RCANFD_TMTARSTS(y)		(0x0360 + (0x04 * (y)))
-/* RSCFDnCFDTMTCSTSp / RSCFDnTMTCSTSp */
-#define RCANFD_TMTCSTS(y)		(0x0370 + (0x04 * (y)))
-/* RSCFDnCFDTMTASTSp / RSCFDnTMTASTSp */
-#define RCANFD_TMTASTS(y)		(0x0380 + (0x04 * (y)))
-/* RSCFDnCFDTMIECy / RSCFDnTMIECy */
-#define RCANFD_TMIEC(y)			(0x0390 + (0x04 * (y)))
-
-/* RSCFDnCFDTXQCCm / RSCFDnTXQCCm */
-#define RCANFD_TXQCC(m)			(0x03a0 + (0x04 * (m)))
-/* RSCFDnCFDTXQSTSm / RSCFDnTXQSTSm */
-#define RCANFD_TXQSTS(m)		(0x03c0 + (0x04 * (m)))
-/* RSCFDnCFDTXQPCTRm / RSCFDnTXQPCTRm */
-#define RCANFD_TXQPCTR(m)		(0x03e0 + (0x04 * (m)))
-
-/* RSCFDnCFDTHLCCm / RSCFDnTHLCCm */
-#define RCANFD_THLCC(m)			(0x0400 + (0x04 * (m)))
-/* RSCFDnCFDTHLSTSm / RSCFDnTHLSTSm */
-#define RCANFD_THLSTS(m)		(0x0420 + (0x04 * (m)))
-/* RSCFDnCFDTHLPCTRm / RSCFDnTHLPCTRm */
-#define RCANFD_THLPCTR(m)		(0x0440 + (0x04 * (m)))
-
-/* RSCFDnCFDGTINTSTS0 / RSCFDnGTINTSTS0 */
-#define RCANFD_GTINTSTS0		(0x0460)
-/* RSCFDnCFDGTINTSTS1 / RSCFDnGTINTSTS1 */
-#define RCANFD_GTINTSTS1		(0x0464)
-/* RSCFDnCFDGTSTCFG / RSCFDnGTSTCFG */
-#define RCANFD_GTSTCFG			(0x0468)
-/* RSCFDnCFDGTSTCTR / RSCFDnGTSTCTR */
-#define RCANFD_GTSTCTR			(0x046c)
-/* RSCFDnCFDGLOCKK / RSCFDnGLOCKK */
-#define RCANFD_GLOCKK			(0x047c)
 /* RSCFDnCFDGRMCFG */
 #define RCANFD_GRMCFG			(0x04fc)
 
@@ -398,12 +340,6 @@
 /* RSCFDnGAFLXXXj offset */
 #define RCANFD_C_GAFL_OFFSET		(0x0500)
 
-/* RSCFDnRMXXXq -> RCANFD_C_RMXXX(q) */
-#define RCANFD_C_RMID(q)		(0x0600 + (0x10 * (q)))
-#define RCANFD_C_RMPTR(q)		(0x0604 + (0x10 * (q)))
-#define RCANFD_C_RMDF0(q)		(0x0608 + (0x10 * (q)))
-#define RCANFD_C_RMDF1(q)		(0x060c + (0x10 * (q)))
-
 /* RSCFDnRFXXx -> RCANFD_C_RFXX(x) */
 #define RCANFD_C_RFOFFSET	(0x0e00)
 #define RCANFD_C_RFID(x)	(RCANFD_C_RFOFFSET + (0x10 * (x)))
@@ -423,17 +359,6 @@
 #define RCANFD_C_CFDF(ch, idx, df) \
 	(RCANFD_C_CFOFFSET + 0x08 + (0x30 * (ch)) + (0x10 * (idx)) + (0x04 * (df)))
 
-/* RSCFDnTMXXp -> RCANFD_C_TMXX(p) */
-#define RCANFD_C_TMID(p)		(0x1000 + (0x10 * (p)))
-#define RCANFD_C_TMPTR(p)		(0x1004 + (0x10 * (p)))
-#define RCANFD_C_TMDF0(p)		(0x1008 + (0x10 * (p)))
-#define RCANFD_C_TMDF1(p)		(0x100c + (0x10 * (p)))
-
-/* RSCFDnTHLACCm */
-#define RCANFD_C_THLACC(m)		(0x1800 + (0x04 * (m)))
-/* RSCFDnRPGACCr */
-#define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
-
 /* R-Car Gen4 Classical and CAN FD mode specific register map */
 #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
 
@@ -452,12 +377,6 @@ struct rcar_canfd_f_c {
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
-/* RSCFDnCFDRMXXXq -> RCANFD_F_RMXXX(q) */
-#define RCANFD_F_RMID(q)		(0x2000 + (0x20 * (q)))
-#define RCANFD_F_RMPTR(q)		(0x2004 + (0x20 * (q)))
-#define RCANFD_F_RMFDSTS(q)		(0x2008 + (0x20 * (q)))
-#define RCANFD_F_RMDF(q, b)		(0x200c + (0x04 * (b)) + (0x20 * (q)))
-
 /* RSCFDnCFDRFXXx -> RCANFD_F_RFXX(x) */
 #define RCANFD_F_RFOFFSET(gpriv)	((gpriv)->info->regs->rfoffset)
 #define RCANFD_F_RFID(gpriv, x)		(RCANFD_F_RFOFFSET(gpriv) + (0x80 * (x)))
@@ -482,23 +401,11 @@ struct rcar_canfd_f_c {
 	(RCANFD_F_CFOFFSET(gpriv) + 0x0c + (0x180 * (ch)) + (0x80 * (idx)) + \
 	 (0x04 * (df)))
 
-/* RSCFDnCFDTMXXp -> RCANFD_F_TMXX(p) */
-#define RCANFD_F_TMID(p)		(0x4000 + (0x20 * (p)))
-#define RCANFD_F_TMPTR(p)		(0x4004 + (0x20 * (p)))
-#define RCANFD_F_TMFDCTR(p)		(0x4008 + (0x20 * (p)))
-#define RCANFD_F_TMDF(p, b)		(0x400c + (0x20 * (p)) + (0x04 * (b)))
-
-/* RSCFDnCFDTHLACCm */
-#define RCANFD_F_THLACC(m)		(0x6000 + (0x04 * (m)))
-/* RSCFDnCFDRPGACCr */
-#define RCANFD_F_RPGACC(r)		(0x6400 + (0x04 * (r)))
-
 /* Constants */
 #define RCANFD_FIFO_DEPTH		8	/* Tx FIFO depth */
 #define RCANFD_NAPI_WEIGHT		8	/* Rx poll quota */
 
 #define RCANFD_NUM_CHANNELS		8	/* Eight channels max */
-#define RCANFD_CHANNELS_MASK		BIT((RCANFD_NUM_CHANNELS) - 1)
 
 #define RCANFD_GAFL_PAGENUM(entry)	((entry) / 16)
 #define RCANFD_CHANNEL_NUMRULES		1	/* only one rule per channel */
-- 
2.43.0


