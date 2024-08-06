Return-Path: <linux-can+bounces-1129-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ABE948A66
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138591F25937
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473C1BCA1D;
	Tue,  6 Aug 2024 07:47:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14A16BE26
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930466; cv=none; b=TbwdyzhrKU46OFpO7tF9sPDfH6LluZUZX84bvuQ9WQhWtIH7VQzYhr/9eRCT6yR7UbTUeFx5aZI+HjjURj5/lmiscaFEt7TQ/e7qQkE/lOstkpLQatmRgQpoDHNFI41Fuy01Re/eVgL8YjlI7SV+UT21ToN+QDBTNjQ7dwYefZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930466; c=relaxed/simple;
	bh=G8bU6dLcXBkm/vm1Me8Dxe2dsJmB+QbevI+RR+CAUqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWcJUp3u1uw9K2vYmJBtjMBT59WHffV2IutlpEyDg+FplsvKtJ5d/ycc+AqxB80GT0n1jot2dcpovUbp3/qJg+jrGPiKAvKmri2rgUgWUEMwPZcz2ThAcJnSvo6/hpy321+M3DgF/Ya14P6oN0jwcCZEpfXWaUUU0ArfDU1GPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuz-00046g-Sb
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuv-004tsd-CI
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 04F7D3179DB
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3F7DA31797E;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2368e13f;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/20] can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
Date: Tue,  6 Aug 2024 09:42:00 +0200
Message-ID: <20240806074731.1905378-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Set hardware timestamp on transmitted packets.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-5-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index f102f9de7d16..3764b263add3 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -10,7 +10,6 @@
  *  - Transition from CAN_STATE_ERROR_WARNING to CAN_STATE_ERROR_ACTIVE is only
  *    reported after a call to do_get_berr_counter(), since firmware does not
  *    distinguish between ERROR_WARNING and ERROR_ACTIVE.
- *  - Hardware timestamps are not set for CAN Tx frames.
  */
 
 #include <linux/completion.h>
@@ -1187,6 +1186,7 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 	bool one_shot_fail = false;
 	bool is_err_frame = false;
 	u16 transid = kvaser_usb_hydra_get_cmd_transid(cmd);
+	struct sk_buff *skb;
 
 	priv = kvaser_usb_hydra_net_priv_from_cmd(dev, cmd);
 	if (!priv)
@@ -1213,6 +1213,9 @@ static void kvaser_usb_hydra_tx_acknowledge(const struct kvaser_usb *dev,
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, irq_flags);
 
+	skb = priv->can.echo_skb[context->echo_index];
+	if (skb)
+		skb_hwtstamps(skb)->hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cmd);
 	len = can_get_echo_skb(priv->netdev, context->echo_index, NULL);
 	context->echo_index = dev->max_tx_urbs;
 	--priv->active_tx_contexts;
-- 
2.43.0



