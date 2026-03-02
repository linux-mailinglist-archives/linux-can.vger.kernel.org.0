Return-Path: <linux-can+bounces-6677-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFAcJwuvpWleEQAAu9opvQ
	(envelope-from <linux-can+bounces-6677-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:38:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9061DBFB3
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4A65305FD5E
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC76D41322F;
	Mon,  2 Mar 2026 15:28:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE8407582
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465293; cv=none; b=lOh5R9VB0BFfwvnULGmhilp9aBbSS5BYRFyjsvBkgpWL5DPCnheesOJ+TtlgZ0SgfD7TipO16ErB73GvnipRAZ2NudIhzjuKrlSBe+nPXWc+8C8eYzGQfzmqXKBtNGR3e7k4XRUYuWh+wLh1fbEdkN0UUZMTkTO/yPDzThwFeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465293; c=relaxed/simple;
	bh=3mZYEsDbDr9pGbHA3lo0cd5gHLsYCxXiw9738mCq+R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJJsXNWfC4JKBUdTtsJcrFyYonuOCc3kDNpeFQ97MIeRSlsQb6ujSZPlzt1mGaFOiev3/doSzOYtRJXSNkFxEqXrr8XbD6QeBAsk3FLYCozFk7BJYTauaKxGfVCKugp4l/yEjBHXxigVwylSWRb720Xc/yJboc0fwLv0+taaOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Be-0004kL-SH; Mon, 02 Mar 2026 16:27:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0e-1m;
	Mon, 02 Mar 2026 16:27:57 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9AF994F546D;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/12] can: esd_usb: add endpoint type validation
Date: Mon,  2 Mar 2026 16:16:10 +0100
Message-ID: <20260302152755.1700177-5-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: 9A9061DBFB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6677-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.906];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,northwestern.edu:email,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

esd_usb_probe() constructs bulk pipes for two endpoints without
verifying their transfer types:

  - usb_rcvbulkpipe(dev->udev, 1) for RX (version reply, async RX data)
  - usb_sndbulkpipe(dev->udev, 2) for TX (version query, CAN frames)

A malformed USB device can present these endpoints with transfer types
that differ from what the driver assumes, triggering the WARNING in
usb_submit_urb().

Use usb_find_common_endpoints() to discover and validate the first
bulk IN and bulk OUT endpoints at probe time, before any allocation.
Found pipes are saved to struct esd_usb and code uses them directly
instead of making pipes in place.

Similar to
- commit 136bed0bfd3b ("can: mcba_usb: properly check endpoint type")
  which established the usb_find_common_endpoints() + stored pipes
  pattern for CAN USB drivers.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Suggested-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260213203927.599163-1-n7l8m4@u.northwestern.edu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 2892a68f510a..d257440fa01f 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -272,6 +272,9 @@ struct esd_usb {
 
 	struct usb_anchor rx_submitted;
 
+	unsigned int rx_pipe;
+	unsigned int tx_pipe;
+
 	int net_count;
 	u32 version;
 	int rxinitdone;
@@ -537,7 +540,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 	}
 
 resubmit_urb:
-	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
+	usb_fill_bulk_urb(urb, dev->udev, dev->rx_pipe,
 			  urb->transfer_buffer, ESD_USB_RX_BUFFER_SIZE,
 			  esd_usb_read_bulk_callback, dev);
 
@@ -626,9 +629,7 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 {
 	int actual_length;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_sndbulkpipe(dev->udev, 2),
-			    msg,
+	return usb_bulk_msg(dev->udev, dev->tx_pipe, msg,
 			    msg->hdr.len * sizeof(u32), /* convert to # of bytes */
 			    &actual_length,
 			    1000);
@@ -639,12 +640,8 @@ static int esd_usb_wait_msg(struct esd_usb *dev,
 {
 	int actual_length;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
+	return usb_bulk_msg(dev->udev, dev->rx_pipe, msg,
+			    sizeof(*msg), &actual_length, 1000);
 }
 
 static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
@@ -677,8 +674,7 @@ static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
 
 		urb->transfer_dma = buf_dma;
 
-		usb_fill_bulk_urb(urb, dev->udev,
-				  usb_rcvbulkpipe(dev->udev, 1),
+		usb_fill_bulk_urb(urb, dev->udev, dev->rx_pipe,
 				  buf, ESD_USB_RX_BUFFER_SIZE,
 				  esd_usb_read_bulk_callback, dev);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
@@ -903,7 +899,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	/* hnd must not be 0 - MSB is stripped in txdone handling */
 	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
-	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
+	usb_fill_bulk_urb(urb, dev->udev, dev->tx_pipe, buf,
 			  msg->hdr.len * sizeof(u32), /* convert to # of bytes */
 			  esd_usb_write_bulk_callback, context);
 
@@ -1298,10 +1294,16 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 static int esd_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct esd_usb *dev;
 	union esd_usb_msg *msg;
 	int i, err;
 
+	err = usb_find_common_endpoints(intf->cur_altsetting, &ep_in, &ep_out,
+					NULL, NULL);
+	if (err)
+		return err;
+
 	dev = kzalloc_obj(*dev);
 	if (!dev) {
 		err = -ENOMEM;
@@ -1309,6 +1311,8 @@ static int esd_usb_probe(struct usb_interface *intf,
 	}
 
 	dev->udev = interface_to_usbdev(intf);
+	dev->rx_pipe = usb_rcvbulkpipe(dev->udev, ep_in->bEndpointAddress);
+	dev->tx_pipe = usb_sndbulkpipe(dev->udev, ep_out->bEndpointAddress);
 
 	init_usb_anchor(&dev->rx_submitted);
 
-- 
2.51.0


