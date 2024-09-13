Return-Path: <linux-can+bounces-1497-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0502978830
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2981F26B80
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2024 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BF43AAB;
	Fri, 13 Sep 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEy9e9T3"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223182D70
	for <linux-can@vger.kernel.org>; Fri, 13 Sep 2024 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253528; cv=none; b=bz96bTF+N6XNssMZUvDPo+UDm6HQ4uNK/5chHYNHNuQ4KXsk7UHhX0vjg8C13gkYhKLeCR3GDgRoHoxzCUYtliuHyA599xGnwGiISwS9yK3972q1f15D0SaLXWcv0pbJXVwL5ghNWrysHALWm9kxEUXwo+7Jj/cmAbPgdkOmpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253528; c=relaxed/simple;
	bh=pebvBqQhmI9fzj6k5z1Y0nY8KVdpWhNXc+UBmfx2duE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3BRgIHHE2zvkBwh5X83iMpgDj6zo/nEZDKmZI7IRxrmR81m/kTJ6k646iyziTyRyKJt3WCqX/Fi6KP55eRRRguvVPJy3q8akL7s2TcrDymdp+OOxXSCmlT8Z9wjs+BX1Agmzw46aj8lqSNvdmPqhMT27lHZJIMaOQIelPAJz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEy9e9T3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so284897866b.2
        for <linux-can@vger.kernel.org>; Fri, 13 Sep 2024 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726253525; x=1726858325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RmAG5gKEGZCgK/QfvRdMfDRLUmfj4mjb8FlSXoyiiY=;
        b=hEy9e9T3k1eUb3MKfJNc++PLbOT1VdMUAFC4YKh4abF7zcrqlq86UZ8A5qwDkNmXoY
         75nnGw8ZdkeGObfAPkm6MPbLnFMHFP4CJfol/b5th6RxW62HX4gIbpYdJoFxd4ICJ/6B
         fhO2KcrAn3TQoDtxEhyWSCJ2V2/LMSY18/1hnM65pUG+ESLepiC2cqY3Cqs1k+1DGJt5
         XP5RycCZAy3U0q97528OeRNvW1cFtON4osWNxJYAIFMr7UQ2T8tnc4Z0KiPS94zt+bwR
         habL5GrqyEZRPPc94sUiM5qS0cqlit4W0pk0J42v3Hu/HNaOPmS+MDU/ckPk9IkpQlUV
         dzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253525; x=1726858325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RmAG5gKEGZCgK/QfvRdMfDRLUmfj4mjb8FlSXoyiiY=;
        b=m3xFJ3E7XW0w5pyF3ryxtrCK8cgN/ghYZhzwJMpTbVlEGwDA9FIcUXyQAhkdPJfGXC
         oqm98eocWcjZQzUQ9qYJltlWull1oAQu0g4ENgH/Nk3+elSbRsXSa7LIqiDP3UvkClxG
         jHKWfNKCKMXA6CWkk022xRA+Q4tUqoeW83Zw3dWkGc+duwHHFVXyEr1cJndgihezkq8M
         Zl81YRKp/7MyCVl/ar61OXpfUm7JMcKDsHMz7ggPa279t8bPuLcAhi+aeC3WE6YAOD5D
         KoQfxScUNtOZV3HkZK9n2hXHURu/Novl16hATYmv5ZaREi4RclJiikscD7e/qvjwLvxJ
         02qQ==
X-Gm-Message-State: AOJu0Yw7Z6ohn8DYVDUQn1TkXG+r9JtzQ3i83LQP38OFF30EjCbLErcU
	F0GXLlmKR1hCb6G9+wu2hE32jd7uBI6RavC5r90A3O1g6KkKM6foDuBHPNN/TMo=
