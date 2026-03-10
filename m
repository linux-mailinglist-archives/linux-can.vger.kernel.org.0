Return-Path: <linux-can+bounces-7069-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFw7CEUlsGnYgQIAu9opvQ
	(envelope-from <linux-can+bounces-7069-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 15:05:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488C25152E
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84E0346791A
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75CE3EC2C5;
	Tue, 10 Mar 2026 12:48:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C763EAC8F
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146906; cv=none; b=ZETnf2wIXjbezWMO8DTIKkdK4F2MlUgPHcpFU8SowLYSvbLIcD+m5SKfztryjcMuYv+IWlX4s/EMl++ln7HthoVqM1iTzkR/V7gt16/e3K8f4R4/+6Nat/m9oJRrVUpWydMYj30OW2RBOOcitt3ggWqyEGFfmVtNi0huOfBCkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146906; c=relaxed/simple;
	bh=hLaviU5buci/iG+3IFZ8KM5SjFs5/S+pJjyjwtRoJxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JhI5D2m3OJyFKaedj3ce4LLIE3PCmnaopvXm6iz+yuLgI/G4/rRZN43+HPoCDoVS757NwbRsSdiJOxZ32nQnZovjIvR+j1wek7YE9XgaeOlHw8V9V273AROxo8bFzB6StD0Fn+yOlWZcjNazUtO9tmJCOh9aZMl1xopucVdCF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzwVa-0007Ht-AG; Tue, 10 Mar 2026 13:48:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzwVY-004hN1-2E;
	Tue, 10 Mar 2026 13:48:22 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C25C54FD59F;
	Tue, 10 Mar 2026 12:48:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 10 Mar 2026 13:48:03 +0100
Subject: [PATCH can] can: netlink: can_changelink(): add missing error
 handling to call can_ctrlmode_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-can_ctrlmode_changelink-add-error-handling-v1-1-0daf63d85922@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAITsGkC/yWN0QrCMAxFf2Xk2UDb6QR/RWTUJs7obCWdIoz9u
 9E93sPlnBkqq3CFQzOD8luqlGzDbxpI15gHRiHbEFzoXOsdppj7NOn4KMT9ehkl3zESIasWRWN
 kaEC/83tyXRu2nMCET+WLfP6xI5gHTiusr/ON0/TLwLJ8AZgrizyTAAAA
X-Change-ID: 20260310-can_ctrlmode_changelink-add-error-handling-1517d06324ec
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-b6adf
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=hLaviU5buci/iG+3IFZ8KM5SjFs5/S+pJjyjwtRoJxo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcIMyhm/nX4xrHtHP5U7ee2PjmrMu3aT5/7Ffrxm9Wn
 +N/MG19WkcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmksDJ8E+17KP0vC+LFopU
 FQtNnPn41iNfa5NTthtdmt+E975JdLrFyLBIy3t66eSuD8f9o/NuvHgVfywtMKxc7/+KmUpRm88
 6yHEBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 7488C25152E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7069-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.511];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In commit e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()") the
CAN Control Mode (IFLA_CAN_CTRLMODE) handling was factored out into the
can_ctrlmode_changelink() function. But the call to
can_ctrlmode_changelink() is missing the error handling.

Add the missing error handling and propagation to the call
can_ctrlmode_changelink().

Cc: stable@vger.kernel.org
Fixes: e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 0498198a4696..766d455950f5 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -601,7 +601,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	can_ctrlmode_changelink(dev, data, extack);
+	err = can_ctrlmode_changelink(dev, data, extack);
+	if (err)
+		return err;
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;

---
base-commit: e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69
change-id: 20260310-can_ctrlmode_changelink-add-error-handling-1517d06324ec

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


