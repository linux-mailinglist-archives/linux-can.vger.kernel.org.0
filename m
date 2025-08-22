Return-Path: <linux-can+bounces-4309-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AAEB314AB
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544573B7899
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B724CEE8;
	Fri, 22 Aug 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bitwise.fi header.i=@bitwise.fi header.b="cEPwSRjc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8327E041
	for <linux-can@vger.kernel.org>; Fri, 22 Aug 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.204.228.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856845; cv=none; b=Nn92gJ8ovvUvpI71uce3hq2z0qJWwNVc534tRDeu2TxZrB3VExLr7qU8vydOU6Ycg6R/AfWteDKKQWoaOMo/H8oR3sRxVPjEJTfnZzzZUeZYm83kn7Sid2qOjfg2ezUSIHNVpVABgqpYxn14S33oDSGepmvt+w7366yj3YNxG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856845; c=relaxed/simple;
	bh=4QZgsMDfKg2fwOebUz0gcmy4kqEgEcnfngb+fa1o5kY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNedSAzevvj0OTxPRAorCtHUFFuJfgd6Xq6HP2XwT4+n6nOfoo7gTj/eRUaq5gOVShBN8VPKHVmHA00cqL6/HQcqwwijxGWsAPdH4CtcJSQEj1ojc4MVkCECZrSEnL/l1aZCcwzKxS2VIikuKh1p+o6pjSX0JYCbWxpZCaYB0DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitwise.fi; spf=pass smtp.mailfrom=bitwise.fi; dkim=pass (1024-bit key) header.d=bitwise.fi header.i=@bitwise.fi header.b=cEPwSRjc; arc=none smtp.client-ip=109.204.228.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitwise.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitwise.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.bitwise.fi (Postfix) with ESMTP id 57BD1460071;
	Fri, 22 Aug 2025 12:50:53 +0300 (EEST)
X-Virus-Scanned: Debian amavis at 
X-Spam-Flag: NO
X-Spam-Score: -3.1
X-Spam-Level:
Authentication-Results: mustetatti.dmz.bitwise.fi (amavis);
 dkim=pass (1024-bit key) header.d=bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
 by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavis, port 10024)
 with ESMTP id unEs7smQ8VfG; Fri, 22 Aug 2025 12:50:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bitwise.fi; s=mail;
	t=1755856251; bh=4QZgsMDfKg2fwOebUz0gcmy4kqEgEcnfngb+fa1o5kY=;
	h=From:To:Cc:Subject:Date:From;
	b=cEPwSRjc1LbgREqamPAi8UBZXVAeK5EJ/c+d3UFwu0cVPmv1jHV0g74KRhysi+Ll8
	 Pf46mDPCjXMy0poV8EonM7mJjs65GPePP/PM/EXX1uXRsuzHxKJAu3FQDnwdAky+pZ
	 0g60SjUsnCPDvDA+lCvT04l5ndcH65kW+A1kDiTQ=
Received: from localhost.localdomain (fw1.dmz.bitwise.fi [192.168.69.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: anssiha)
	by mail.bitwise.fi (Postfix) with ESMTPSA id 4AAB1460027;
	Fri, 22 Aug 2025 12:50:51 +0300 (EEST)
From: Anssi Hannula <anssi.hannula@bitwise.fi>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: xilinx_can: fix use-after-free of transmitted SKB
Date: Fri, 22 Aug 2025 12:50:02 +0300
Message-ID: <20250822095002.168389-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_put_echo_skb() takes ownership of the SKB and it may be freed
during or after the call.

However, xilinx_can xcan_write_frame() keeps using SKB after the call.

Fix that by only calling can_put_echo_skb() after the code is done
touching the SKB.

The tx_lock is held for the entire xcan_write_frame() execution and
also on the can_get_echo_skb() side so the order of operations does not
matter.

An earlier fix 3d3c817c3a40 ("can: xilinx_can: Fix usage of skb memory")
did not move the can_put_echo_skb() call far enough.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Fixes: 1598efe57b3e ("can: xilinx_can: refactor code in preparation for CAN FD support")
---
 drivers/net/can/xilinx_can.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3f2e378199abb..c14ffbe8e501a 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -690,14 +690,6 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 		dlc |= XCAN_DLCR_EDL_MASK;
 	}
 
-	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
-	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
-		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
-	else
-		can_put_echo_skb(skb, ndev, 0, 0);
-
-	priv->tx_head++;
-
 	priv->write_reg(priv, XCAN_FRAME_ID_OFFSET(frame_offset), id);
 	/* If the CAN frame is RTR frame this write triggers transmission
 	 * (not on CAN FD)
@@ -730,6 +722,14 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 					data[1]);
 		}
 	}
+
+	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
+		(priv->devtype.flags & XCAN_FLAG_TXFEMP))
+		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
+	else
+		can_put_echo_skb(skb, ndev, 0, 0);
+
+	priv->tx_head++;
 }
 
 /**
-- 
2.49.0


