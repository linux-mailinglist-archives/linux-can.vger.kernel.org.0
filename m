Return-Path: <linux-can+bounces-3926-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D579AECE3B
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 17:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DA816FCF0
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0121A455;
	Sun, 29 Jun 2025 15:04:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ACE28FD;
	Sun, 29 Jun 2025 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751209473; cv=none; b=iaX69prxbfZU7NXhurBGsCq/4V328Q+alE2PYZvsirgKR5CzIeXgHPVh2U++kf33RblEUsuMa5wTkzJjtsse5q0RtMjIaRGE43PD6Vt9lyPioUrB1O+/Wvw6ZzqyyPMWaoOyqO+u3PiIdW/ZxnVHGKDT4lqzG0esDNf+VyffcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751209473; c=relaxed/simple;
	bh=lWCw/myXaq3tHPNPHXR1HXFhfg6bnflRejYCkw2u7hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWYQi9VhLX4K3hk7gyBcx1VBqCueib8e8hJIsHSR9+ZqnFdqyAsvXAFgYtIevtlJGfxSno7zMnZn9cWODTnwVKnygJ6hMNP9rB8swAZQA12g/vAiVok9qRtkhO/meFpreJAgjaUr7kLoYf69igsPFzN+DHsvCnx/Lruf9ljgb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: brDTDzd9TNqxn+BJts1GuQ==
X-CSE-MsgGUID: mdxXcmeVRdmERK51+SUOGg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jun 2025 00:04:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.30])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79A984200700;
	Mon, 30 Jun 2025 00:04:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] can: rcar_canfd: Drop unused macros
Date: Sun, 29 Jun 2025 16:04:14 +0100
Message-ID: <20250629150417.97784-1-biju.das.jz@bp.renesas.com>
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
 drivers/net/can/rcar/rcar_canfd.c | 136 ------------------------------
 1 file changed, 136 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 417d9196f41e..2b6f100e0f05 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -51,25 +51,17 @@
 #define RCANFD_GCFG_EEFE		BIT(6)
 #define RCANFD_GCFG_CMPOC		BIT(5)	/* CAN FD only */
 #define RCANFD_GCFG_DCS			BIT(4)
-#define RCANFD_GCFG_DCE			BIT(1)
-#define RCANFD_GCFG_TPRI		BIT(0)
 
 /* RSCFDnCFDGCTR / RSCFDnGCTR */
-#define RCANFD_GCTR_TSRST		BIT(16)
 #define RCANFD_GCTR_CFMPOFIE		BIT(11)	/* CAN FD only */
-#define RCANFD_GCTR_THLEIE		BIT(10)
 #define RCANFD_GCTR_MEIE		BIT(9)
-#define RCANFD_GCTR_DEIE		BIT(8)
 #define RCANFD_GCTR_GSLPR		BIT(2)
 #define RCANFD_GCTR_GMDC_MASK		(0x3)
 #define RCANFD_GCTR_GMDC_GOPM		(0x0)
 #define RCANFD_GCTR_GMDC_GRESET		(0x1)
-#define RCANFD_GCTR_GMDC_GTEST		(0x2)
 
 /* RSCFDnCFDGSTS / RSCFDnGSTS */
 #define RCANFD_GSTS_GRAMINIT		BIT(3)
