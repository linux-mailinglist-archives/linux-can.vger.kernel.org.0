Return-Path: <linux-can+bounces-5006-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5259B9F1DE
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB5954E34B7
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218FF2FC87B;
	Thu, 25 Sep 2025 12:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B82FE59C
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802444; cv=none; b=opkXv3xE42svSZqpGh/+pOn9qDSp4FqnCYEo1Kxupq6B6GN2w+CsahozJ2SHNFxwRax+jh9QB5jMOg4AK8/UiZyqjRKovF0cVDs2GdsMUx2etWcaHrjInbeIfuefh/b921JqC02o2zKbb5RluH+AyFJmaozmT/0Abio/T1Og4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802444; c=relaxed/simple;
	bh=mexw+6/QkPDCqTEUy0EXdc2mcDcdrWUzyQaUleqEZ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHRzUaMAzpARjyuLMd22cntXlWU0+n0ftp5DQr5m4RzJPlp1KOBQPJa2vugP1tQ0zXzBwC25N8Ud2pe8uf9Q3GwOl6oO9mO+GTH2p6CO6bdmz89IC5BByDWxkl1XTKCX7Poi4TlZqfdI9yrExwehUo8nvDQHiAiAnca3rtCM7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000YQ-Ku; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Pwm-0V;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E3A8947998B;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 31/48] can: netlink: document which symbols are FD specific
Date: Thu, 25 Sep 2025 14:08:08 +0200
Message-ID: <20250925121332.848157-32-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

The CAN XL netlink interface will also have data bitrate and TDC
parameters. The current FD parameters do not have a prefix in their
names to differentiate them.

Because the netlink interface is part of the UAPI, it is unfortunately
not feasible to rename the existing symbols to add an FD_ prefix. The
best alternative is to add a comment for each of the symbols to notify
the reader of which parts are CAN FD specific.

While at it, fix a typo: transiver -> transceiver.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-3-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can/netlink.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d69474..ef62f56eaaef 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -101,8 +101,8 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
-#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 
 /*
  * CAN device statistics
@@ -129,14 +129,14 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
-	IFLA_CAN_DATA_BITTIMING,
-	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_DATA_BITTIMING, /* FD */
+	IFLA_CAN_DATA_BITTIMING_CONST, /* FD */
 	IFLA_CAN_TERMINATION,
 	IFLA_CAN_TERMINATION_CONST,
 	IFLA_CAN_BITRATE_CONST,
-	IFLA_CAN_DATA_BITRATE_CONST,
+	IFLA_CAN_DATA_BITRATE_CONST, /* FD */
 	IFLA_CAN_BITRATE_MAX,
-	IFLA_CAN_TDC,
+	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
 
 	/* add new constants above here */
@@ -145,7 +145,7 @@ enum {
 };
 
 /*
- * CAN FD Transmitter Delay Compensation (TDC)
+ * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.
-- 
2.51.0


