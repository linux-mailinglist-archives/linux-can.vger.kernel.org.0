Return-Path: <linux-can+bounces-6552-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEIrNxGMj2nURQEAu9opvQ
	(envelope-from <linux-can+bounces-6552-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 21:39:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B61397C4
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 21:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6F6300D45E
	for <lists+linux-can@lfdr.de>; Fri, 13 Feb 2026 20:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB941283FDC;
	Fri, 13 Feb 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="Vg9ZQaqc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757B250BEC
	for <linux-can@vger.kernel.org>; Fri, 13 Feb 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015179; cv=none; b=oloWLUnjP/E40Sw0y8czakFpKsSFmyy6xHTgGWQaO1mpns7a3Xgkdl8ZAmWlJp+v6oTUrsMzKx27wZr4y4M8M0m+aJ0GlKOFV5WQFculnbk4IwHGA4rAivV4w7ecewNWaX6b+dyiAVrjqRk1147eDN6f2wXf5omAfa5n+6y/7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015179; c=relaxed/simple;
	bh=PkCx504WUQw3zV2bV77aZM7bv/Fx1mHfx9GsW15YaFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XUjX809hz0+D1Q/otFX2PFviqb2SThVo2D7DuanoQMwMbkSf3FAkbmtc/MsH9S+d6XXxjvFSaU917yeDq1qwvsCCGhrRAbrO4pJGjmNBg4iqRQlsnMA5q1h/PQUrD8op9CzZQeN2gQ5hcmB2XAXeaWaf0dbVl4VAwIE3SPdeBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=Vg9ZQaqc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a321cc53so14696471cf.3
        for <linux-can@vger.kernel.org>; Fri, 13 Feb 2026 12:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1771015177; x=1771619977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u96JUABPipojjrofMBVXV/+R1lFeYvvLF1yUQTLyLHo=;
        b=Vg9ZQaqchubYEEW4d5i/EQ6jvyVq0ugWGEasE4Hd3AmAt7Wgt2/9ohFzXiLcE6LBQf
         zYSK+rQrcnJ7MJqGkXYiJe5ksdbMijmxDVG2AOKlhcW24dTEk853p0x3w4OIj3v2CPBq
         4HB22pXoqfD6CO8FZK2uz1IKq96+nzTStcMEw3PEm8O/PSZjX7sfZN+sRD/bYA6fcdIl
         19t9HluxeSBcOsWBx5ywEDGgw0a2qLK3BZORZNqFnoeHScMiqh5z6YX3WIdoEltFj8+/
         2mq9AAyOcBQYsADLz/98roJ1FTpDmr+q9IGM/pFQN5uNTyXrwxcDxuNstNF0um51hztv
         Xd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015177; x=1771619977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u96JUABPipojjrofMBVXV/+R1lFeYvvLF1yUQTLyLHo=;
        b=dk3rwOkoJ3YBwQBkTTXTSa8eEXp8liy+9igIKOzbzlot1nSZo9CUU/nJ4sKsOQEAwg
         9PMEUj2z1WAEM1wDZyqU8a7K3AK4GSEDrd1yCFlxZQTCNoqWPu3JFyj+zJhzoHZKPryI
         6L3IflZpBEYTCyR9o+3kImMAZ4LUjEWz5JQbyJpW7VSOw5SDd4vJvSrmVvMTuVvXsw77
         +Mb9yySlg0ViwOR35kUiZLj7tb2rWxNpHm68xgxn3bVJLrybzpkwnlcZbG/88KdICq9o
         ecgNn/4DvQw4QhJiVi+Vkd+5ypIeT5dCeVSAZndUkvGZKuHwsIx0KmKZ+4Cs/ju9CqBt
         AanQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgQOotnABxPmgvIYRbdX2o3IbyXuuNO4sxyULqFCQXRl06gtk/MwvFRlyxTIKwKYXQYpuzMCUxLBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyR3H5ZoIkHS5weG/nPbXRjNyVZNnq9IOOAnMqx1/Zadds2XDB
	X8eAT8hs81UsQOgCID4lS/+fmefiQXSYoG6JZ/VOQkcFZrK4DmaQ8zjFfOVMXktsxYA=
X-Gm-Gg: AZuq6aKuqG/6dUD89ThqhHr6HmdqO3KVAngkItNFXYkPVZxVb5fW0jUdCZLAYfhMfRe
	R21NGmr3hBZL0y7y2J8yPcsl1azOK6xc8YcZQn21JhKjk59J+v8IbnGrfKFqSVyf8ToRnx99iny
	wAhDsKQEccNUSh5isYLHHFx0Kzc95SAI8c5cgPI090opaRezUiBXjlAjNM9ggkiB4TJQmxAQRxf
	8KS9mrc8ZVbmjBuGXfNSY6bpfnS/2vMALYhHsCrmaA0m0KBRYf2Fj7PCnyhbwAKY2OlfoFPYHUC
	QeDzJOAQV9lXM2Yu2ZzUQY38zK8MFm9+SlknzhYh3GrhzcO0jgdnumYOkjEUT89iePqt55ZsPmZ
	aW5Y/7B6o0AGyDiWbJiS/D0EpaRmX2ky3rmMc+SCDnC4iabs4X14dTVFLvgNTZnP7qCc1CSFTG5
	722lefuAnnVvTMhwk1Tvc82dT9C5at8zMoE1IKU1usiAsJ7HPcSGafQU5wkoa7OgR2c+w8+nJt9
	mQO3vuEJOUQHwyzdhUl5zr+euow73dL4oEkEvj06wk=
X-Received: by 2002:a05:622a:1356:b0:4e8:b446:c023 with SMTP id d75a77b69052e-506a6aefc75mr45267961cf.49.1771015176679;
        Fri, 13 Feb 2026 12:39:36 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684bb9251sm69846281cf.30.2026.02.13.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:39:36 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Vincent Mailhol <mailhol@kernel.org>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: socketcan@esd.eu,
	"David S . Miller" <davem@davemloft.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH v2] can: esd_usb: add endpoint type validation
Date: Fri, 13 Feb 2026 20:39:27 +0000
Message-Id: <20260213203927.599163-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6552-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 470B61397C4
X-Rspamd-Action: no action

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
---
v2:
 - Use usb_find_common_endpoints() to discover and validate. 

 drivers/net/can/usb/esd_usb.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 8cc924c47042..c1da0f3acf89 100644
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
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
@@ -1309,6 +1311,8 @@ static int esd_usb_probe(struct usb_interface *intf,
 	}
 
 	dev->udev = interface_to_usbdev(intf);
+	dev->rx_pipe = usb_rcvbulkpipe(dev->udev, ep_in->bEndpointAddress);
+	dev->tx_pipe = usb_sndbulkpipe(dev->udev, ep_out->bEndpointAddress);
 
 	init_usb_anchor(&dev->rx_submitted);
 
-- 
2.34.1


