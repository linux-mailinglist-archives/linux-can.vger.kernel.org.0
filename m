Return-Path: <linux-can+bounces-3609-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BF8ABEDC7
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8091BA7679
	for <lists+linux-can@lfdr.de>; Wed, 21 May 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E498238143;
	Wed, 21 May 2025 08:23:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C82367D7
	for <linux-can@vger.kernel.org>; Wed, 21 May 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815787; cv=none; b=ZkWU5gDKK76Zz6CDRTz9xbJJ74U2do2BK+6r9C3A44mPo7xZEEh87et0ynaUyQmFbmj0KpO8hk1Pyqywm75oQB7w0dp10gfmio2R1B/6p3p4Rjwd+bLyo/WwwHwubpmwdjm1uTUvnQaMtdITkOteDN3ociK6Ke45dR6+qfnYuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815787; c=relaxed/simple;
	bh=8xOr9S6yQTV1LJ7OlLB1jbsHxVL2XCYQMFKqucXQMnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S819xP6KYkuFMFP6mRAcCTbxlhXON0a17b1iWFlTELc0h84CRVgxUeOq9jrhD7UgfUkA0NPu8KYH/T0VpJOC+lycM2KYR2tFhEjy2Dokzd+pnsKgkCGkBlRQ5NJsjgaM4k10NI1k3NAbET3hPxhXUXUy8gCPPQkiGVcz6JHiIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHej3-0003IZ-O6
	for linux-can@vger.kernel.org; Wed, 21 May 2025 10:22:57 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHej3-000Xf3-13
	for linux-can@vger.kernel.org;
	Wed, 21 May 2025 10:22:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 02A9C4166A2
	for <linux-can@vger.kernel.org>; Wed, 21 May 2025 08:22:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1D14541668A;
	Wed, 21 May 2025 08:22:55 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1cef31f0;
	Wed, 21 May 2025 08:22:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Carlos Sanchez <carlossanchez@geotab.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/4] can: slcan: allow reception of short error messages
Date: Wed, 21 May 2025 10:14:28 +0200
Message-ID: <20250521082239.341080-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521082239.341080-2-mkl@pengutronix.de>
References: <20250521082239.341080-2-mkl@pengutronix.de>
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

From: Carlos Sanchez <carlossanchez@geotab.com>

Allows slcan to receive short messages (typically errors) from the serial
interface.

When error support was added to slcan protocol in
b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protocol
with error info") the minimum valid message size changed from 5 (minimum
standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
one of the examples given in the comments for slcan_bump_err() ), but the
check for minimum message length prodicating all decoding was not adjusted.
This makes short error messages discarded and error frames not being
generated.

This patch changes the minimum length to the new minimum (3 characters,
excluding terminator, is now a valid message).

Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>
Fixes: b32ff4668544 ("can: slcan: extend the protocol with error info")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250520102305.1097494-1-carlossanchez@geotab.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/slcan/slcan-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 24c6622d36bd..58ff2ec1d975 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -71,12 +71,21 @@ MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 #define SLCAN_CMD_LEN 1
 #define SLCAN_SFF_ID_LEN 3
 #define SLCAN_EFF_ID_LEN 8
+#define SLCAN_DATA_LENGTH_LEN 1
+#define SLCAN_ERROR_LEN 1
 #define SLCAN_STATE_LEN 1
 #define SLCAN_STATE_BE_RXCNT_LEN 3
 #define SLCAN_STATE_BE_TXCNT_LEN 3
-#define SLCAN_STATE_FRAME_LEN       (1 + SLCAN_CMD_LEN + \
-				     SLCAN_STATE_BE_RXCNT_LEN + \
-				     SLCAN_STATE_BE_TXCNT_LEN)
+#define SLCAN_STATE_MSG_LEN     (SLCAN_CMD_LEN +		\
+                                 SLCAN_STATE_LEN +		\
+                                 SLCAN_STATE_BE_RXCNT_LEN +	\
+                                 SLCAN_STATE_BE_TXCNT_LEN)
+#define SLCAN_ERROR_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_ERROR_LEN +	\
+                                 SLCAN_DATA_LENGTH_LEN)
+#define SLCAN_FRAME_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_SFF_ID_LEN +	\
+                                 SLCAN_DATA_LENGTH_LEN)
 struct slcan {
 	struct can_priv         can;
 
@@ -176,6 +185,9 @@ static void slcan_bump_frame(struct slcan *sl)
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
+	if (sl->rcount < SLCAN_FRAME_MSG_LEN_MIN)
+		return;
+
 	skb = alloc_can_skb(sl->dev, &cf);
 	if (unlikely(!skb)) {
 		sl->dev->stats.rx_dropped++;
@@ -281,7 +293,7 @@ static void slcan_bump_state(struct slcan *sl)
 		return;
 	}
 
-	if (state == sl->can.state || sl->rcount < SLCAN_STATE_FRAME_LEN)
+	if (state == sl->can.state || sl->rcount != SLCAN_STATE_MSG_LEN)
 		return;
 
 	cmd += SLCAN_STATE_BE_RXCNT_LEN + SLCAN_CMD_LEN + 1;
@@ -328,6 +340,9 @@ static void slcan_bump_err(struct slcan *sl)
 	bool rx_errors = false, tx_errors = false, rx_over_errors = false;
 	int i, len;
 
+	if (sl->rcount < SLCAN_ERROR_MSG_LEN_MIN)
+		return;
+
 	/* get len from sanitized ASCII value */
 	len = cmd[1];
 	if (len >= '0' && len < '9')
@@ -456,8 +471,7 @@ static void slcan_bump(struct slcan *sl)
 static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
-		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    sl->rcount > 4)
+		if (!test_and_clear_bit(SLF_ERROR, &sl->flags))
 			slcan_bump(sl);
 
 		sl->rcount = 0;
-- 
2.47.2



