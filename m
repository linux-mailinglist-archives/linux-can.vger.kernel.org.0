Return-Path: <linux-can+bounces-6610-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH7pLepDnGk7CgQAu9opvQ
	(envelope-from <linux-can+bounces-6610-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:11:22 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB0E175EE6
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3471B3004063
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0584364E99;
	Mon, 23 Feb 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rq5XNRE2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF135CB8C;
	Mon, 23 Feb 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848677; cv=none; b=DlxtifYzQ0OxVH59zMz7XtfCsYi09mWI2db1n/S7rY6J7GkYkHXKPbS7ZDJhpcPlFIxHecwpsGXybZQynl6KPwRlTSNzbsGiN5IcbNRahFCB5jbUVP6B06VFnTQSu2s557DOZs+Hw0g0ID0E0aVvbsIoa4omN99Px17jkBpCNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848677; c=relaxed/simple;
	bh=8IEW4SAiQIl7ZzybCSlIF3tLw5IO4JBakl5IYdmRLXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHgiHaXkhruaXjYVuek0Mp0dGMYkx2NyVSANBw5qZ2apnIEES2qWTraSXmcsuQymACbCqkybPNqeGIFp+/7unu6tUJykyu9xhZR/d/EzoJrpaUaK5mjWNbY9HbuG7f09wMuKjJ5uC3DOMiMgyLUuI5jD70WB8GKzHcxV/xWI9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rq5XNRE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D99C116C6;
	Mon, 23 Feb 2026 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771848677;
	bh=8IEW4SAiQIl7ZzybCSlIF3tLw5IO4JBakl5IYdmRLXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rq5XNRE2a3PmpV7JrGbvCxwsZMKMTI55tKyhAJhHt+OLbk7kR2tpNWc2Z1yZYOQIr
	 eX9BshWERIudJ691y8uKWqVbOOweEsvAqpwRsz+Cm/jismuvc6J27U7T6zJTWVgjp/
	 jvQfKKhAQWSYRpPDSBY8RYgFO+XAcWdntwNVleLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 3/3] can: usb: f81604: correctly anchor the urb in the read bulk callback
Date: Mon, 23 Feb 2026 13:10:32 +0100
Message-ID: <2026022334-starlight-scaling-2cea@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026022331-opal-evaluator-a928@gregkh>
References: <2026022331-opal-evaluator-a928@gregkh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 64
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=8IEW4SAiQIl7ZzybCSlIF3tLw5IO4JBakl5IYdmRLXY=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlznHc9jji8s9RYfzXrna8dvZ9EuivPB2pumJZ2cumRJ SERSV+VOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiUeoM812nSYV/iLo6J3WT J9cbly7WyQy8MQxzhVWWL3Nf0fmm69c9udvzBGacbZXUBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6610-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fintek.com.tw:email,pengutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DBB0E175EE6
X-Rspamd-Action: no action

When submitting an urb, that is using the anchor pattern, it needs to be
anchored before submitting it otherwise it could be leaked if
usb_kill_anchored_urbs() is called.  This logic is correctly done
elsewhere in the driver, except in the read bulk callback so do that
here also.

Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/f81604.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index a41c6fef2a94..68a6ef113843 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -413,6 +413,7 @@ static void f81604_read_bulk_callback(struct urb *urb)
 {
 	struct f81604_can_frame *frame = urb->transfer_buffer;
 	struct net_device *netdev = urb->context;
+	struct f81604_port_priv *priv = netdev_priv(netdev);
 	int ret;
 
 	if (!netif_device_present(netdev))
@@ -445,10 +446,15 @@ static void f81604_read_bulk_callback(struct urb *urb)
 	f81604_process_rx_packet(netdev, frame);
 
 resubmit_urb:
+	usb_anchor_urb(urb, &priv->urbs_anchor);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!ret)
+		return;
+	usb_unanchor_urb(urb);
+
 	if (ret == -ENODEV)
 		netif_device_detach(netdev);
-	else if (ret)
+	else
 		netdev_err(netdev,
 			   "%s: failed to resubmit read bulk urb: %pe\n",
 			   __func__, ERR_PTR(ret));
@@ -652,10 +658,15 @@ static void f81604_read_int_callback(struct urb *urb)
 		f81604_handle_tx(priv, data);
 
 resubmit_urb:
+	usb_anchor_urb(urb, &priv->urbs_anchor);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!ret)
+		return;
+	usb_unanchor_urb(urb);
+
 	if (ret == -ENODEV)
 		netif_device_detach(netdev);
-	else if (ret)
+	else
 		netdev_err(netdev, "%s: failed to resubmit int urb: %pe\n",
 			   __func__, ERR_PTR(ret));
 }
-- 
2.53.0


