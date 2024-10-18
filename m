Return-Path: <linux-can+bounces-1719-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F79A48DE
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2024 23:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413161C230AF
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2024 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35165204953;
	Fri, 18 Oct 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+Ja2zKi"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC518C92A
	for <linux-can@vger.kernel.org>; Fri, 18 Oct 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286720; cv=none; b=rScYj0+9EXciOPRXXTP8euvT8idWYu8GLIiXq7ODDjmft7jWirRZAG57B4V91qAyVXoAUrsbGIzLwHY70l+ofw/wjp8RrmKf3OZAGkFE6RDWHrSN187Wqz62RSG/07YH0N6as0ZBNxAwao9OiZhioM8vc4LyMwaA7HFmqXgf+vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286720; c=relaxed/simple;
	bh=/jh7PhdHgoPhdvJLmvqS0laTHv2aSe247wwfvMs3JdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aGDDpzoca7WVpLYpsZYKnCpBcq93P8znahlzTJBYkxGslB3DQ17yqWMQ6mAzOepqJVspd9ZC6uY90HqC8ekaKSZGrHeEfwcTvMIzrzXTSZiyHS7gq4gofaRCMwY7mf7MsgLWZHgW6WK/v6xWycaU2/TQrwePGIicTxjpycMhiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+Ja2zKi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so324878266b.0
        for <linux-can@vger.kernel.org>; Fri, 18 Oct 2024 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729286716; x=1729891516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3PesIRhYfEU1201pgRUivxFLME+Dl0+qlkrWXQEFfs=;
        b=N+Ja2zKifc43hDdRSPodmK66cS62UJGrsGfTedOExDFxE6JNIBr7+vZF2iHXHgwpGL
         reFcPgaLC/7VbJgTOQAm5ZZoGT7yuVhvGb9J9v4OzMT/bwyOo0F9hfQ3jBa3vX0ET93Q
         FdYNMwYJC9+MwlhLuWt10j9DgX4LwXZV0OXFvlQ1GBD4dH+3UbAiTG7FRzjcJG9Vv1la
         9s4esIyJVnPoSqhOcqqWSdvKAy7vJ8wVeHUWkKoNESG88sU/zPhumHmBkAUUq6h20N/Y
         AIk2DEPdAcN/S0iXCfFm+YqVGpkhczwU4a2Fve5flZKCrx7vQpIDPSlesB0X/pNrsixz
         OucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286716; x=1729891516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3PesIRhYfEU1201pgRUivxFLME+Dl0+qlkrWXQEFfs=;
        b=mfz86hx2oeiZ2DOtD7edmjWiKXATd0IREX7QQQ/Dtayi1A2JGDdLwrfeaKcyfvGIrQ
         TwApW4INey5Uek0pEZwjHW0O45TeQCSAqungMAKK2iihH6iLb9vRHwyxTExOcTEygavo
         YKv49/VpSG+3V6hnXrdacRMKHPqebklZLO7ihLLF77TtLyVH40p6ESe9+syk8AHQlIHa
         HRv7ybi2ajAKhzd2tfxc+7p+7DZ5shrBqaYPLvK0uxs1zxDKWjtLRLs6PEENFytCnNHT
         El9CfoOeb5mFkvL1ZnFvyr8mv8kCmFg7oJPtPAaJ8JywbF9wLEnvtRMhNkgu9QPemFxS
         eAjQ==
X-Gm-Message-State: AOJu0Yywcl0fKt7IEeSrN6VKiCy+ubLYgJknAhChOpgHkY9OxLGI/DOe
	oIhsatTolSiWoF1J848Zpqsy2AiSJHhIV8bmC/lO8/meU47eke/1t3OHBXuA
X-Google-Smtp-Source: AGHT+IHs+YqHWFdjRwM/jpuh/4FI8ox80OMzge0jJ4ZHvlmKCO8zw02zOjVx5PtuyrNFnDZqcdjYsw==
X-Received: by 2002:a17:907:7285:b0:a9a:f82:7712 with SMTP id a640c23a62f3a-a9a69cd044fmr384298366b.52.1729286715993;
        Fri, 18 Oct 2024 14:25:15 -0700 (PDT)
Received: from localhost.localdomain (ip-037-201-007-048.um10.pools.vodafone-ip.de. [37.201.7.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ae98d5sm139030066b.86.2024.10.18.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:25:15 -0700 (PDT)
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
Subject: [PATCH v6] can: gs_usb.c: add usb endpoint address detection at driver probe step
Date: Fri, 18 Oct 2024 23:24:26 +0200
Message-ID: <20241018212450.31746-1-ak.alexander.kozhinov@gmail.com>
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

Changes in v6:
- update alignment on line 1426
---
 drivers/net/can/usb/gs_usb.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..b6f4de375df7 100644
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
+				       &ep_in, &ep_out, NULL, NULL);
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


