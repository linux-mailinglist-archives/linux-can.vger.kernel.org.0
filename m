Return-Path: <linux-can+bounces-6272-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPiQNHc9c2kztgAAu9opvQ
	(envelope-from <linux-can+bounces-6272-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 10:20:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F47328F
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91DAE3046501
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 09:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4F2F0C68;
	Fri, 23 Jan 2026 09:18:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1D2F3C3F
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159931; cv=none; b=d5GW6K7Hzm/poCHpH1LCJkQSczbGTpBu284FslJSeLfqX1DcSIoI8iXjWNA7S79/xTN34f8p95H5xzbESv8gRDzS1yNKn20uL1WBe19JzeZu2dXud2VQib67MXsib7F08tD/eRd4lTp7XRyGaq50Jw/ifl1UgI3jU4nKItp3fPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159931; c=relaxed/simple;
	bh=dZxgDdx4r6LdOyT8apcajYeydy0ejrxEQVVRT8cRqgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LhZWFgSln/Og11IZyRrtyz1C+ULRbqMdT+ZPVa0ED3CTLIdyaVkC4PKX0z5zIGoTNMdvAgwoQQjqynjbJutOg70eV2fKz7F16I7luX8seTsdxE3Nj0fsEzeiafLWDG/YwihauQKnZVYvxX2r84U0btLba5e0nJluXWCy1KfxUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjDJW-0003nf-G1; Fri, 23 Jan 2026 10:18:46 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Fri, 23 Jan 2026 10:18:33 +0100
Subject: [PATCH] can: sja1000: use error counter for error state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-can-sja1000-error-passive-v1-1-01e5d454ab5f@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAOg8c2kC/x3MMQrDMAxA0asEzRXILjW0VwkZhCM3ymAHCUIh+
 O4xHd/w/wUupuLwmS4wOdW11YHwmCBvXL+Cug5DpJgoxCdmrug7ByJCMWuGB7vrKRgp5fIusvK
 rwOgPk6K//3teer8Bnj3qPGsAAAA=
X-Change-ID: 20260123-can-sja1000-error-passive-206cf9feda5f
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Achim Baumgartner <abaumgartner@topcon.com>, 
 Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[topcon.com:email,pengutronix.de:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.tretter@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6272-lists,linux-can=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 299F47328F
X-Rspamd-Action: no action

The CAN controller sends the EPI interrupt whenever it reaches the error
passive status or enters the error active status from the error passive
status.

Instead of keeping track of the controller status in the driver, read
the txerr and rxerr counters to determine the error status of the CAN
controller.

Suggested-by: Achim Baumgartner <abaumgartner@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index a8fa0d6516b9..4bd310b0f82a 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -498,10 +498,14 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		/* error passive interrupt */
 		netdev_dbg(dev, "error passive interrupt\n");
 
-		if (state == CAN_STATE_ERROR_PASSIVE)
-			state = CAN_STATE_ERROR_WARNING;
-		else
-			state = CAN_STATE_ERROR_PASSIVE;
+		if (state != CAN_STATE_BUS_OFF) {
+			if (txerr < 96 && rxerr < 96)
+				state = CAN_STATE_ERROR_ACTIVE;
+			else if (txerr < 128 && rxerr < 128)
+				state = CAN_STATE_ERROR_WARNING;
+			else
+				state = CAN_STATE_ERROR_PASSIVE;
+		}
 	}
 	if (isrc & IRQ_ALI) {
 		/* arbitration lost interrupt */

---
base-commit: c072629f05d7bca1148ab17690d7922a31423984
change-id: 20260123-can-sja1000-error-passive-206cf9feda5f

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>


