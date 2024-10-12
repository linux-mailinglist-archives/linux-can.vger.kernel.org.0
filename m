Return-Path: <linux-can+bounces-1641-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CF99B723
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE60282034
	for <lists+linux-can@lfdr.de>; Sat, 12 Oct 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5CE12C549;
	Sat, 12 Oct 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QezSq2g+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05114C2C8
	for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728768272; cv=none; b=CTd6yQiGqQIcTpZR3p40ekDjdRiylYnXB4nIiXweZGVYUpcXfU/M7+yv9J1jzBPmZjVZonz6Y+Zkcy/IYZf9cL4xn0c0LBq7MyMBMWNJULhXlWtjeDXcmy3D0mqOuogLJAILH7NhHnsr81owVMUVqCh2q39TVVOKoXyZodujCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728768272; c=relaxed/simple;
	bh=bif1rIVJ3PW9CJ+gGfooJuQxBsf/JlzY2dLbQQH+Iow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GM+sFZCCoU5KPpPx7hqv6xTZBhtVRKROJmQX2Vc48CchW10SXNpaUvp5/xoNVckwBdk1W1RszLsfT2IHShG6+MCehAEyVhSxaParUXJW1FEKzuBGV8y6hr89ROj2xIIP6vvvyP2zmE8n8SY7y7tL0bj86rmaHLY0owgqOF9C64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QezSq2g+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so1375138a12.0
        for <linux-can@vger.kernel.org>; Sat, 12 Oct 2024 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728768269; x=1729373069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSwjJvDnbmlvH26JLO40Tbe5ZAVDlmXg1eALlE14Y3c=;
        b=QezSq2g+nAr/P1TsIY1zjMGm9VF13ywL2tiD5gCqR8ExbbwRBSfnOZ72y9NHh1kiiv
         UatrbM7aPHbsMYxvxFEB/7GYhY2vccTj/ANQe1ikp0XbeU4srsjTCHwsZemfL68WCYj1
         oZ/Tk6SXTvdL/OYIVfJl3rybzgX/fMGzJTGb1eqMLgktXfvIin0u64znXOYtd9eEOpqq
         a5R0Uc7AeM9JUsNlKRrtFfNu9uqVmI+x/HsL3GYN1U4IX23LNoKNUdp3UWWAc4RkEk4L
         njxYzKQNzlVmmiLPZT0iauS73bfvXXVJW/llQITdCcu6QA5wj0kw69Gqq/J8Y1mihKG2
         yJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728768269; x=1729373069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSwjJvDnbmlvH26JLO40Tbe5ZAVDlmXg1eALlE14Y3c=;
        b=em0ZrOq4LB9P7daPqDqp6INqv0Mx0Dkow03BWdpImfRN2St3fLkNzaFVMxjP+e45Mq
         hGipRlOmIURiGzFo8/NPWZtrySk8pHg9jCvKHMoBLxXMkXjpbJ2tYWy4G+NaYAakr0cm
         wsGsPmbgGHgGj0A6UzWh7+ElgWqweRTUBuZpYbu3T8GfeLb1fGJAZqCw5k7uDExN5nj1
         Dt6+EtqoDGx6wcOitN2VP6ZiITWfA2WcYkz+hu+W6eNRUjBMPN6B8FCDWUjftlkMd/JI
         P0wLHku9x5fKps4bsDm63AGirPluXhdX5L+MFiWq7Zvc5PxFA6e9kkwasoMqnz44NZ6D
         OSow==
X-Gm-Message-State: AOJu0YzZIYgL2HGuOAIdzphru2reUTAfwtONkWDQyuzNwFdJzT6U+EfL
	yG+fjs3mQ+g6bHgAZ3fuEg1UlT9/MDkFeJhTINC28Kkd+7r8IZQKCRrBZEWb
X-Google-Smtp-Source: AGHT+IHloEdd8XlYZEikZ9Wtgk+c4Ei8Ay0oaTa1cbKJiZEdK7qe+zaXQbE06O6KFTiiEm2aZ2bEIw==
X-Received: by 2002:a05:6402:34cf:b0:5c9:3f2:ea54 with SMTP id 4fb4d7f45d1cf-5c95ac09854mr4968081a12.4.1728768268878;
        Sat, 12 Oct 2024 14:24:28 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc36bsm360136666b.157.2024.10.12.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 14:24:28 -0700 (PDT)
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
Subject: [PATCH v5] can: gs_usb.c: add usb endpoint address detection at driver probe step
Date: Sat, 12 Oct 2024 23:23:13 +0200
Message-ID: <20241012212347.15141-1-ak.alexander.kozhinov@gmail.com>
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
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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

Changes in v5:
- add fixes tag to commit message
- add reviewed-by tag
- remove comment on line 1425
---
 drivers/net/can/usb/gs_usb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..77bb8e197994 100644
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
@@ -1422,6 +1422,13 @@ static int gs_usb_probe(struct usb_interface *intf,
 	unsigned int icount, i;
 	int rc;
 
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
@@ -1466,6 +1473,10 @@ static int gs_usb_probe(struct usb_interface *intf,
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


