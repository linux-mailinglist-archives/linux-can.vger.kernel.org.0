Return-Path: <linux-can+bounces-4971-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E30B9A48F
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CF3BECE6
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F916308F23;
	Wed, 24 Sep 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6xFA4Ai"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D5307ACD;
	Wed, 24 Sep 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724643; cv=none; b=jQ9ZDpCjoJw5GDSGwUl1y4rmPSZWeNVaq6YAbI1FSnp8IGBcYXV5nhACpin8O/5SBr7fRuRyksBMfiimmffZB7S7ySKnPurYTitqCrlYe7Fncy4X2fuyMucZBLE2aQ+Z8DoaHBE3OS2ygGmOrWCJZqa53AJreAju65fraI5/nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724643; c=relaxed/simple;
	bh=HNqrACSQfsuribNEIKrYN9ez+lOP/hTsQsifTxoRnqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syuGfPwPJM7NJW32wOAf1W2FNefILv1l+UaDwm/y4gCqY1sfi14E/1ungGqu3Weq0mufkeZzrRQJBIU1H6jvV/8E4Be4BqgiZQY3K1cwCP+UodLg7Jw1xROJMIsa68F5WWMha1Wrqqewqp3hRr5dKMcQIIyxhb5ZtvIe5EcgaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6xFA4Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FC3C4CEF0;
	Wed, 24 Sep 2025 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758724642;
	bh=HNqrACSQfsuribNEIKrYN9ez+lOP/hTsQsifTxoRnqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6xFA4Ai+QpYBIZClZQisPtxbO6Swq91uBeRH8btNIRYJHNJAP3pegR95bXmXDp1k
	 LW7yjR1AL/Szjt4bwf+J+YuIL3sZ30hfE7kVetRJGA4xZQ5qp+5CGxU279SySotTCv
	 rg0U04UNahaVB9jYfKH+YKEc8YCQSV0V2IRVn5mmTRC5Hf5E3xh5gdWKQuuGXHav1t
	 zxFfLW/surKvvDbAKOUyt4qstVeYL9nQhgmE12kqZgUezrwQHrTTYElKZemDsbKnwM
	 lkrUxGowvNcnRTOJlVW9glq/avPl5hc3kTrYM15fkHc5pU09Am00F3bUTAfNQcx//l
	 zNDCRvOMSX4og==
From: Vincent Mailhol <mailhol@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	mkl@pengutronix.de
Cc: syzbot@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	syzbot ci <syzbot+ci284feacb80736eb0@syzkaller.appspotmail.com>,
	biju.das.jz@bp.renesas.com,
	davem@davemloft.net,
	geert@glider.be,
	kernel@pengutronix.de,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	stefan.maetje@esd.eu,
	stephane.grosjean@hms-networks.com,
	zhao.xichao@vivo.com,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH] can: dev: fix out-of-bound read in can_set_default_mtu()
Date: Wed, 24 Sep 2025 23:35:44 +0900
Message-ID: <20250924143644.17622-2-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
References: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=mailhol@kernel.org; h=from:subject; bh=HNqrACSQfsuribNEIKrYN9ez+lOP/hTsQsifTxoRnqM=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlXGP/s4pt5/kY/18zMS54KXK5FETfWp104uSz81MQny yfWcnre6ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRJemMDKuf6P+4VZxX9nPG zjuVu/1ncGxbrRYyo+66f3fhOa/Ldh6MDLuZox96+1YwXbsgtObWakZVw9/Sa4IDIhPqP9tmp9W WcgIA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Under normal usage, the virtual interfaces do not call can_setup(),
unless if trigger by a call to can_link_ops->setup().

Patch [1] did not consider this scenario resulting in an out of bound
read in can_setup() when calling can_link_ops->setup() as reported by
syzbot ci in [2].

Replacing netdev_priv() by safe_candev_priv() may look like a
potential solution at first glance but is not: can_setup() is used as
a callback function in alloc_netdev_mqs(). At the moment this callback
is called, priv is not yet fully setup and thus, safe_candev_priv()
would fail on physical interfaces. In other words, safe_candev_priv()
is solving the problem for virtual interfaces, but adding another
issue for physical interfaces.

Remove the call to can_set_default_mtu() in can_setup(). Instead,
manually set the MTU the default CAN MTU. This decorrelates the two
functions, effectively removing the conflict.

[1] can: populate the minimum and maximum MTU values
Link: https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-3-581bde113f52@kernel.org/

[2] https://lore.kernel.org/linux-can/68d3e6ce.a70a0220.4f78.0028.GAE@google.com/

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
@Marc, please squash in

  [PATCH net-next 27/48] can: populate the minimum and maximum MTU values
---
 drivers/net/can/dev/dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index e5a82aa77958..15ccedbb3f8d 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -272,12 +272,13 @@ EXPORT_SYMBOL_GPL(can_bus_off);
 void can_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_CAN;
+	dev->mtu = CAN_MTU;
+	dev->min_mtu = CAN_MTU;
+	dev->max_mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->tx_queue_len = 10;
 
-	can_set_default_mtu(dev);
-
 	/* New-style flags. */
 	dev->flags = IFF_NOARP;
 	dev->features = NETIF_F_HW_CSUM;
-- 
2.49.1