-#define RCANFD_GSTS_GSLPSTS		BIT(2)
-#define RCANFD_GSTS_GHLTSTS		BIT(1)
 #define RCANFD_GSTS_GRSTSTS		BIT(0)
 /* Non-operational status */
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
@@ -77,9 +69,7 @@
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
 #define RCANFD_GERFL_EEF		GENMASK(23, 16)
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
-#define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
-#define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
 ({\
@@ -94,9 +84,6 @@
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(gpriv, page_num)	((page_num) & (gpriv)->info->max_aflpn)
 
-/* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
-#define RCANFD_GAFLID_GAFLLB		BIT(29)
-
 /* RSCFDnCFDGAFLP1_j / RSCFDnGAFLP1_j */
 #define RCANFD_GAFLP1_GAFLFDP(x)	(1 << (x))
 
@@ -121,15 +108,9 @@
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
-#define RCANFD_CCTR_CTME		BIT(24)
 #define RCANFD_CCTR_ERRD		BIT(23)
 #define RCANFD_CCTR_BOM_MASK		(0x3 << 21)
-#define RCANFD_CCTR_BOM_ISO		(0x0 << 21)
 #define RCANFD_CCTR_BOM_BENTRY		(0x1 << 21)
-#define RCANFD_CCTR_BOM_BEND		(0x2 << 21)
-#define RCANFD_CCTR_TDCVFIE		BIT(19)
-#define RCANFD_CCTR_SOCOIE		BIT(18)
-#define RCANFD_CCTR_EOCOIE		BIT(17)
 #define RCANFD_CCTR_TAIE		BIT(16)
 #define RCANFD_CCTR_ALIE		BIT(15)
 #define RCANFD_CCTR_BLIE		BIT(14)
@@ -143,16 +124,9 @@
 #define RCANFD_CCTR_CHMDC_MASK		(0x3)
 #define RCANFD_CCTR_CHDMC_COPM		(0x0)
 #define RCANFD_CCTR_CHDMC_CRESET	(0x1)
-#define RCANFD_CCTR_CHDMC_CHLT		(0x2)
 
 /* RSCFDnCFDCmSTS / RSCFDnCmSTS */
 #define RCANFD_CSTS_COMSTS		BIT(7)
-#define RCANFD_CSTS_RECSTS		BIT(6)
-#define RCANFD_CSTS_TRMSTS		BIT(5)
-#define RCANFD_CSTS_BOSTS		BIT(4)
-#define RCANFD_CSTS_EPSTS		BIT(3)
-#define RCANFD_CSTS_SLPSTS		BIT(2)
-#define RCANFD_CSTS_HLTSTS		BIT(1)
 #define RCANFD_CSTS_CRSTSTS		BIT(0)
 
 #define RCANFD_CSTS_TECCNT(x)		(((x) >> 24) & 0xff)
@@ -169,7 +143,6 @@
 #define RCANFD_CERFL_ALF		BIT(7)
 #define RCANFD_CERFL_BLF		BIT(6)
 #define RCANFD_CERFL_OVLF		BIT(5)
-#define RCANFD_CERFL_BORF		BIT(4)
 #define RCANFD_CERFL_BOEF		BIT(3)
 #define RCANFD_CERFL_EPF		BIT(2)
 #define RCANFD_CERFL_EWF		BIT(1)
@@ -196,13 +169,6 @@
 #define RCANFD_FDCFG_TDCOC		BIT(8)
 
 /* RSCFDnCFDCmFDSTS */
-#define RCANFD_FDSTS_SOC		GENMASK(31, 24)
-#define RCANFD_FDSTS_EOC		GENMASK(23, 16)
-#define RCANFD_GEN4_FDSTS_TDCVF		BIT(15)
-#define RCANFD_GEN4_FDSTS_PNSTS		GENMASK(13, 12)
-#define RCANFD_FDSTS_SOCO		BIT(9)
-#define RCANFD_FDSTS_EOCO		BIT(8)
-#define RCANFD_FDSTS_TDCVF		BIT(7)
 #define RCANFD_FDSTS_TDCR		GENMASK(7, 0)
 
 /* RSCFDnCFDRFCCx */
@@ -215,7 +181,6 @@
 /* RSCFDnCFDRFSTSx */
 #define RCANFD_RFSTS_RFIF		BIT(3)
 #define RCANFD_RFSTS_RFMLT		BIT(2)
-#define RCANFD_RFSTS_RFFLL		BIT(1)
 #define RCANFD_RFSTS_RFEMP		BIT(0)
 
 /* RSCFDnCFDRFIDx */
@@ -224,8 +189,6 @@
 
 /* RSCFDnCFDRFPTRx */
 #define RCANFD_RFPTR_RFDLC(x)		(((x) >> 28) & 0xf)
-#define RCANFD_RFPTR_RFPTR(x)		(((x) >> 16) & 0xfff)
-#define RCANFD_RFPTR_RFTS(x)		(((x) >> 0) & 0xffff)
 
 /* RSCFDnCFDRFFDSTSx */
 #define RCANFD_RFFDSTS_RFFDF		BIT(2)
@@ -251,18 +214,13 @@
 #define RCANFD_CFSTS_CFMC(x)		(((x) >> 8) & 0xff)
 #define RCANFD_CFSTS_CFTXIF		BIT(4)
 #define RCANFD_CFSTS_CFMLT		BIT(2)
-#define RCANFD_CFSTS_CFFLL		BIT(1)
-#define RCANFD_CFSTS_CFEMP		BIT(0)
 
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
@@ -298,16 +256,10 @@
 #define RCANFD_GSTS			(0x008c)
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
 #define RCANFD_GERFL			(0x0090)
-/* RSCFDnCFDGTSC / RSCFDnGTSC */
-#define RCANFD_GTSC			(0x0094)
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR			(0x0098)
 /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
 #define RCANFD_GAFLCFG(w)		(0x009c + (0x04 * (w)))
-/* RSCFDnCFDRMNB / RSCFDnRMNB */
-#define RCANFD_RMNB			(0x00a4)
-/* RSCFDnCFDRMND / RSCFDnRMND */
-#define RCANFD_RMND(y)			(0x00a8 + (0x04 * (y)))
 
 /* RSCFDnCFDRFCCx / RSCFDnRFCCx */
 #define RCANFD_RFCC(gpriv, x)		((gpriv)->info->regs->rfcc + (0x04 * (x)))
@@ -328,59 +280,6 @@
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
 
@@ -398,12 +297,6 @@
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
@@ -423,17 +316,6 @@
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
 
@@ -452,12 +334,6 @@ struct rcar_canfd_f_c {
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
@@ -482,23 +358,11 @@ struct rcar_canfd_f_c {
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


