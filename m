Return-Path: <linux-can+bounces-3964-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F70B0198B
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537184A0F1C
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF6374F1;
	Fri, 11 Jul 2025 10:17:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AE27C16A
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229035; cv=none; b=VOuqYjmjjumSb+wn9O3NOENpJuO4b4unC5Fzne/yEYtB04jZI/DLlNU24JPE716DW8Mfa7Ncld9TRmKZCxWk8vM5YCUFleSQXbXz3pQUoBABgu3cTPkwtohJ1cYe3k+n+eYj/tPAfl/QsYl7KdvH48oOOmQ7zl44aVHkhTq3Pc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229035; c=relaxed/simple;
	bh=Ekq+xAKvXAsqXPLqVu7/Y+AwTXUDuteGIScKB8RA+SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mveapQueq0Fa08nUxp5nBPKqr5wMvCGBkbxFPdlH7l3qmllgCAztS9CjOtUxLAZnKnDj2Z9Rb82tg7rv0QTqCbJ0SghO944Er8afMt73r6gENsdWO9h+PlUba5W9OqsWtkWmNWe8PifXMnbvJFEAKGbARh9Y08gsf95B/RjfU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAoZ-00040q-AT
	for linux-can@vger.kernel.org; Fri, 11 Jul 2025 12:17:11 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAoZ-007uAd-0D
	for linux-can@vger.kernel.org;
	Fri, 11 Jul 2025 12:17:11 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B982643C7EC
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:17:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0909F43C7DA;
	Fri, 11 Jul 2025 10:17:09 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5c466603;
	Fri, 11 Jul 2025 10:17:07 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/2] can: rcar_canfd: Drop unused macros
Date: Fri, 11 Jul 2025 12:15:09 +0200
Message-ID: <20250711101706.2822687-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711101706.2822687-1-mkl@pengutronix.de>
References: <20250711101706.2822687-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop unused macros from the rcar_canfd.c.

Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Closes: https://lore.kernel.org/all/7ff93ff9-f578-4be2-bdc6-5b09eab64fe6@wanadoo.fr/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250702120539.98490-1-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.47.2



