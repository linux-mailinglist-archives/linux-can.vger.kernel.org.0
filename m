Return-Path: <linux-can+bounces-1293-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA096733B
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 22:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077CCB21F2F
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 20:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636C16F271;
	Sat, 31 Aug 2024 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSoU0Aob"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8315E81
	for <linux-can@vger.kernel.org>; Sat, 31 Aug 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725135429; cv=none; b=hz/hVfu7Ng01+QJRvSS34fx+VwLmD+Fz8PvHx/wAn46nPXdimcrEk1W1E7dEa2AD1A7Kn5unNDdpwyrHgfTcMN58nCcZKRqvcEmP6ebamIbvmBjEhSjX9gip+AGwLcE+tNe7n+3VUJoYqhEHwOMLYuoi6yjtuJV5jmDrNIGTfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725135429; c=relaxed/simple;
	bh=CQ/9Wp0pNNm7XlvEc00j76LUzzJF0de3XCufqBimnfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gO8WleMhreBuhU9JsFNwfsyds/JSzRUlrO8ZKv3V6rVidNKUDbk7d4FG22woxQxhRYtH9NEJzJxENq+l+o1HBdj1GZQP0LVqYArMF0p2BXVysW4vgb9NAAYuPIKqr30T0DGW8ORLNu/zD2X1GxjLzjKTk3yOQdMZf4VnO7odbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSoU0Aob; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-534366c194fso2714108e87.0
        for <linux-can@vger.kernel.org>; Sat, 31 Aug 2024 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725135426; x=1725740226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzA8hb80BaVinck/u9r4UyTMaZHzMwqRUwnIsZS2OIc=;
        b=dSoU0AobTeRYKYceMPull6XFfuj0I6Vl/fLZTuDfMZ3Ead51Z9+p2lr5Hfdm3V9P08
         /DIZQVl3Rc5ddh6V/8vOv6F/kX1+buzrc+axcwr/CeQf2u07F/cxnypebPGEGISX5drE
         9oko1VmwNeLVAh0+lRULmpASusy5xrt7jj5oro6XgOtaM/uP+H3sDc7GAkEmw8iwKbEe
         aoyZ+UG0U1Y5aDY/l4kRSLRDA3Fm0PFHsUZfVpH+dDUV0k+FwQxobFOeQaahs0coOBH6
         +6ngs4/kBzx8WIIQP6j7ztYXm/wO3nXSZGOY+Av/FOk+ybfFAcr51Td4hm3JbXy0SQ2C
         2UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725135426; x=1725740226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzA8hb80BaVinck/u9r4UyTMaZHzMwqRUwnIsZS2OIc=;
        b=AF7my9RoGfjbreF/AIwEYwDoItvkLU9X49nOTMq15fkgwIJDtReL2ngDYKceNmDReL
         9xkrBub2oV8SJFNRifklQdLNI+ZHGZ+EDqfMa1675zzoBP6s31LNoGwtggoFbpKZg/+d
         HR9DP47q5VMctWQVc7HR8sMridOy40VojblcLnOz5lsGVHsGx9v5kE4eTeukp4eYPPTg
         a2STWiG+31bQmAtU9icBWODNKpNqutwcXKx40/n/oiB7ooPJEhCEkoNnR6/ICd3vE/X9
         Zt1RZi77c9SdW/UFeY0Nyq2v6Q1ESrBBIRsCTqCm1Em/04nPt0ArHew1qHe3I+vvef6r
         cajw==
X-Gm-Message-State: AOJu0YwJe8DwrbX4vDGFGQOQZR6JTX+D47NxdVlW9uW6EAnzls1UKPN5
	JJcPfxW7SVxFLNYeLUUw3g/SVXehIwgXlz3wVWDShASDukkWCcXG0DqVxBpz
X-Google-Smtp-Source: AGHT+IEFjmEzYHAEowGJiX5PY7txA5EZY+52jMwkrGp3aG1etVRhNMbqheSCKrRCKwcKNud99CAQ3w==
X-Received: by 2002:a05:6512:1251:b0:52f:79f8:a42e with SMTP id 2adb3069b0e04-53546b1919cmr3880020e87.4.1725135425606;
        Sat, 31 Aug 2024 13:17:05 -0700 (PDT)
Received: from nuke-vm-u22.fritz.box ([2a02:8071:8284:5500:b77b:ec78:874d:a13b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feaf05sm358963966b.33.2024.08.31.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 13:17:05 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: linux-can@vger.kernel.org
Cc: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Subject: [PATCH] can: gs_usb.c: add usb endpoint address detection at driver probe step
Date: Sat, 31 Aug 2024 22:16:24 +0200
Message-ID: <20240831201643.331810-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Marc Kleine-Budde <mkl@pengutronix.de>,Vincent Mailhol <mailhol.vincent@wanadoo.fr>,"David S. Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@google.com>,Jakub Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,linux-can@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org>
References: <Marc Kleine-Budde <mkl@pengutronix.de>,Vincent Mailhol <mailhol.vincent@wanadoo.fr>,"David S. Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@google.com>,Jakub Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,linux-can@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..5f10cd9bced5 100644
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
@@ -1421,6 +1421,26 @@ static int gs_usb_probe(struct usb_interface *intf,
 	struct gs_device_config dconf;
 	unsigned int icount, i;
 	int rc;
+	struct usb_host_interface *host_iface;
+	u8 ep_in = 0, ep_out = 0;
+
+	host_iface = intf->cur_altsetting;
+
+	/* check interface endpoint addresses */
+	for (i = 0; i < host_iface->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *ep = &host_iface->endpoint[i].desc;
+
+		if (usb_endpoint_is_bulk_in(ep)) {
+			ep_in = ep->bEndpointAddress;
+		} else if (usb_endpoint_is_bulk_out(ep)) {
+			ep_out = ep->bEndpointAddress;
+		}
+	}
+
+	if (!ep_in || !ep_out) {
+		dev_err(&intf->dev, "Required endpoints not found\n");
+		return -ENODEV;
+	}
 
 	/* send host config */
 	rc = usb_control_msg_send(udev, 0,
@@ -1466,6 +1486,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
 
+	/* store the detected endpoints */
+	parent->ep_in = ep_in;
+	parent->ep_out = ep_out;
+
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-- 
2.43.0


