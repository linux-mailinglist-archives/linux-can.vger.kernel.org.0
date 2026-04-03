Return-Path: <linux-can+bounces-7329-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMmzDMEZz2nDswYAu9opvQ
	(envelope-from <linux-can+bounces-7329-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 03:37:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F853390161
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 03:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96EFB3013C97
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2026 01:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD530DEAC;
	Fri,  3 Apr 2026 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="dobM6AA/"
X-Original-To: linux-can@vger.kernel.org
Received: from out30-82.freemail.mail.aliyun.com (out30-82.freemail.mail.aliyun.com [115.124.30.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FCE2BEC2E;
	Fri,  3 Apr 2026 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180216; cv=none; b=NT2kItesugqXS2e2n+0xx9x3aS5mq4kVWzrC0fhxNOgfVI5es6wwT+y1IkXkK/jDCc9YzsDEnu4H8e+Le1VhcwhJZBbzNnzM4uoWa5zUGmXxV1R1sedrTLCQrOcjVie4rauCXwK7YUyffjVkL8dvzHh5F+v79GuCpGQikMD0ff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180216; c=relaxed/simple;
	bh=WRYmLPOoAE9xPwe/Rl8QWVAgg5QH1TQpsaGYdX9jqBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO1fscCt3yZC2Cfm24TzHl6wqPziU0TKCEsyMNa2yv3PvXeoijLaHkxFZAoSJAP21UcTPAjrCD1kPtPyfxbIVoa8siKsTVOFB3CI4trcXqLfTFy8YyV0DaBxh6WAaWGDU7EPzvV8mQgxXljD08QF2XCVgCX/e8bQXwR59f3lOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=dobM6AA/; arc=none smtp.client-ip=115.124.30.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1775180212; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5pB87nAvw2pdzQXPStrboIZ3LsSsSAIrhWXQMR3QgIc=;
	b=dobM6AA/XbH98AzUEBedDfuVtC4Nqf6g5m784OxtvTCicTMga4RP8cXgt5E8Jv5Ub0Buj+cD1iCHKqbgQDGxP8nD+PgHKSTnAQRuO2bCbO7CwqooaklJ/TtVtt6H+hMIfRzDrXn8SeIoLm7HZFdKwh228cEJLq4UQWNRmSNTaFw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07459792|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0605914-0.00113639-0.938272;FP=9894541091572370344|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---0X0IU03m_1775180209;
Received: from Ubuntu24(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X0IU03m_1775180209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Apr 2026 09:36:51 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: mkl@pengutronix.de,
	linux-can@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.15.y v2 2/3] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
Date: Fri,  3 Apr 2026 09:36:14 +0800
Message-ID: <20260403013615.4641-3-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403013615.4641-1-ruohanlan@aliyun.com>
References: <20260403013615.4641-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[aliyun.com];
	TAGGED_FROM(0.00)[bounces-7329-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[aliyun.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,kernel.org,aliyun.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6F853390161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 79a6d1bfe1148bc921b8d7f3371a7fbce44e30f7 ]

In commit 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix
URB memory leak"), the URB was re-anchored before usb_submit_urb() in
gs_usb_receive_bulk_callback() to prevent a leak of this URB during
cleanup.

However, this patch did not take into account that usb_submit_urb() could
fail. The URB remains anchored and
usb_kill_anchored_urbs(&parent->rx_submitted) in gs_can_close() loops
infinitely since the anchor list never becomes empty.

To fix the bug, unanchor the URB when an usb_submit_urb() error occurs,
also print an info message.

Fixes: 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
Link: https://patch.msgid.link/20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 drivers/net/can/usb/gs_usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index acffe11a0ae1..134f830508d9 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -405,6 +405,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	usb_anchor_urb(urb, &usbcan->rx_submitted);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!rc)
+		return;
+
+	usb_unanchor_urb(urb);
 
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
@@ -413,6 +417,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			if (usbcan->canch[rc])
 				netif_device_detach(usbcan->canch[rc]->netdev);
 		}
+	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
+		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
+			    ERR_PTR(urb->status));
 	}
 }
 
-- 
2.43.0


