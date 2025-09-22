Return-Path: <linux-can+bounces-4791-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D1B8FEEF
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 12:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE81B7A5E12
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24F92FFF9D;
	Mon, 22 Sep 2025 10:09:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62842FDC44
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535765; cv=none; b=TgV6rpJFWSSouEHvzCwAriTJcL8dsPx9tOn+TZDa0Ou4/Iymwn1vIsfyM4RDD0Hf3kjRFqqUIt1EnCWgvqo2IMriI+NzToneByQfIbdwTJLdhGUHqnZEW7WbJ6L1gvzJsDUeItfcnkhq4wKqJNy+NZ0mzu16+H6ToLAUM5usquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535765; c=relaxed/simple;
	bh=Xxl4jLJMJGxnq5yT/SRo25N9ZDMaMNzJ3DCauKRx5B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJcgsPd8TIOaqIdN8gJT0EHBX2ZMYeXG48/EYFPKOrQEUGwWyM/tbB3ZtEBUWokwE7F237FdxWO7UCIM5f6YFwjIsLqhaERU0ZZg0ym8DOVr0dv5Hlym0oKWG2dFx+7+WkXDYm57CI+0N6uYsdX3w3uzoZLHKoLKL33QVLK7nTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dU2-0006ym-1K
	for linux-can@vger.kernel.org; Mon, 22 Sep 2025 12:09:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dU0-002ZXA-2M
	for linux-can@vger.kernel.org;
	Mon, 22 Sep 2025 12:09:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 62EE9476D2B
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 10:09:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B0FC3476CEE;
	Mon, 22 Sep 2025 10:09:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bd651fcc;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 09/10] can: esd_usb: Fix handling of TX context objects
Date: Mon, 22 Sep 2025 12:07:39 +0200
Message-ID: <20250922100913.392916-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922100913.392916-1-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

For each TX CAN frame submitted to the USB device the driver saves the
echo skb index in struct esd_tx_urb_context context objects. If the
driver runs out of free context objects CAN transmission stops.

Fixe some spots where such context objects are not freed correctly.

In esd_usb_tx_done_msg() move the check for netif_device_present()
after the identification and release of TX context and the release of
the echo skb. This is allowed even if netif_device_present() would
return false because the mentioned operations don't touch the device
itself but only free local acquired resources. This keeps the context
handling with the acknowledged TX jobs in sync.

In esd_usb_start_xmit() performed a check to see whether a context
object could be allocated. Add a netif_stop_queue() there before the
function is aborted. This makes sure the network queue is stopped and
avoids getting tons of log messages in a situation without free TX
objects. The adjacent log message now also prints the active jobs
counter making a cross check between active jobs and "no free context"
condition possible.

In esd_usb_start_xmit() the error handling of usb_submit_urb() missed to
free the context object together with the echo skb and decreasing the
job count.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-3-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index ed1d6ba779dc..efc96619ee9a 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -460,9 +460,6 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	struct net_device *netdev = priv->netdev;
 	struct esd_tx_urb_context *context;
 
-	if (!netif_device_present(netdev))
-		return;
-
 	context = &priv->tx_contexts[msg->txdone.hnd & (ESD_USB_MAX_TX_URBS - 1)];
 
 	if (!msg->txdone.status) {
@@ -478,6 +475,9 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	context->echo_index = ESD_USB_MAX_TX_URBS;
 	atomic_dec(&priv->active_tx_jobs);
 
+	if (!netif_device_present(netdev))
+		return;
+
 	netif_wake_queue(netdev);
 }
 
@@ -975,9 +975,11 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	/* This may never happen */
+	/* This should never happen */
 	if (!context) {
-		netdev_warn(netdev, "couldn't find free context\n");
+		netdev_warn(netdev, "No free context. Jobs: %d\n",
+			    atomic_read(&priv->active_tx_jobs));
+		netif_stop_queue(netdev);
 		ret = NETDEV_TX_BUSY;
 		goto releasebuf;
 	}
@@ -1008,6 +1010,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	if (err) {
 		can_free_echo_skb(netdev, context->echo_index, NULL);
 
+		/* Release used context on error */
+		context->echo_index = ESD_USB_MAX_TX_URBS;
 		atomic_dec(&priv->active_tx_jobs);
 		usb_unanchor_urb(urb);
 
-- 
2.51.0



