Return-Path: <linux-can+bounces-6683-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM5QBsaupWmnEQAAu9opvQ
	(envelope-from <linux-can+bounces-6683-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:37:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03B1DBF8B
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78B0310B904
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3141B376;
	Mon,  2 Mar 2026 15:28:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321841163A
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465299; cv=none; b=AdZH2KiTRPwu/5N4oVFDndjzMKpdzBHIMJ0e733vCEG7I0jmoHBXZhHl5FLnluSac27PprJf+KWRmLsUHTrN8x60Qi7G9daqNg40AReoA6BwrW74V2DVpYyR9OP0KLpOvozwU9hxo42IFblT9XaTIT+tAVbPzxgVqH5HE4W/XH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465299; c=relaxed/simple;
	bh=OmuZ+VILbupgktkBc2ZqVrC1+1zuzqBKC4DDlxtGSLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+x8Lcq3PilATJ+ztqM/j2NCmO86Dw3k5iR/3YusjbrXvupgf8flJn3qHG4VZRqmH8Y+pTAQxsWVQQLCsjPOryrleMUGj5f2gwmDpKDo+kseJrHfyz8PS2cGXQ04Ms5Bzi3MsdAHU30Yymm8sachZORjyfsysK1j3Jot8v7mcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bf-0004kQ-Ms; Mon, 02 Mar 2026 16:27:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0u-2q;
	Mon, 02 Mar 2026 16:27:58 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E86A64F5472;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org
Subject: [PATCH net 09/12] can: usb: f81604: handle bulk write errors properly
Date: Mon,  2 Mar 2026 16:16:15 +0100
Message-ID: <20260302152755.1700177-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302152755.1700177-1-mkl@pengutronix.de>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: 4D03B1DBF8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6683-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If a write urb fails then more needs to be done other than just logging
the message, otherwise the transmission could be stalled.  Properly
increment the error counters and wake up the queues so that data will
continue to flow.

Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022334-slackness-dynamic-9195@gregkh
Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index c61bd30d1765..1cc927d79b6a 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -880,9 +880,27 @@ static void f81604_write_bulk_callback(struct urb *urb)
 	if (!netif_device_present(netdev))
 		return;
 
-	if (urb->status)
-		netdev_info(netdev, "%s: Tx URB error: %pe\n", __func__,
-			    ERR_PTR(urb->status));
+	if (!urb->status)
+		return;
+
+	switch (urb->status) {
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		return;
+	default:
+		break;
+	}
+
+	if (net_ratelimit())
+		netdev_err(netdev, "%s: Tx URB error: %pe\n", __func__,
+			   ERR_PTR(urb->status));
+
+	can_free_echo_skb(netdev, 0, NULL);
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	netif_wake_queue(netdev);
 }
 
 static void f81604_clear_reg_work(struct work_struct *work)
-- 
2.51.0


