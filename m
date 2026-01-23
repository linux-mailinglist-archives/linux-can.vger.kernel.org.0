Return-Path: <linux-can+bounces-6289-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n4oLO+Cwc2liyAAAu9opvQ
	(envelope-from <linux-can+bounces-6289-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:33:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EC790E6
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB469305261C
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F123EAA4;
	Fri, 23 Jan 2026 17:32:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653821CA02
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189573; cv=none; b=unIHeYRcszMSCjnjPLCSoj64I2o/FQ9R6T2mcFMPGLdZTb8Wxwjx+78ny1O/0q8Rhu11ilWQp6+pzCyrJkHdmcOjjoCzDJ6hIgVIilhQ1lrmnop8a3je9gN1uPtV5Di6NPxswdVtpsgjZ7Xe09BQfEqongd69Vj7czg0lEsHpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189573; c=relaxed/simple;
	bh=pAEs1bAluHYt2Vyy3fQQ1BiizNZgzUjmFkSHgLW+oog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwCvaMyPzaplB7jnICmWKoQrjrIjirFRvU8sXjZH87td48V+rvdE54x2T1ApxuAS3q2i8KNS016lfjdm0+DaP4YpNY/NeCG52u27BesNKB2rPafRVqOXEiMGxdL9CuXVJtEmSAEWsG4/iKURPDi29OLL968Z98vVvqb9Mka2hoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL1a-0008Rt-LW; Fri, 23 Jan 2026 18:32:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL1b-0028Am-0P;
	Fri, 23 Jan 2026 18:32:46 +0100
Received: from blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CF0704D713E;
	Fri, 23 Jan 2026 17:32:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/2] can: gs_usb: gs_usb_receive_bulk_callback(): fix error message
Date: Fri, 23 Jan 2026 18:30:07 +0100
Message-ID: <20260123173241.1026226-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123173241.1026226-1-mkl@pengutronix.de>
References: <20260123173241.1026226-1-mkl@pengutronix.de>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6289-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5C9EC790E6
X-Rspamd-Action: no action

Sinc commit 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback():
unanchor URL on usb_submit_urb() error") a failing resubmit URB will print
an info message.

In the case of a short read where netdev has not yet been assigned,
initialize as NULL to avoid dereferencing an undefined value. Also report
the error value of the failed resubmit.

Fixes: 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260119181904.1209979-1-kuba@kernel.org/
Link: https://patch.msgid.link/20260120-gs_usb-fix-error-message-v1-1-6be04de572bc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 192338b481f2..d8b2dd74b3a1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -610,7 +610,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
 	struct gs_can *dev;
-	struct net_device *netdev;
+	struct net_device *netdev = NULL;
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
@@ -768,7 +768,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		}
 	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
 		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
-			    ERR_PTR(urb->status));
+			    ERR_PTR(rc));
 	}
 }
 
-- 
2.51.0