X-Google-Smtp-Source: AGHT+IEyE5koXfoftG6CdIpBe6u+QkPFwYWDCnNV3IjXJHMpiBN184wDtkxIgs1qJextuODSDtvm7Q==
X-Received: by 2002:a17:907:f168:b0:a77:d52c:c42d with SMTP id a640c23a62f3a-a902941e749mr682391566b.13.1726253524959;
        Fri, 13 Sep 2024 11:52:04 -0700 (PDT)
Received: from nuke-vm-u22.fritz.box ([2a02:8071:8284:5500:4503:6c8:1ec3:5d3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cee72bsm910387066b.173.2024.09.13.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:52:04 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: linux-can@vger.kernel.org
Cc: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maximilian Schneider <max@schneidersoft.net>
Subject: [PATCH v2] can: gs_usb.c: add usb endpoint address detection at driver probe step
Date: Fri, 13 Sep 2024 20:51:55 +0200
Message-ID: <20240913185156.123924-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is an approach made to implement gs_usb firmware/driver based on
Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB
EP addresses, if they have different last 4 bytes in absence of other
endpoints.

For example in case of gs_usb candlelight firmware EP-IN is 0x81 and
EP-OUT 0x02. If there are no additional USB endpoints, Zephyr RTOS will
overwrite EP-OUT to 0x01. More information can be found in the
discussion with Zephyr RTOS USB stack maintainer here:

https://github.com/zephyrproject-rtos/zephyr/issues/67812

There are already two different gs_usb FW driver implementations based
on Zephyr RTOS:

1. https://github.com/CANnectivity/cannectivity
   (by: https://github.com/henrikbrixandersen)
2. https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAlexander:zephyr:gs_usb
   (by: https://github.com/KozhinovAlexander)

At the moment both Zephyr RTOS implementations use dummy USB endpoint,
to overcome described USB stack behavior from Zephyr itself. Since
Zephyr RTOS is intended to be used on microcontrollers with very
constrained amount of resources (ROM, RAM) and additional endpoint
requires memory, it is more convenient to update the gs_usb driver in
the Linux kernel.

To fix this problem, update the gs_usb driver from using hard coded
endpoint numbers to evaluate the endpoint descriptors and use the
endpoints provided there.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Maximilian Schneider <max@schneidersoft.net>
Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..f3eb447267f9 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -43,9 +43,6 @@
 #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
 #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
 
-#define GS_USB_ENDPOINT_IN 1
-#define GS_USB_ENDPOINT_OUT 2
-
 /* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
  * for timer overflow (will be after ~71 minutes)
  */
@@ -336,6 +333,9 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+
+	u8 ep_in;
+	u8 ep_out;
 };
 
 /* 'allocate' a tx context.
@@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
-			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
+			  usb_rcvbulkpipe(parent->udev, parent->ep_in),
 			  hf, dev->parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
@@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	}
 
 	usb_fill_bulk_urb(urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT),
+			  usb_sndbulkpipe(dev->udev, dev->parent->ep_out),
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
@@ -926,7 +926,7 @@ static int gs_can_open(struct net_device *netdev)
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
 					  usb_rcvbulkpipe(dev->udev,
-							  GS_USB_ENDPOINT_IN),
+							  dev->parent->ep_in),
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
@@ -1421,6 +1421,18 @@ static int gs_usb_probe(struct usb_interface *intf,
 	struct gs_device_config dconf;
 	unsigned int icount, i;
 	int rc;
+	struct usb_host_interface *host_iface;
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
+
+	host_iface = intf->cur_altsetting;
+
+	/* Find common bulk endpoints reverse */
+	rc = usb_find_common_endpoints_reverse(host_iface, &ep_in, &ep_out, NULL,
+											NULL);
+	if (rc) {
+		dev_err(&intf->dev, "Required endpoints not found\n");
+		return rc;
+	}
 
 	/* send host config */
 	rc = usb_control_msg_send(udev, 0,
@@ -1466,6 +1478,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
 
+	/* store the detected endpoints */
+	parent->ep_in = ep_in->bEndpointAddress;
+	parent->ep_out = ep_out->bEndpointAddress;
+
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-- 
2.43.0


