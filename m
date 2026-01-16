Return-Path: <linux-can+bounces-6180-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D418D339E5
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 18:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B4FA3011464
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 17:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE36337BB6;
	Fri, 16 Jan 2026 17:00:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74F28C009
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582859; cv=none; b=EO5p+8aJlJ4xWHHf12kLzTjCCLAOaCTsHvlm1g4u6ATRq3mPTYzJKvUXwH17D5A9myq38LO6ZJpDzHg+wPrZFCJvY1MmrUHIzqZMudGKT7aCTODIVvxDVzmB4xC3oxU/g6fl6Hk3xgBur+VVtn2bkPlN5zqclH5/6BkhIvHLbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582859; c=relaxed/simple;
	bh=tGkYQ5gg9EzYjz+ajHuqiVwkL/PetkgOskGMUSyTyVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l2FY7nI9GFsgzxANnRajPL5Ry7nWiTcTvSwrvTo4cy44MdjuqD7lG2hnCDvOLZ66aFoV7Mk2cko4VOhID2i8qkWLOIPZxfkg80xYF27LflIjzxGN9oMt+9lspinWNwc5my007Q6ssU7D5ZokOA5BEHfpaT+ZW5BRbir1PXOVZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnBc-0004po-Ak; Fri, 16 Jan 2026 18:00:36 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnBc-000x9P-2W;
	Fri, 16 Jan 2026 18:00:36 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D26A84CED47;
	Fri, 16 Jan 2026 17:00:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 16 Jan 2026 18:00:31 +0100
Subject: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL
 on usb_submit_urb() error
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAK5uamkC/yXMQQqDMBCF4avIrB1IQnDhVUopYzrR6SKWmSqCe
 HdTXX483r+DsQob9M0OyquYzKXCtw2kicrIKO9qCC50zvsOE5XXYgNm2VCZSppmxUyRPEdHMQe
 o169y3a/s43nbluHD6fdvwXGcebhyEngAAAA=
X-Change-ID: 20260116-can_usb-fix-reanchor-fa4a1e40a4f2
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=tGkYQ5gg9EzYjz+ajHuqiVwkL/PetkgOskGMUSyTyVA=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpam6wDwdsGGZPRcR+LXVzc5i5Jy5a1gD0AMLMJ
 ZJX1kK892qJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWpusAAKCRAMdGXf+ZCR
 nGfsCACsgewffeWD/DKb0wD5qyomA2HAkZwg38Iw8chathaZWIxsqtmnb8YFd/gpODebvFw/813
 UxKUJSViPrWHOn/pxZZ5EIGXbgHaRJH9rK49i5ldUsCcJ+ISrtXmYtymFDfkUuruVHcB2F5kTcA
 ujDVmUzV2n4XPqL4u3jTdUmUzWEeUVMC8zx44X22igMujDe7VdqzfU0mEAnbKycfntV4+HcC+XP
 H1YYKI9+VptmlZPh/3Tw8e7bJiiatZ9mv0Xohh+of5GYhgIKzvwjPnVrNWTG07Txh698buLDB1N
 xdDFZfVT471DCYlYPK9ccF+DelNRbSdnkwqDA4VD0friyYA3
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In commit 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix
URB memory leak"), the URB was re-anchored before usb_submit_urb() in
gs_usb_receive_bulk_callback() to prevent a leak of this URB during
cleanup.

However, this patch did not take into account that usb_submit_urb() could
fail. The URB remains anchored and
usb_kill_anchored_urbs(&parent->rx_submitted) in gs_can_close() loops
infinitely since the anchor list never becomes empty.

To fix the bug, unanchor the URB when an usb_submit_urb() error occurs,
also print an info message

Fixes: 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d093babbc320..192338b481f2 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -754,6 +754,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	usb_anchor_urb(urb, &parent->rx_submitted);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!rc)
+		return;
+
+	usb_unanchor_urb(urb);
 
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
@@ -762,6 +766,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
+	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
+		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
+			    ERR_PTR(urb->status));
 	}
 }
 

---
base-commit: 61fb66044fe862612719a3579ff2ec2294e26051
change-id: 20260116-can_usb-fix-reanchor-fa4a1e40a4f2

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


