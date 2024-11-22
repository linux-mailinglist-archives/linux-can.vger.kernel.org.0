Return-Path: <linux-can+bounces-2194-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B429D65B4
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3C2B240A6
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020AD1E00A0;
	Fri, 22 Nov 2024 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Nkk8U3pL"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FB1A01BE
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313831; cv=none; b=T0i18dZGhGKlurC+r5odqbl5mAZBRocxADM/G9xPx5ONKvOY6emcjBTlD4zQlVcDFvzm0l1ElfCjlrXsMUVmFAvEUSOMBxs19Kzex5Z7ICGQFF93wHXNMtwCKLXcVCTBIQUDmJOR+ja2KWjcljYqt5j+ZpVek7fc7iT1Ylq96MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313831; c=relaxed/simple;
	bh=g+KZ+ry5q1eHB2f8lrq1UHjK33bU6W/wJPSO8TRzCfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjyKyYKgBmDAHCybKhBoTD7bRveTBK40EcC/2FFzSHcrY2XJ42A9oOsw9gK9C1/AtTsr+pxNFrgMlYAWRUPVDW4kmt3g3XlsVRCVcTMZnGTTFMTpB3uL4TOV/alPffL//ZJ124PipLKcLlIQh2LxBSBftovZUdAvKFmWvees2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Nkk8U3pL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso47893401fa.2
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313828; x=1732918628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeHUsvNMH4naO2lNY0rPoAp0glNUJp2xtRk2ah0U1WQ=;
        b=Nkk8U3pL2ZODtjNeyIgevRNEO70N9eFjwCKc8MqwrWSCwjy6Ep9mux5NrXE4bKgoXR
         lIXddL9p4OvpdXOdDR4Mpl1nkGZRQ/YYqqW5dbzMCAMpO+SAvm5LIlyk/Z5EaKMkt18X
         6LWdzfKuUOtgn7QCX6Lc5sMnbrmFDJi7D2fDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313828; x=1732918628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeHUsvNMH4naO2lNY0rPoAp0glNUJp2xtRk2ah0U1WQ=;
        b=fpM6WdTtL7ujPfwjsfxIZYWwREarcrhr4+tx4qGI4v4yCnIdQh6dm1Bn4xnCnHGiqa
         yVX7M58F6UxyE5hNAljA+YFekVAAA5QyjYsi2hluXIdvO9xpa/QU8/d0TuuKqbnfUQIX
         QpPixlfIQ4goatIY/GUcwrS4N+NwfUkOev53p5igvdOvGmEwdHhBFd2T+xTor8kbeama
         5bm7ZmX5h87IHgJRyTP3CzRl6BClovNBc91Q3Or+1xbs8dfZsw9dHMV4dtqXrXOf1wMp
         FRXC5z39+QD0IBVbAe+jWXoy7VraKnAGX5DcNff2kRyLdJ2ANVqF/075HwUpJczuDBBp
         8VTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8RFGAYQ7LXX2BYGij4TAHbYlqU5f2s0DgEyeInv6bZs4kKFvSgKqm6crTdhiWZVgQtsBx5irK4EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPW3MoqtwpMze6MLm+gJ2HqxCCAKLZwAhqVucuRqHV6yGzJuZ
	s4Dmt2TckiNLHm0edZcPS/bxsl6+o9meQRSuGXpm4yexbvh6jttzdfx2w3D6LS0=
X-Gm-Gg: ASbGncvWHTKSYQNMNB+0sCXRtnQwSFEulpQbf3CIIZMHVm1cZ+b0a3BJQ9gVuVsJbcH
	cBpjVvD0zqtklrI2mtszceRrhWdIKhulJwhBFeOYfkSd+vcI+SSXJ3pMjSqHogayUwFP4WQ0dQH
	IzTodUr3L3XlmYoIYIUt4dhbWiaRDiWJRpElIr4TmFU6Wicqlsd1cfzSaDplkulZdS6WhqkS2VI
	wWbAD+q9kv8NZMegIKG03TmTceTf2cIavQ3CtqrLrGXG2+Ss/BOlQwt08IcI68Q8QV8unGIuxu/
	f0+RtCxSdZbF93lU6figY/BFIBCmSPrdj1TwopbUFQMx9I4fesVT5KMYIMu0m1gziUDsEoZ3FiQ
	MzUhe6ZQ84NLKTS96
X-Google-Smtp-Source: AGHT+IEeFI0foJ6eMpkRjwKJ8WGldp4YObFth65iZk3Vn0s08/RYBKCV/cARJA+mH4yYzwEk4Lk/IA==
X-Received: by 2002:a2e:a58b:0:b0:2fb:36df:3b4 with SMTP id 38308e7fff4ca-2ffa7187eb1mr50418561fa.34.1732313828318;
        Fri, 22 Nov 2024 14:17:08 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:08 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sebastian Haas <haas@ems-wuensche.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 11/12] can: ems_usb: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:52 +0100
Message-ID: <20241122221650.633981-12-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ems_usb_rx_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. Increment the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/usb/ems_usb.c | 58 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 050c0b49938a..5355bac4dccb 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -335,15 +335,14 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	struct net_device_stats *stats = &dev->netdev->stats;
 
 	skb = alloc_can_err_skb(dev->netdev, &cf);
-	if (skb == NULL)
-		return;
 
 	if (msg->type == CPC_MSG_TYPE_CAN_STATE) {
 		u8 state = msg->msg.can_state;
 
 		if (state & SJA1000_SR_BS) {
 			dev->can.state = CAN_STATE_BUS_OFF;
-			cf->can_id |= CAN_ERR_BUSOFF;
+			if (skb)
+				cf->can_id |= CAN_ERR_BUSOFF;
 
 			dev->can.can_stats.bus_off++;
 			can_bus_off(dev->netdev);
@@ -361,44 +360,53 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 
 		/* bus error interrupt */
 		dev->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+		if (skb) {
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-		switch (ecc & SJA1000_ECC_MASK) {
-		case SJA1000_ECC_BIT:
-			cf->data[2] |= CAN_ERR_PROT_BIT;
-			break;
-		case SJA1000_ECC_FORM:
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-			break;
-		case SJA1000_ECC_STUFF:
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-			break;
-		default:
-			cf->data[3] = ecc & SJA1000_ECC_SEG;
-			break;
+			switch (ecc & SJA1000_ECC_MASK) {
+			case SJA1000_ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case SJA1000_ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case SJA1000_ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				cf->data[3] = ecc & SJA1000_ECC_SEG;
+				break;
+			}
 		}
 
 		/* Error occurred during transmission? */
-		if ((ecc & SJA1000_ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
+		if ((ecc & SJA1000_ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
+				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
+		}
 
-		if (dev->can.state == CAN_STATE_ERROR_WARNING ||
-		    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
+		if (skb && (dev->can.state == CAN_STATE_ERROR_WARNING ||
+			    dev->can.state == CAN_STATE_ERROR_PASSIVE)) {
 			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] = (txerr > rxerr) ?
 			    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
 		}
 	} else if (msg->type == CPC_MSG_TYPE_OVERRUN) {
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		if (skb) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		}
 
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 	}
 
-	netif_rx(skb);
+	if (skb)
+		netif_rx(skb);
 }
 
 /*
-- 
2.43.0


