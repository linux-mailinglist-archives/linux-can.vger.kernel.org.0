Return-Path: <linux-can+bounces-6608-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ0XIspDnGk7CgQAu9opvQ
	(envelope-from <linux-can+bounces-6608-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:10:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DAE175ECA
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FA8B301463E
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FD3363C6F;
	Mon, 23 Feb 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWoj9RER"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67535C1B4;
	Mon, 23 Feb 2026 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848648; cv=none; b=US5Gh8s4durnh73hAoPi+eIQK8+0aimhWU4WFRjVl7Cffw2wVJUw9RxhhgWfjFOxj3xFTmaHPK0KJ54H+7CG3Ks7pq5Dkz3Vfo09mpSSIa9h9lJpfLzIao2ozyPWSsk5GtVjSffCQ31RlhIlkThDKmkxuHxWD0O4X5mmbA9GAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848648; c=relaxed/simple;
	bh=q9FwzgD3ZyquyGEX8dnWP2IWWlN7Y0uatYbBRLdinPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s89sHo4By2g3eN+E/YhGNEv+ijW3LbuQ46lBvtRAptcMxcMcmTwk3fIkuHAiTsOWQHw47Pm5s2ohHRw8AJdP8BS4CgWO1/a659pJNJK1tePYaIeH+25nppj6scpjLMKwlYbGcoirkmvgehO2JU4Gz3eB958gXSQbH+qkc7PDEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWoj9RER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD42C116C6;
	Mon, 23 Feb 2026 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771848647;
	bh=q9FwzgD3ZyquyGEX8dnWP2IWWlN7Y0uatYbBRLdinPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vWoj9RERPRIVjvYwt/3qiW6Z+RT2xIbVS8ntTCANNg6oCgpfYx+6XxCDwUIS8aYZq
	 tAqxpfGaI5wDUMi+IZqjvTnN5fAwjduuI2EguhFEKq8dLMB45isszXxB62MdZrS23V
	 he4opqMyCYd/CiETgsA0nbkk1buZSpmKzvLmTea4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 2/3] can: usb: f81604: handle bulk write errors properly
Date: Mon, 23 Feb 2026 13:10:31 +0100
Message-ID: <2026022334-slackness-dynamic-9195@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026022331-opal-evaluator-a928@gregkh>
References: <2026022331-opal-evaluator-a928@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 51
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=q9FwzgD3ZyquyGEX8dnWP2IWWlN7Y0uatYbBRLdinPE=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlznHdV+2i1rL5xPvSk1hL/m09FFKUaLqiJZu34uFiQl aXmt0xCRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkOYNhwRSWF6Gq8d78cxxC puxO+HWHa91rfoYFzfx6PTpK7MEWckyJX9u1U6ot2w0B
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6608-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email,fintek.com.tw:email,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 05DAE175ECA
X-Rspamd-Action: no action

If a write urb fails then more needs to be done other than just logging
the message, otherwise the transmission could be stalled.  Properly
increment the error counters and wake up the queues so that data will
continue to flow.

Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/f81604.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index c61bd30d1765..a41c6fef2a94 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -880,9 +880,27 @@ static void f81604_write_bulk_callback(struct urb *urb)
 	if (!netif_device_present(netdev))
 		return;
 
-	if (urb->status)
-		netdev_info(netdev, "%s: Tx URB error: %pe\n", __func__,
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
 			    ERR_PTR(urb->status));
+
+	can_free_echo_skb(netdev, 0, NULL);
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	netif_wake_queue(netdev);
 }
 
 static void f81604_clear_reg_work(struct work_struct *work)
-- 
2.53.0


