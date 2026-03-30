Return-Path: <linux-can+bounces-7298-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGVhKtVOymmb7QUAu9opvQ
	(envelope-from <linux-can+bounces-7298-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:22:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D3359189
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24ED530382AA
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC713BD622;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBTPxNDl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0603BA232;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865903; cv=none; b=CrW+nCZLJ6yVgl2bOXtaMQ1z6zWAO4NbqO89dsSfoE3pn7lVKoO6jGGV6sWoPdMRom6YN5aPeSb3wKBCBQYQdmTMV4cFtV8poeyv240mGJYgaXC/x9hqm/WhiN2uepb6gqflhHxpnBP1xmnAbRWLVqXSzqkCEvHHzVU6iVT1xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865903; c=relaxed/simple;
	bh=OIgIuyhycg9AXmBXj6mX65CWn51yo9SjxDiNniDBd+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACWuOdtls/wrLKAX0tW0sMXTz4l5SSIJjUYmqAxnWZrol1VAkyfOvaqWwD6/Tts8Ufqsxx2pUEVmD/lp7eKGzQIKYhqRBSzuWMpMxLDU9lT7Vv8d1g0hpaTppV51he1vdU6hi1ysNh4JjReBJZ4872PI18SJpYCllU41xrct18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBTPxNDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0DC4AF0B;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865903;
	bh=OIgIuyhycg9AXmBXj6mX65CWn51yo9SjxDiNniDBd+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBTPxNDlhtMmxuPbMTogi6pg7bsxtCPg912fePUTWXdsBh7td1r1bgL67vgyLNOkM
	 qvaK8kGVzKqJ1b6b5+Q9wYgAqnmsk8Mm3L0F8k5PdgsZDio6sXEN9Q1baqJMxf4q0V
	 qn7nnjtD8v+e3BZZtezeF1fUwxHT8b0stEl6DKbZ5yqDIxmMHR0RW4TGv3UjeCjnsA
	 UPX6ehun749hrSgwXmJ30rak/iqB3SVJWsggcdDImCh+gFk4FmLEVG5/6t621Qcxzo
	 ED+bTgfJ/+PEd1fIQ1X2xj/8eQK1pJp9lzhxCmz43ot8ygyI5jyqBm3H6KH+gg5wuh
	 6k7s22UuF0a4A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79hM-00000006z5g-3stD;
	Mon, 30 Mar 2026 12:18:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] can: kvaser_usb: leaf: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:18:16 +0200
Message-ID: <20260330101817.1664787-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330101817.1664787-1-johan@kernel.org>
References: <20260330101817.1664787-1-johan@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7298-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 531D3359189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 25 ++++++-------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index fd191ec5738b..df737cfc5ea0 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1957,27 +1957,18 @@ static int kvaser_usb_leaf_get_berr_counter(const struct net_device *netdev,
 
 static int kvaser_usb_leaf_setup_endpoints(struct kvaser_usb *dev)
 {
-	const struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *endpoint;
-	int i;
+	struct usb_host_interface *iface_desc;
+	int ret;
 
 	iface_desc = dev->intf->cur_altsetting;
 
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		endpoint = &iface_desc->endpoint[i].desc;
-
-		if (!dev->bulk_in && usb_endpoint_is_bulk_in(endpoint))
-			dev->bulk_in = endpoint;
-
-		if (!dev->bulk_out && usb_endpoint_is_bulk_out(endpoint))
-			dev->bulk_out = endpoint;
+	/* use first bulk endpoint for in and out */
+	ret = usb_find_common_endpoints(iface_desc, &dev->bulk_in, &dev->bulk_out,
+					NULL, NULL);
+	if (ret)
+		return -ENODEV;
 
-		/* use first bulk endpoint for in and out */
-		if (dev->bulk_in && dev->bulk_out)
-			return 0;
-	}
-
-	return -ENODEV;
+	return 0;
 }
 
 const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
-- 
2.52.0


