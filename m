Return-Path: <linux-can+bounces-2653-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4036A11CBE
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 10:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964EF7A4F46
	for <lists+linux-can@lfdr.de>; Wed, 15 Jan 2025 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8DE246A10;
	Wed, 15 Jan 2025 09:01:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBC7246A28;
	Wed, 15 Jan 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931716; cv=none; b=ussWSsT+A6th4X5PifGKIVt1MXvlueZYXxEtFndmq0VKXg0/xmUZuZXLqZ71AJTMy2Rx8kNzaItTboUet0/qap5VvNjvx3kCFHA9u6TlOgde17v6DsHtgoamq0Uuymp/t/iSy0bCrv9R38jZwDiELktsNzthnGMvgUdIvpyPm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931716; c=relaxed/simple;
	bh=gH6zwza+XckBcGQtgmLQkMkYvs+UWoIj8KPqpYtF8/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LKx+qON253JBIi8b3wVLi6PpU3HEXEk4Vy9rrpuQHRhdNFJOjKFMrMM5CTfLPAEY70si3XM7lPc8/ZvhPBuoS4LJKJdRU8i2GoDJ3+d1OkGLV2PvJggP2XmwA+2DGi8qiGZkgT24vSLfBuS7qiulR+ocBEh7tBxdYX79QmXKtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 50835233A9;
	Wed, 15 Jan 2025 12:01:51 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10/5.15] can: hi311x: hi3110_can_ist(): fix potential use-after-free
Date: Wed, 15 Jan 2025 12:01:18 +0300
Message-Id: <20250115090118.334324-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 9ad86d377ef4a19c75a9c639964879a5b25a433b ]

The commit a22bd630cfff ("can: hi311x: do not report txerr and rxerr
during bus-off") removed the reporting of rxerr and txerr even in case
of correct operation (i. e. not bus-off).

The error count information added to the CAN frame after netif_rx() is
a potential use after free, since there is no guarantee that the skb
is in the same state. It might be freed or reused.

Fix the issue by postponing the netif_rx() call in case of txerr and
rxerr reporting.

Fixes: a22bd630cfff ("can: hi311x: do not report txerr and rxerr during bus-off")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://patch.msgid.link/20241122221650.633981-5-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[kovalev: changed the call order of netif_rx_ni()
according to netif_rx() of the upstream patch]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2024-56651
Link: https://www.cve.org/CVERecord/?id=CVE-2024-56651
---
 drivers/net/can/spi/hi311x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 28273e84171a25..1cdc05475cda61 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -673,9 +673,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			tx_state = txerr >= rxerr ? new_state : 0;
 			rx_state = txerr <= rxerr ? new_state : 0;
 			can_change_state(net, cf, tx_state, rx_state);
-			netif_rx_ni(skb);
 
 			if (new_state == CAN_STATE_BUS_OFF) {
+				netif_rx_ni(skb);
 				can_bus_off(net);
 				if (priv->can.restart_ms == 0) {
 					priv->force_quit = 1;
@@ -685,6 +685,7 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			} else {
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
+				netif_rx_ni(skb);
 			}
 		}
 
-- 
2.33.8


