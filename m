Return-Path: <linux-can+bounces-3635-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89282AC06F1
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DD29E1AF4
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF77268FE0;
	Thu, 22 May 2025 08:24:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10B268690
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902240; cv=none; b=IxkWCHmzjhbccQ1hjUyWTEn2XpRQjGNd5PiX3gSMN10lBS0SRmW8W4owYI/kqEEWa5YlqnsbCmnV+jGYADoABYTxyLq4+xIlZ6g1IWTs9XSzSTG4ZmgMdLCWGZ1VuGlzkBF7swJEtpwbP89/fL67xNBEhEZqwX2PST0JvMAXPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902240; c=relaxed/simple;
	bh=Suh/u/XmZ7xZR25u+iGTujyE0cuCeff4qS1OwR1SJAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWPs7jlRYvDMxDegs3xXuRzXJ8BXWpcNKU4qyZgxfWkGqLEG7ZWU+CfQhyWthCqt0CTQ3lmCFhxeJKaq7kKclEf09e0wX1dtwjgPwuDd/6lIbcpmj/768a/1Kvc1JQeS62YtTt0B5jRqTY5/C/iwXRVAn5DOiStfcXfAPUtx/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1DS-0002D5-QO
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:23:50 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1DS-000ha0-1H
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:23:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1B6634171F6
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:23:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F02514171DB;
	Thu, 22 May 2025 08:23:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4690cd9a;
	Thu, 22 May 2025 08:23:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/4] can: kvaser_pciefd: Continue parsing DMA buf after dropped RX
Date: Thu, 22 May 2025 10:01:33 +0200
Message-ID: <20250522082344.490913-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522082344.490913-1-mkl@pengutronix.de>
References: <20250522082344.490913-1-mkl@pengutronix.de>
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

From: Axel Forsman <axfo@kvaser.com>

Going bus-off on a channel doing RX could result in dropped packets.

As netif_running() gets cleared before the channel abort procedure,
the handling of any last RDATA packets would see netif_rx() return
non-zero to signal a dropped packet. kvaser_pciefd_read_buffer() dealt
with this "error" by breaking out of processing the remaining DMA RX
buffer.

Only return an error from kvaser_pciefd_read_buffer() due to packet
corruption, otherwise handle it internally.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250520114332.8961-4-axfo@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a61cbade96d9..f6921368cd14 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1209,7 +1209,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_canfd_skb(priv->dev, &cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 
 		cf->len = can_fd_dlc2len(dlc);
@@ -1221,7 +1221,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
@@ -1239,7 +1239,9 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	priv->dev->stats.rx_packets++;
 	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
-	return netif_rx(skb);
+	netif_rx(skb);
+
+	return 0;
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
-- 
2.47.2



