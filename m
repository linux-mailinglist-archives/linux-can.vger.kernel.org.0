Return-Path: <linux-can+bounces-6275-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDSHL6lLc2liugAAu9opvQ
	(envelope-from <linux-can+bounces-6275-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 11:21:29 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B817774415
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 11:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD47D302B9E7
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01030CDB1;
	Fri, 23 Jan 2026 10:16:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E92C11FE
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163405; cv=none; b=MkeeMXlgmcDnVWOoRUPlRbhAsdFEjSXPbvfMr3jHvxdot9iRDXJ27HxHzZlcaksxUYwFpPQOGNCC5j9A1Z+ObxfLqZ831v5YmdQBQs2sdy+2K1Q/epEtIPxgymIHN2T1xkv89S88/lJuFXZOYzhs9DFOJoENZxm0G7drdT/3VCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163405; c=relaxed/simple;
	bh=4z9Kc93tDy77NwvWNfEjS87hBCmsuyT2VGrNeKsdaX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzjTKqo2ZS/sKiCG6jGqOjTSZWSsTDXU81xgysUtVkjoekL6ltsibCQQ23oCirhSih+i2/5Vf5K28h2a2ElXao+gq/or5eHUXU7kRyeCTIj9taWGueCGHdHFr7Tvjwqob/2oUKUBTbIhchzcKSQJSttxWf0nNiVx3t0lvhWJtWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjEDX-0006FY-4L; Fri, 23 Jan 2026 11:16:39 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjEDX-0024im-1Z;
	Fri, 23 Jan 2026 11:16:38 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8BD234D6BCA;
	Fri, 23 Jan 2026 10:16:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 23 Jan 2026 11:16:27 +0100
Subject: [PATCH can-next v2 2/2] can: sja1000: sja1000_err(): use error
 counter for error state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-sja1000-state-handling-v2-2-687498087dad@pengutronix.de>
References: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
In-Reply-To: <20260123-sja1000-state-handling-v2-0-687498087dad@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Michael Tretter <m.tretter@pengutronix.de>
Cc: Achim Baumgartner <abaumgartner@topcon.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3135; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ImZFcNkcBPF5WEhj9ZujZuMZIsIki8wX0jgf5Z+4H6A=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpc0qCXcYCmDtunKgyl81v9UjLjxQ020jMfzofZ
 BBa8OSAeimJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXNKggAKCRAMdGXf+ZCR
 nHywB/4uywdtpquiA06CIYvCkjnZQmMtG3aGrEF7juQGSh0RmdiXdkGVitHMu9etJNp3LUIKRdp
 DyK7peFjwQyw1llSO2jDYly4iSsiWPZyqOM91Iag5WafhlPHEGfRbMIxT9ZillIo+ads/SarzSc
 or/n60xdAhw1q/zKTaSXCk+PVQ2Q2/TDB6Mwv1knszaxpACnYA0kfB62h7HJ2+JNedcoevh2t1c
 kefAdHNIm+s3YgNKu/fMrWaO+PUKupLtodzk2/uTiUXRoOg7RfFam6JI79rbs0KixQ548ZXwrh5
 UDQD0zdkQqImaZuj3Z3JDGDOeeDmvQINfJJ5P34kriANB+Zz
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-6275-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B817774415
X-Rspamd-Action: no action

From: Michael Tretter <m.tretter@pengutronix.de>

The CAN controller sends the EPI interrupt whenever it reaches the error
passive status or enters the error active status from the error passive
status.

Instead of keeping track of the controller status in the driver, read the
txerr and rxerr counters and use can_state_get_by_berr_counter() to
determine the state of the CAN controller.

Suggested-by: Achim Baumgartner <abaumgartner@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ae3244b63b65..67fccc15ed20 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -407,10 +407,9 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 {
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
+	enum can_state state, rx_state, tx_state;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	enum can_state state = priv->can.state;
-	enum can_state rx_state, tx_state;
 	struct can_berr_counter bec;
 	uint8_t ecc, alc;
 	int ret = 0;
@@ -418,6 +417,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	skb = alloc_can_err_skb(dev, &cf);
 
 	sja1000_get_berr_counter(dev, &bec);
+	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
+
+	if (status & SR_BS)
+		rx_state = CAN_STATE_BUS_OFF;
+
+	state = max(tx_state, rx_state);
 
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
@@ -440,18 +445,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		if (priv->flags & SJA1000_QUIRK_RESET_ON_OVERRUN)
 			ret = IRQ_WAKE_THREAD;
 	}
-
-	if (isrc & IRQ_EI) {
-		/* error warning interrupt */
-		netdev_dbg(dev, "error warning interrupt\n");
-
-		if (status & SR_BS)
-			state = CAN_STATE_BUS_OFF;
-		else if (status & SR_ES)
-			state = CAN_STATE_ERROR_WARNING;
-		else
-			state = CAN_STATE_ERROR_ACTIVE;
-	}
 	if (state != CAN_STATE_BUS_OFF && skb) {
 		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
@@ -493,15 +486,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			stats->rx_errors++;
 		}
 	}
-	if (isrc & IRQ_EPI) {
-		/* error passive interrupt */
-		netdev_dbg(dev, "error passive interrupt\n");
-
-		if (state == CAN_STATE_ERROR_PASSIVE)
-			state = CAN_STATE_ERROR_WARNING;
-		else
-			state = CAN_STATE_ERROR_PASSIVE;
-	}
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */
 		netdev_dbg(dev, "arbitration lost interrupt\n");
@@ -514,9 +498,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	}
 
 	if (state != priv->can.state) {
-		tx_state = bec.txerr >= bec.rxerr ? state : 0;
-		rx_state = bec.txerr <= bec.rxerr ? state : 0;
-
 		can_change_state(dev, cf, tx_state, rx_state);
 
 		if(state == CAN_STATE_BUS_OFF)

-- 
2.51.0


