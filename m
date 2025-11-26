Return-Path: <linux-can+bounces-5700-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6DDC89A31
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCC3A9BDF
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE6267AF6;
	Wed, 26 Nov 2025 12:01:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD4227B8E
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158485; cv=none; b=eWV9Omr6pu0BiXaWYfp4BwxXQkBqdI/fB3ed7NlItbF0A1AIXGMHLaw48t6W2xIRxqZcj1A1sQwbL06+VzeyDefTOZKdDBUibFSrro0+EE8EY7d6MCfmYlO2UTLjcpJ6LTFOJFG4RpcwEfilx1LzD6RSseb2OJ2H+5tzts0Ji3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158485; c=relaxed/simple;
	bh=E3D2TDv2bCzdN0F5NMcPT7rVLG9lrhp0P5VJOryu1sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW8R5RVKRXN+2AF8f3rpAvS61d60cq3vQM4Aw8aLXz7TypAq7gqq/jNjMs7JmlMQIa9TX2dq3XSTcFlIjPRYj8LYUunxobJLjrzypOEj4Pf6C9Syj+G3cDmZk8wm86BbSEcCY6pHoleR0zSpaDKW0ruKdbwL9IUro5nuj4oUwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-0004St-Mo; Wed, 26 Nov 2025 13:01:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECr-002bE8-1T;
	Wed, 26 Nov 2025 13:01:09 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0C2C44A8A8C;
	Wed, 26 Nov 2025 12:01:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Stephane Grosjean <stephane.grosjean@hms-networks.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/27] can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
Date: Wed, 26 Nov 2025 12:56:50 +0100
Message-ID: <20251126120106.154635-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126120106.154635-1-mkl@pengutronix.de>
References: <20251126120106.154635-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

Unify the ctrlmode related strings to the command line options of the
'ip' tool from the iproute2 package. The capitalized strings are also
shown when the detailed interface configuration is printed by 'ip'.

Suggested-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20251126-canxl-v8-1-e7e3eb74f889@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 80e1ab18de87..b392483e4499 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -92,29 +92,29 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
 {
 	switch (ctrlmode & ~(ctrlmode - 1)) {
 	case 0:
-		return "none";
+		return "(none)";
 	case CAN_CTRLMODE_LOOPBACK:
-		return "loopback";
+		return "LOOPBACK";
 	case CAN_CTRLMODE_LISTENONLY:
-		return "listen-only";
+		return "LISTEN-ONLY";
 	case CAN_CTRLMODE_3_SAMPLES:
-		return "triple-sampling";
+		return "TRIPLE-SAMPLING";
 	case CAN_CTRLMODE_ONE_SHOT:
-		return "one-shot";
+		return "ONE-SHOT";
 	case CAN_CTRLMODE_BERR_REPORTING:
-		return "berr-reporting";
+		return "BERR-REPORTING";
 	case CAN_CTRLMODE_FD:
-		return "fd";
+		return "FD";
 	case CAN_CTRLMODE_PRESUME_ACK:
-		return "presume-ack";
+		return "PRESUME-ACK";
 	case CAN_CTRLMODE_FD_NON_ISO:
-		return "fd-non-iso";
+		return "FD-NON-ISO";
 	case CAN_CTRLMODE_CC_LEN8_DLC:
-		return "cc-len8-dlc";
+		return "CC-LEN8-DLC";
 	case CAN_CTRLMODE_TDC_AUTO:
-		return "fd-tdc-auto";
+		return "TDC-AUTO";
 	case CAN_CTRLMODE_TDC_MANUAL:
-		return "fd-tdc-manual";
+		return "TDC-MANUAL";
 	default:
 		return "<unknown>";
 	}

base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
-- 
2.51.0


