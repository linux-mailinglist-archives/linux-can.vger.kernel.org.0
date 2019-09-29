Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DAC1408
	for <lists+linux-can@lfdr.de>; Sun, 29 Sep 2019 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfI2JGD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Sep 2019 05:06:03 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22076 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfI2JGD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2019 05:06:03 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Thomas.Kopp@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="Thomas.Kopp@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Thomas.Kopp@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Thomas.Kopp@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: hgJPKTn2rqhX66Yzg4fM7EVauB9YMkcf8+3OR0R1qJt5oHNcj5zfrGPFjWcHQPxoq/7BIjIBwI
 ECgBJZ3uCOU61kOYPkY2eLuaMIcKbsofRNa8c9VAjJaypst+684UVDgiZ04Rvt8PxP6W5/IyrV
 g/T/kFO3ilNI1q2wVE2APp+dl+PgoCQUhRtd+WeETTaHCJ/40M7/DFTpCfR853NklJQaRsorcn
 4eJI9/wrg2E+reCpsaueL8RNGSS9nZLscxWPyN38XakMz1hphj3a1tngTVshdAvS6tkbKosMrx
 z5k=
X-IronPort-AV: E=Sophos;i="5.64,562,1559545200"; 
   d="scan'208";a="48071961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2019 02:06:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 29 Sep 2019 02:05:59 -0700
Received: from HNO-LT-M43677A.fritz.box (10.10.85.251) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Sun, 29 Sep 2019 02:05:58 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-can@vger.kernel.org>
CC:     <martin@sperl.org>, <mkl@pengutronix.de>,
        <thomas.kopp@microchip.com>
Subject: [PATCH] can: mcp25xxfd: fix register definitions, cleanup names to match DS
Date:   Sun, 29 Sep 2019 11:05:43 +0200
Message-ID: <20190929090543.438-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixing a couple MCP25xxFD reg/bit definitions, switching to the names used in the DS.
Patch is against the latest from Martin Sperl's github

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c    |   4 +-
 .../net/can/spi/mcp25xxfd/mcp25xxfd_regs.h    | 104 +++++++++---------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
index e17254af1d89..990c3a77da9d 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
@@ -144,8 +144,8 @@ static int mcp25xxfd_can_fifo_setup_rxfilter(struct mcp25xxfd_can_priv *cpriv)
 	for (c = 0, f = cpriv->fifos.rx.start; c < cpriv->fifos.rx.count;
 	     c++, f++) {
 		/* set up filter config - we can use the mask of filter 0 */
-		filter_con[c] = MCP25XXFD_CAN_FIFOCON_FLTEN(0) |
-			(f << MCP25XXFD_CAN_FILCON_SHIFT(0));
+		filter_con[c] = MCP25XXFD_CAN_FLTCON_FLTEN(0) |
+			(f << MCP25XXFD_CAN_FLTCON_SHIFT(0));
 	}
 
 	/* and set up filter control */
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h
index f8495e0325c2..3767539208ca 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h
@@ -53,15 +53,15 @@
 #  define MCP25XXFD_IOCON_INTOD			BIT(30)
 #define MCP25XXFD_CRC				MCP25XXFD_SFR_BASE(0x08)
 #  define MCP25XXFD_CRC_MASK			GENMASK(15, 0)
-#  define MCP25XXFD_CRC_CRCERRIE		BIT(16)
-#  define MCP25XXFD_CRC_FERRIE			BIT(17)
-#  define MCP25XXFD_CRC_CRCERRIF		BIT(24)
-#  define MCP25XXFD_CRC_FERRIF			BIT(25)
+#  define MCP25XXFD_CRC_CRCERRIF		BIT(16)
+#  define MCP25XXFD_CRC_FERRIF			BIT(17)
+#  define MCP25XXFD_CRC_CRCERRIE		BIT(24)
+#  define MCP25XXFD_CRC_FERRIE			BIT(25)
 #define MCP25XXFD_ECCCON			MCP25XXFD_SFR_BASE(0x0C)
 #  define MCP25XXFD_ECCCON_ECCEN		BIT(0)
 #  define MCP25XXFD_ECCCON_SECIE		BIT(1)
 #  define MCP25XXFD_ECCCON_DEDIE		BIT(2)
