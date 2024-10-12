Return-Path: <linux-can+bounces-1636-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65A99B364
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656AB1C20EBD
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FF914EC51;
	Sat, 12 Oct 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eeh0RcxL"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5242B9A9
	for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732334; cv=none; b=uZuOqy9hvwNNGrs8wyRP4Gfe5gytokJfReXnAi/tjwpB6p4XgZqz3B2aWrAlzJvGU1AwqwUzwVJfxIlUpq36rwfNsMVNmXyZmvHP6R6JezdJxWO36nE2kKWwcvLtWnRFsE0S3Ek1W4Ux5DceaxyFOYwWf414qIo+ITUCRkTwrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732334; c=relaxed/simple;
	bh=EMJ5epYKmTBTzOwPp0vQHDaOgwmLGioKtM7aLHW/h58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ij4a1q/qHlDRW/zRhc+uwRFfCyWmV3iS3rpZdhSkncHUOtnuPLGXdWW1nP6IgUU9VJabcQx/zBU7qr/4uMbXSxDpJNK4m7gHPg1TZivHolVbPPR9efwtdTH1tdg4fvDJidbgSuI2yDahQdmvY0wcr//LPsCjyOovBzWsydyhSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eeh0RcxL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99422c796eso464271866b.3
        for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728732331; x=1729337131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqch+ygbvMpz7dutYO15fpfHhvSna65z++eLDJO4/V0=;
        b=Eeh0RcxL+o4HxHy8C7i9VYVbZFrfIhKUNIOkD15MLeYtBKq3quMdcJdpaMNP4a2s8W
         BjNKwWfNMWAA3bLkaHSeL6K+u06k36G8anASz6bHeVcOtR9aJJHo4h2tMT1Gfm97Uitk
         ghApqa9M8zZS3tg5KY4BKrlLr7nozx0GUlIJzE1Xjkgn8MOkW2CT7dAwnWsD5bxV1AOr
         8k3PbYtEoT7JXby2N5gCpbz2KTyj1/Xj6Z9EGbwl2vc9nGmIn8nBjdK+IxJhkO2FvVCt
         AyvCoEBvmLQXc36BA55elql9EIGaity8FCjiPM9lBHPJMRHKeWrnrgXedc50ujLGwixJ
         HXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728732331; x=1729337131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqch+ygbvMpz7dutYO15fpfHhvSna65z++eLDJO4/V0=;
        b=JphIhsnxRt1fnQEvDKq1/875l4apRIPAng/zxmiTJCW3djBgAURFdvL2zP7PMy1jqD
         2bW07xCDDeUVx/lhhjLEotlXYF6HXaSTtxub2EuLpgAb/pA5+6sd5N4qrNrbdgnP+grD
         od6qUF5jfj4uHdDlInJXrKNq2IJAKdzTvZMllRWNRd3fMQvNdHJ7gkWFkrG3KYczhpGX
         uFQg/rC/rD+P+NbPdzEW55AgsZmG9uxYhtjhaYIyiN9PsST+fp86x/IKsOlFYlQTzkIq
         rbFbeGzuL5b9zJiG1O7tE8zc45dl+uHLrOapJuPH3YWT7StGYFKPgProutc11JPBKxZP
         esnw==
X-Gm-Message-State: AOJu0YwPm5bFbFDm2RSYXi+EP553yj83fd7IxbIjCF3nE0IA92HpzC7K
	lw1FCd2bNotIJVFTlW2az8bV2C3oNPZ36rTAtTocMk0WoitrV+PdJTKUnfSX
X-Google-Smtp-Source: AGHT+IE4QBye0y7Riucyx+HJMedXuvJG33iwShd6Xz31LdcKNIkxBPjCOPaOtnWGeLYw3O8BY3UN3A==
X-Received: by 2002:a17:907:1c81:b0:a99:374e:f3cb with SMTP id a640c23a62f3a-a99b95bc034mr433491566b.46.1728732331036;
        Sat, 12 Oct 2024 04:25:31 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc638sm312288266b.169.2024.10.12.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:25:30 -0700 (PDT)
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
Subject: [PATCH v4] can: gs_usb.c: add usb endpoint address detection at driver probe step
Date: Sat, 12 Oct 2024 13:25:21 +0200
Message-ID: <20241012112522.18464-1-ak.alexander.kozhinov@gmail.com>
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

To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Maximilian Schneider <max@schneidersoft.net>
Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>

---
Changes in v3:
- store pipe instead of endpoint address.
	This change implements nitpick:
	Instead of storing the ep_in and ep_out in your priv, you can
	instead directly store the result of usb_rcvbulkpipe(parent->udev,
	parent->ep_in) and usb_sndbulkpipe(dev->udev, dev->parent->ep_out).
- use reverse xmas tree declaration.
	This change implements request:
	Move this declaration up (c.f. the Reverse christmas tree declarations).
- use forward usb endpoints search.
	This change implements request:
	Any specific reason for doing this in reverse? The previous
	GS_USB_ENDPOINT_IN and GS_USB_ENDPOINT_OUT macros were respectively 1
	and 2, so at the beginning. And in such a case, the normal search
	would find those quicker.
- skip new variable declaration.
	This change implements nipick:
	no need to declare a new variable for host_iface which is used only once.

Changes in v4:
- put in CC most relevant mailing ist linux-can@vger.kernel.org
- use one patch only since only one logical/contextual change were introduced.
- add quick changelog over multiple pathc versions.
---
 drivers/net/can/usb/gs_usb.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..d93410682d4b 100644
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
+	unsigned int pipe_in;
+	unsigned int pipe_out;
 };
 
 /* 'allocate' a tx context.
@@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
-			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
+			  parent->pipe_in,
 			  hf, dev->parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
@@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	}
 
 	usb_fill_bulk_urb(urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT),
+			  dev->parent->pipe_out,
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
@@ -925,8 +925,7 @@ static int gs_can_open(struct net_device *netdev)
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
-					  usb_rcvbulkpipe(dev->udev,
-							  GS_USB_ENDPOINT_IN),
+					  dev->parent->pipe_in,
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
@@ -1413,6 +1412,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct gs_host_frame *hf;
 	struct gs_usb *parent;
 	struct gs_host_config hconf = {
@@ -1422,6 +1422,14 @@ static int gs_usb_probe(struct usb_interface *intf,
 	unsigned int icount, i;
 	int rc;
 
+	/* Find common bulk endpoints reverse */
+	rc = usb_find_common_endpoints(intf->cur_altsetting,
+									&ep_in, &ep_out, NULL, NULL);
+	if (rc) {
+		dev_err(&intf->dev, "Required endpoints not found\n");
+		return rc;
+	}
+
 	/* send host config */
 	rc = usb_control_msg_send(udev, 0,
 				  GS_USB_BREQ_HOST_FORMAT,
@@ -1466,6 +1474,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
 
+	/* store the detected endpoints */
+	parent->pipe_in = usb_rcvbulkpipe(parent->udev, ep_in->bEndpointAddress);
+	parent->pipe_out = usb_sndbulkpipe(parent->udev, ep_out->bEndpointAddress);
+
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-- 
2.43.0


