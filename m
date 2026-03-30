Return-Path: <linux-can+bounces-7299-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOXDG9lOymmb7QUAu9opvQ
	(envelope-from <linux-can+bounces-7299-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:22:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18061359197
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E243039EC7
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE003BD628;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFcEBP9B"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD33B637E;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865903; cv=none; b=Pgx6dfJp1lROZi3Wa+Y3HxO1mr4JFU+H7jWa8DjQgZRowFjLUeFbsXJTdFZPLwWkHREfFB9s3Y0plcp/c8Uxq6BtBRJsyAiQg4N0RZdEpb9+sHeYYrZ7wA3CjwVU6Siftdn3LYoVxP4fv+k38ZicMPij6rf5VTgVDLFJPBdDos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865903; c=relaxed/simple;
	bh=YEp7K+9nwXsbUVpe89cW8Su6LQFrRqXZD7MMhYUb2Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exlpIR9dZzbbm7VACoHdoZ6uPLTl31L7upBHeIgBJvy10UtSwj4ndN1unZSHiFmdIk/oq8YBinBYHb39rPUWyo8M7hjTf27fmqlNUlbIBfQowY87C5o7O/b5VjQn3Dd0lE/HKLO6gS2evQzozYhKdCWq0rkcL4zLyllsqCInGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFcEBP9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E92C4CEF7;
	Mon, 30 Mar 2026 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865903;
	bh=YEp7K+9nwXsbUVpe89cW8Su6LQFrRqXZD7MMhYUb2Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFcEBP9B5Lf4hKg2qyKOORVWYXyB9P0gdirACb/iiYIEXlme8T4v8wmV3w2YaBYgU
	 P9mi9p0bDTV6p54KEPu4pSRzwDEO58yZulZFopm6lY7r2cmcgfPZYOozLp81B1wiVw
	 nN5Zq5jMjM88iIwe6l29Yk/ycTl/U+WOR6HNJ6rWA0UQMhplXNmDvU4Jk8MXFFx4OZ
	 aMuhCWfhJdEyZiRi5KO7nVbSE1cxw6NwWzA+bQ0ByNTBMMyney+8ZGj8iW4kEv7bz9
	 y9LKNHpTzOMUDR0Y4eHxtHFCsY+JqBbaAVn/Fgf62yTgnOa4ZrjDJLHQpI+zhoxpAV
	 CUYGCRpXgIGRQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79hM-00000006z5i-3wJx;
	Mon, 30 Mar 2026 12:18:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] can: ucan: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:18:17 +0200
Message-ID: <20260330101817.1664787-3-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7299-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18061359197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining endpoint numbers and max packet sizes) instead of open
coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/can/usb/ucan.c | 40 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index ee3c1abbd063..f72e0644c5fd 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1302,13 +1302,12 @@ static int ucan_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	int ret;
-	int i;
 	u32 protocol_version;
 	struct usb_device *udev;
 	struct net_device *netdev;
 	struct usb_host_interface *iface_desc;
 	struct ucan_priv *up;
-	struct usb_endpoint_descriptor *ep;
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	u16 in_ep_size;
 	u16 out_ep_size;
 	u8 in_ep_addr;
@@ -1343,37 +1342,20 @@ static int ucan_probe(struct usb_interface *intf,
 	}
 
 	/* check interface endpoints */
-	in_ep_addr = 0;
-	out_ep_addr = 0;
-	in_ep_size = 0;
-	out_ep_size = 0;
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		ep = &iface_desc->endpoint[i].desc;
-
-		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
-		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
-		     USB_ENDPOINT_XFER_BULK)) {
-			/* In Endpoint */
-			in_ep_addr = ep->bEndpointAddress;
-			in_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
-			in_ep_size = le16_to_cpu(ep->wMaxPacketSize);
-		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
-			    0) &&
-			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
-			    USB_ENDPOINT_XFER_BULK)) {
-			/* Out Endpoint */
-			out_ep_addr = ep->bEndpointAddress;
-			out_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
-			out_ep_size = le16_to_cpu(ep->wMaxPacketSize);
-		}
-	}
-
-	/* check if interface is sane */
-	if (!in_ep_addr || !out_ep_addr) {
+	ret = usb_find_common_endpoints_reverse(iface_desc, &ep_in, &ep_out,
+						NULL, NULL);
+	if (ret) {
 		dev_err(&udev->dev, "%s: invalid endpoint configuration\n",
 			UCAN_DRIVER_NAME);
 		goto err_firmware_needs_update;
 	}
+
+	in_ep_addr = usb_endpoint_num(ep_in);
+	out_ep_addr = usb_endpoint_num(ep_out);
+	in_ep_size = usb_endpoint_maxp(ep_in);
+	out_ep_size = usb_endpoint_maxp(ep_out);
+
+	/* check if interface is sane */
 	if (in_ep_size < sizeof(struct ucan_message_in)) {
 		dev_err(&udev->dev, "%s: invalid in_ep MaxPacketSize\n",
 			UCAN_DRIVER_NAME);
-- 
2.52.0