-#  define MCP25XXFD_ECCCON_PARITY_BITS		6
+#  define MCP25XXFD_ECCCON_PARITY_BITS		7
 #  define MCP25XXFD_ECCCON_PARITY_SHIFT		8
 #  define MCP25XXFD_ECCCON_PARITY_MASK					\
 	GENMASK(MCP25XXFD_ECCCON_PARITY_SHIFT				\
@@ -70,7 +70,7 @@
 #define MCP25XXFD_ECCSTAT			MCP25XXFD_SFR_BASE(0x10)
 #  define MCP25XXFD_ECCSTAT_SECIF		BIT(1)
 #  define MCP25XXFD_ECCSTAT_DEDIF		BIT(2)
-#  define MCP25XXFD_ECCSTAT_ERRADDR_SHIFT	8
+#  define MCP25XXFD_ECCSTAT_ERRADDR_SHIFT	16
 #  define MCP25XXFD_ECCSTAT_ERRADDR_MASK				\
 	GENMASK(MCP25XXFD_ECCSTAT_ERRADDR_SHIFT + 11,			\
 		MCP25XXFD_ECCSTAT_ERRADDR_SHIFT)
@@ -115,11 +115,11 @@
 #  define MCP25XXFD_CAN_CON_SERR2LOM		BIT(18)
 #  define MCP25XXFD_CAN_CON_STEF		BIT(19)
 #  define MCP25XXFD_CAN_CON_TXQEN		BIT(20)
-#  define MCP25XXFD_CAN_CON_OPMODE_BITS		3
+#  define MCP25XXFD_CAN_CON_OPMOD_BITS		3
 #  define MCP25XXFD_CAN_CON_OPMOD_SHIFT		21
 #  define MCP25XXFD_CAN_CON_OPMOD_MASK					\
 	GENMASK(MCP25XXFD_CAN_CON_OPMOD_SHIFT +				\
-		MCP25XXFD_CAN_CON_OPMODE_BITS - 1,			\
+		MCP25XXFD_CAN_CON_OPMOD_BITS - 1,			\
 		MCP25XXFD_CAN_CON_OPMOD_SHIFT)
 #  define MCP25XXFD_CAN_CON_REQOP_BITS		3
 #  define MCP25XXFD_CAN_CON_REQOP_SHIFT		24
@@ -136,7 +136,7 @@
 #    define MCP25XXFD_CAN_CON_MODE_CAN2_0	6
 #    define MCP25XXFD_CAN_CON_MODE_RESTRICTED	7
 #  define MCP25XXFD_CAN_CON_ABAT		BIT(27)
-#  define MCP25XXFD_CAN_CON_TXBWS_BITS		3
+#  define MCP25XXFD_CAN_CON_TXBWS_BITS		4
 #  define MCP25XXFD_CAN_CON_TXBWS_SHIFT		28
 #  define MCP25XXFD_CAN_CON_TXBWS_MASK					\
 	GENMASK(MCP25XXFD_CAN_CON_TXBWS_SHIFT +				\
@@ -218,13 +218,13 @@
 		MCP25XXFD_CAN_DBTCFG_BRP_BITS - 1,			\
 		MCP25XXFD_CAN_DBTCFG_BRP_SHIFT)
 #define MCP25XXFD_CAN_TDC			MCP25XXFD_CAN_SFR_BASE(0x0C)
-#  define MCP25XXFD_CAN_TDC_TDCV_BITS		5
+#  define MCP25XXFD_CAN_TDC_TDCV_BITS		6
 #  define MCP25XXFD_CAN_TDC_TDCV_SHIFT		0
 #  define MCP25XXFD_CAN_TDC_TDCV_MASK					\
 	GENMASK(MCP25XXFD_CAN_TDC_TDCV_SHIFT +				\
 		MCP25XXFD_CAN_TDC_TDCV_BITS - 1,			\
 		MCP25XXFD_CAN_TDC_TDCV_SHIFT)
-#  define MCP25XXFD_CAN_TDC_TDCO_BITS		5
+#  define MCP25XXFD_CAN_TDC_TDCO_BITS		7
 #  define MCP25XXFD_CAN_TDC_TDCO_SHIFT		8
 #  define MCP25XXFD_CAN_TDC_TDCO_MASK					\
 	GENMASK(MCP25XXFD_CAN_TDC_TDCO_SHIFT +				\
@@ -413,8 +413,8 @@
 #  define MCP25XXFD_CAN_BDIAG1_NBIT0ERR		BIT(16)
 #  define MCP25XXFD_CAN_BDIAG1_NBIT1ERR		BIT(17)
 #  define MCP25XXFD_CAN_BDIAG1_NACKERR		BIT(18)
-#  define MCP25XXFD_CAN_BDIAG1_NSTUFERR		BIT(19)
-#  define MCP25XXFD_CAN_BDIAG1_NFORMERR		BIT(20)
+#  define MCP25XXFD_CAN_BDIAG1_NFORMERR		BIT(19)
+#  define MCP25XXFD_CAN_BDIAG1_NSTUFERR		BIT(20)
 #  define MCP25XXFD_CAN_BDIAG1_NCRCERR		BIT(21)
 #  define MCP25XXFD_CAN_BDIAG1_TXBOERR		BIT(23)
 #  define MCP25XXFD_CAN_BDIAG1_DBIT0ERR		BIT(24)
@@ -442,7 +442,7 @@
 #  define MCP25XXFD_CAN_TEFSTA_TEFNEIF		BIT(0)
 #  define MCP25XXFD_CAN_TEFSTA_TEFHIF		BIT(1)
 #  define MCP25XXFD_CAN_TEFSTA_TEFFIF		BIT(2)
-#  define MCP25XXFD_CAN_TEFSTA_TEVOVIF		BIT(3)
+#  define MCP25XXFD_CAN_TEFSTA_TEFOVIF		BIT(3)
 #define MCP25XXFD_CAN_TEFUA			MCP25XXFD_CAN_SFR_BASE(0x48)
 #define MCP25XXFD_CAN_RESERVED			MCP25XXFD_CAN_SFR_BASE(0x4C)
 #define MCP25XXFD_CAN_TXQCON			MCP25XXFD_CAN_SFR_BASE(0x50)
@@ -561,47 +561,47 @@
 	MCP25XXFD_CAN_SFR_BASE(0x64 + 12 * ((x) - 1))
 #define MCP25XXFD_CAN_FLTCON(x)						\
 	MCP25XXFD_CAN_SFR_BASE(0x1D0 + ((x) & 0x1c))
-#  define MCP25XXFD_CAN_FILCON_SHIFT(x)		(((x) & 3) * 8)
-#  define MCP25XXFD_CAN_FILCON_BITS(x)		MCP25XXFD_CAN_FILCON_BITS_
-#  define MCP25XXFD_CAN_FILCON_BITS_		4
+#  define MCP25XXFD_CAN_FLTCON_SHIFT(x)		(((x) & 3) * 8)
+#  define MCP25XXFD_CAN_FLTCON_BITS(x)		MCP25XXFD_CAN_FLTCON_BITS_
+#  define MCP25XXFD_CAN_FLTCON_BITS_		5
 	/* avoid macro reuse warning, so do not use GENMASK as above */
-#  define MCP25XXFD_CAN_FILCON_MASK(x)					\
-	(GENMASK(MCP25XXFD_CAN_FILCON_BITS_ - 1, 0) <<			\
-	 MCP25XXFD_CAN_FILCON_SHIFT(x))
-#  define MCP25XXFD_CAN_FIFOCON_FLTEN(x)				\
-	BIT(7 + MCP25XXFD_CAN_FILCON_SHIFT(x))
+#  define MCP25XXFD_CAN_FLTCON_MASK(x)					\
+	(GENMASK(MCP25XXFD_CAN_FLTCON_BITS_ - 1, 0) <<			\
+	 MCP25XXFD_CAN_FLTCON_SHIFT(x))
+#  define MCP25XXFD_CAN_FLTCON_FLTEN(x)				\
+	BIT(7 + MCP25XXFD_CAN_FLTCON_SHIFT(x))
 #define MCP25XXFD_CAN_FLTOBJ(x)						\
 	MCP25XXFD_CAN_SFR_BASE(0x1F0 + 8 * (x))
-#  define MCP25XXFD_CAN_FILOBJ_SID_BITS		11
-#  define MCP25XXFD_CAN_FILOBJ_SID_SHIFT	0
-#  define MCP25XXFD_CAN_FILOBJ_SID_MASK					\
-	GENMASK(MCP25XXFD_CAN_FILOBJ_SID_SHIFT +			\
-		MCP25XXFD_CAN_FILOBJ_SID_BITS - 1,			\
-		MCP25XXFD_CAN_FILOBJ_SID_SHIFT)
-#  define MCP25XXFD_CAN_FILOBJ_EID_BITS		18
-#  define MCP25XXFD_CAN_FILOBJ_EID_SHIFT	12
-#  define MCP25XXFD_CAN_FILOBJ_EID_MASK					\
-	GENMASK(MCP25XXFD_CAN_FILOBJ_EID_SHIFT +			\
-		MCP25XXFD_CAN_FILOBJ_EID_BITS - 1,			\
-		MCP25XXFD_CAN_FILOBJ_EID_SHIFT)
-#  define MCP25XXFD_CAN_FILOBJ_SID11		BIT(29)
-#  define MCP25XXFD_CAN_FILOBJ_EXIDE		BIT(30)
+#  define MCP25XXFD_CAN_FLTOBJ_SID_BITS		11
+#  define MCP25XXFD_CAN_FLTOBJ_SID_SHIFT	0
+#  define MCP25XXFD_CAN_FLTOBJ_SID_MASK					\
+	GENMASK(MCP25XXFD_CAN_FLTOBJ_SID_SHIFT +			\
+		MCP25XXFD_CAN_FLTOBJ_SID_BITS - 1,			\
+		MCP25XXFD_CAN_FLTOBJ_SID_SHIFT)
+#  define MCP25XXFD_CAN_FLTOBJ_EID_BITS		18
+#  define MCP25XXFD_CAN_FLTOBJ_EID_SHIFT	11
+#  define MCP25XXFD_CAN_FLTOBJ_EID_MASK					\
+	GENMASK(MCP25XXFD_CAN_FLTOBJ_EID_SHIFT +			\
+		MCP25XXFD_CAN_FLTOBJ_EID_BITS - 1,			\
+		MCP25XXFD_CAN_FLTOBJ_EID_SHIFT)
+#  define MCP25XXFD_CAN_FLTOBJ_SID11		BIT(29)
+#  define MCP25XXFD_CAN_FLTOBJ_EXIDE		BIT(30)
 #define MCP25XXFD_CAN_FLTMASK(x)					\
 	MCP25XXFD_CAN_SFR_BASE(0x1F4 + 8 * (x))
-#  define MCP25XXFD_CAN_FILMASK_MSID_BITS	11
-#  define MCP25XXFD_CAN_FILMASK_MSID_SHIFT	0
-#  define MCP25XXFD_CAN_FILMASK_MSID_MASK				\
-	GENMASK(MCP25XXFD_CAN_FILMASK_MSID_SHIFT +			\
-		MCP25XXFD_CAN_FILMASK_MSID_BITS - 1,			\
-		MCP25XXFD_CAN_FILMASK_MSID_SHIFT)
-#  define MCP25XXFD_CAN_FILMASK_MEID_BITS	18
-#  define MCP25XXFD_CAN_FILMASK_MEID_SHIFT	12
-#  define MCP25XXFD_CAN_FILMASK_MEID_MASK				\
-	GENMASK(MCP25XXFD_CAN_FILMASK_MEID_SHIFT +			\
-		MCP25XXFD_CAN_FILMASK_MEID_BITS - 1,			\
-		MCP25XXFD_CAN_FILMASK_MEID_SHIFT)
-#  define MCP25XXFD_CAN_FILMASK_MSID11		BIT(29)
-#  define MCP25XXFD_CAN_FILMASK_MIDE		BIT(30)
+#  define MCP25XXFD_CAN_MASK_MSID_BITS	11
+#  define MCP25XXFD_CAN_MASK_MSID_SHIFT	0
+#  define MCP25XXFD_CAN_MASK_MSID_MASK				\
+	GENMASK(MCP25XXFD_CAN_MASK_MSID_SHIFT +			\
+		MCP25XXFD_CAN_MASK_MSID_BITS - 1,			\
+		MCP25XXFD_CAN_MASK_MSID_SHIFT)
+#  define MCP25XXFD_CAN_MASK_MEID_BITS	18
+#  define MCP25XXFD_CAN_MASK_MEID_SHIFT	11
+#  define MCP25XXFD_CAN_MASK_MEID_MASK				\
+	GENMASK(MCP25XXFD_CAN_MASK_MEID_SHIFT +			\
+		MCP25XXFD_CAN_MASK_MEID_BITS - 1,			\
+		MCP25XXFD_CAN_MASK_MEID_SHIFT)
+#  define MCP25XXFD_CAN_MASK_MSID11		BIT(29)
+#  define MCP25XXFD_CAN_MASK_MIDE		BIT(30)
 
 /* the FIFO Objects in SRAM */
 #define MCP25XXFD_SRAM_SIZE 2048
@@ -666,8 +666,8 @@ struct mcp25xxfd_can_obj_tef {
 	GENMASK(MCP25XXFD_CAN_OBJ_FLAGS_SEQ_SHIFT +			\
 		MCP25XXFD_CAN_OBJ_FLAGS_SEQX_BITS - 1,			\
 		MCP25XXFD_CAN_OBJ_FLAGS_SEQ_SHIFT)
-#define MCP25XXFD_CAN_OBJ_FLAGS_FILHIT_BITS	11
-#define MCP25XXFD_CAN_OBJ_FLAGS_FILHIT_SHIFT	5
+#define MCP25XXFD_CAN_OBJ_FLAGS_FILHIT_BITS	5
+#define MCP25XXFD_CAN_OBJ_FLAGS_FILHIT_SHIFT	11
 #define MCP25XXFD_CAN_OBJ_FLAGS_FILHIT_MASK				\
 	GENMASK(MCP25XXFD_CAN_FLAGS_FILHIT_SHIFT +			\
 		MCP25XXFD_CAN_FLAGS_FILHIT_BITS - 1,			\
-- 
2.17.1

