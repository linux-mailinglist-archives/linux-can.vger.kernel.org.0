Return-Path: <linux-can+bounces-1132-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3D948A6B
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1CF2862E8
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462BF1BD009;
	Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8816EB40
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930466; cv=none; b=CHybIEU3+LVm7wORhzE0umS7oti01zxYL+tkDx/b9kXzIlJEzUBUPD4/23BZoWufAAUhTJMXoCDg++mhLH32JOiynXDbIeKunUf0ucs8+RKJ9l2lb6petrKECEBCTEwO8X9mGB7CUWkrnQEglkzofpKXdMnzSfUZw1HBIDfyBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930466; c=relaxed/simple;
	bh=2C1dj9KyBIYo/O70CICUWOGNR4pLOmkXUlECGJpmyrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYcrLaZ3QhB9TDBoMVkg/HjE8oMhXqGM+ZOKL/XakcUu8ZmJ5fkm+ah4zX4ICUoBe3VR6nYRJNWLrm/cFwQGVHQxNmPxRAEjVqrqa/L074ZP59EJ0EnmRYLTZDQkEPpBr1XeVUyGx3maiM8gqYfO8QfuK0y8grzoPfo7Utlttjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuu-00042l-JM
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:36 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEut-004tpP-HV
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 371D131799C
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C3CCC317970;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ccda782;
	Tue, 6 Aug 2024 07:47:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/20] can: esd_402_pci: Rename esdACC CTRL register macros
Date: Tue,  6 Aug 2024 09:41:55 +0200
Message-ID: <20240806074731.1905378-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

Rename macros to use for esdACC CTRL register access to match the
internal documentation and to make the macro prefix consistent.

- ACC_CORE_OF_CTRL_MODE -> ACC_CORE_OF_CTRL
  Makes the name match the documentation.
- ACC_REG_CONTROL_MASK_MODE_ -> ACC_REG_CTRL_MASK_
  ACC_REG_CONTROL_MASK_ -> ACC_REG_CTRL_MASK_
  Makes the prefix consistent for macros describing masks in the same
  register (CTRL).

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://lore.kernel.org/all/20240717214409.3934333-2-stefan.maetje@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/esd/esdacc.c | 46 ++++++++++++++++++------------------
 drivers/net/can/esd/esdacc.h | 35 ++++++++++++++-------------
 2 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index 121cbbf81458..ef33d2ccd220 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -43,8 +43,8 @@
 
 static void acc_resetmode_enter(struct acc_core *core)
 {
-	acc_set_bits(core, ACC_CORE_OF_CTRL_MODE,
-		     ACC_REG_CONTROL_MASK_MODE_RESETMODE);
+	acc_set_bits(core, ACC_CORE_OF_CTRL,
+		     ACC_REG_CTRL_MASK_RESETMODE);
 
 	/* Read back reset mode bit to flush PCI write posting */
 	acc_resetmode_entered(core);
@@ -52,8 +52,8 @@ static void acc_resetmode_enter(struct acc_core *core)
 
 static void acc_resetmode_leave(struct acc_core *core)
 {
-	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
-		       ACC_REG_CONTROL_MASK_MODE_RESETMODE);
+	acc_clear_bits(core, ACC_CORE_OF_CTRL,
+		       ACC_REG_CTRL_MASK_RESETMODE);
 
 	/* Read back reset mode bit to flush PCI write posting */
 	acc_resetmode_entered(core);
@@ -172,7 +172,7 @@ int acc_open(struct net_device *netdev)
 	struct acc_net_priv *priv = netdev_priv(netdev);
 	struct acc_core *core = priv->core;
 	u32 tx_fifo_status;
-	u32 ctrl_mode;
+	u32 ctrl;
 	int err;
 
 	/* Retry to enter RESET mode if out of sync. */
@@ -187,19 +187,19 @@ int acc_open(struct net_device *netdev)
 	if (err)
 		return err;
 
-	ctrl_mode = ACC_REG_CONTROL_MASK_IE_RXTX |
-			ACC_REG_CONTROL_MASK_IE_TXERROR |
-			ACC_REG_CONTROL_MASK_IE_ERRWARN |
-			ACC_REG_CONTROL_MASK_IE_OVERRUN |
-			ACC_REG_CONTROL_MASK_IE_ERRPASS;
+	ctrl = ACC_REG_CTRL_MASK_IE_RXTX |
+		ACC_REG_CTRL_MASK_IE_TXERROR |
+		ACC_REG_CTRL_MASK_IE_ERRWARN |
+		ACC_REG_CTRL_MASK_IE_OVERRUN |
+		ACC_REG_CTRL_MASK_IE_ERRPASS;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		ctrl_mode |= ACC_REG_CONTROL_MASK_IE_BUSERR;
+		ctrl |= ACC_REG_CTRL_MASK_IE_BUSERR;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		ctrl_mode |= ACC_REG_CONTROL_MASK_MODE_LOM;
+		ctrl |= ACC_REG_CTRL_MASK_LOM;
 
-	acc_set_bits(core, ACC_CORE_OF_CTRL_MODE, ctrl_mode);
+	acc_set_bits(core, ACC_CORE_OF_CTRL, ctrl);
 
 	acc_resetmode_leave(core);
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -218,13 +218,13 @@ int acc_close(struct net_device *netdev)
 	struct acc_net_priv *priv = netdev_priv(netdev);
 	struct acc_core *core = priv->core;
 
-	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
-		       ACC_REG_CONTROL_MASK_IE_RXTX |
-		       ACC_REG_CONTROL_MASK_IE_TXERROR |
-		       ACC_REG_CONTROL_MASK_IE_ERRWARN |
-		       ACC_REG_CONTROL_MASK_IE_OVERRUN |
-		       ACC_REG_CONTROL_MASK_IE_ERRPASS |
-		       ACC_REG_CONTROL_MASK_IE_BUSERR);
+	acc_clear_bits(core, ACC_CORE_OF_CTRL,
+		       ACC_REG_CTRL_MASK_IE_RXTX |
+		       ACC_REG_CTRL_MASK_IE_TXERROR |
+		       ACC_REG_CTRL_MASK_IE_ERRWARN |
+		       ACC_REG_CTRL_MASK_IE_OVERRUN |
+		       ACC_REG_CTRL_MASK_IE_ERRPASS |
+		       ACC_REG_CTRL_MASK_IE_BUSERR);
 
 	netif_stop_queue(netdev);
 	acc_resetmode_enter(core);
@@ -233,9 +233,9 @@ int acc_close(struct net_device *netdev)
 	/* Mark pending TX requests to be aborted after controller restart. */
 	acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
 
-	/* ACC_REG_CONTROL_MASK_MODE_LOM is only accessible in RESET mode */
-	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
-		       ACC_REG_CONTROL_MASK_MODE_LOM);
+	/* ACC_REG_CTRL_MASK_LOM is only accessible in RESET mode */
+	acc_clear_bits(core, ACC_CORE_OF_CTRL,
+		       ACC_REG_CTRL_MASK_LOM);
 
 	close_candev(netdev);
 	return 0;
diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.h
index a70488b25d39..d13dfa60703a 100644
--- a/drivers/net/can/esd/esdacc.h
+++ b/drivers/net/can/esd/esdacc.h
@@ -50,7 +50,7 @@
 #define ACC_OV_REG_MODE_MASK_FPGA_RESET BIT(31)
 
 /* esdACC CAN Core Module */
-#define ACC_CORE_OF_CTRL_MODE 0x0000
+#define ACC_CORE_OF_CTRL 0x0000
 #define ACC_CORE_OF_STATUS_IRQ 0x0008
 #define ACC_CORE_OF_BRP	0x000c
 #define ACC_CORE_OF_BTR	0x0010
@@ -66,21 +66,22 @@
 #define ACC_CORE_OF_TXFIFO_DATA_0 0x00c8
 #define ACC_CORE_OF_TXFIFO_DATA_1 0x00cc
 
-#define ACC_REG_CONTROL_MASK_MODE_RESETMODE BIT(0)
-#define ACC_REG_CONTROL_MASK_MODE_LOM BIT(1)
-#define ACC_REG_CONTROL_MASK_MODE_STM BIT(2)
-#define ACC_REG_CONTROL_MASK_MODE_TRANSEN BIT(5)
-#define ACC_REG_CONTROL_MASK_MODE_TS BIT(6)
-#define ACC_REG_CONTROL_MASK_MODE_SCHEDULE BIT(7)
+/* CTRL register layout */
+#define ACC_REG_CTRL_MASK_RESETMODE BIT(0)
+#define ACC_REG_CTRL_MASK_LOM BIT(1)
+#define ACC_REG_CTRL_MASK_STM BIT(2)
+#define ACC_REG_CTRL_MASK_TRANSEN BIT(5)
+#define ACC_REG_CTRL_MASK_TS BIT(6)
+#define ACC_REG_CTRL_MASK_SCHEDULE BIT(7)
 
-#define ACC_REG_CONTROL_MASK_IE_RXTX BIT(8)
-#define ACC_REG_CONTROL_MASK_IE_TXERROR BIT(9)
-#define ACC_REG_CONTROL_MASK_IE_ERRWARN BIT(10)
-#define ACC_REG_CONTROL_MASK_IE_OVERRUN BIT(11)
-#define ACC_REG_CONTROL_MASK_IE_TSI BIT(12)
-#define ACC_REG_CONTROL_MASK_IE_ERRPASS BIT(13)
-#define ACC_REG_CONTROL_MASK_IE_ALI BIT(14)
-#define ACC_REG_CONTROL_MASK_IE_BUSERR BIT(15)
+#define ACC_REG_CTRL_MASK_IE_RXTX BIT(8)
+#define ACC_REG_CTRL_MASK_IE_TXERROR BIT(9)
+#define ACC_REG_CTRL_MASK_IE_ERRWARN BIT(10)
+#define ACC_REG_CTRL_MASK_IE_OVERRUN BIT(11)
+#define ACC_REG_CTRL_MASK_IE_TSI BIT(12)
+#define ACC_REG_CTRL_MASK_IE_ERRPASS BIT(13)
+#define ACC_REG_CTRL_MASK_IE_ALI BIT(14)
+#define ACC_REG_CTRL_MASK_IE_BUSERR BIT(15)
 
 /* BRP and BTR register layout for CAN-Classic version */
 #define ACC_REG_BRP_CL_MASK_BRP GENMASK(8, 0)
@@ -300,9 +301,9 @@ static inline void acc_clear_bits(struct acc_core *core,
 
 static inline int acc_resetmode_entered(struct acc_core *core)
 {
-	u32 ctrl = acc_read32(core, ACC_CORE_OF_CTRL_MODE);
+	u32 ctrl = acc_read32(core, ACC_CORE_OF_CTRL);
 
-	return (ctrl & ACC_REG_CONTROL_MASK_MODE_RESETMODE) != 0;
+	return (ctrl & ACC_REG_CTRL_MASK_RESETMODE) != 0;
 }
 
 static inline u32 acc_ov_read32(struct acc_ov *ov, unsigned short offs)
-- 
2.43.0



