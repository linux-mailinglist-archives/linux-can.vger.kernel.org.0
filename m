Return-Path: <linux-can+bounces-1442-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4C97135D
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAEC284502
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A111B3F2D;
	Mon,  9 Sep 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynqs4s9i"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09821B2EE8;
	Mon,  9 Sep 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873684; cv=none; b=f0Fx8lSR4+xQtQNZQ0LOjn6UNVcV49pHd8fcDn0+SDFNdcm+fKs6UsNXfBo10eOdmlqOJb0pa3iLOBYGj4rjl4ty+FTehcbuxx/U8gpWW2wCSdzUYeTVBnTAvMntVAhOEAqlD2j4VVIrvDjyA2wB3oSJwWjJzFgkX5gqpK4cVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873684; c=relaxed/simple;
	bh=EN0rYz6GhfIyTI+7CtSvs0C+p/rAFAhcpRv46mV8xGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QR5ShyAifRWWZVVsSgXoa1gMe1QTotdlBuJgbbl/UYfd4rH2gLbwOIjDlvzNp3LiOVXoZ3fWWrUccOt06gjwQw5666LN3lqkSi8tb3EORGIfFKiOWta7wcTaT+MEfz6z8H66BkGfw8N+2tqPICsGMyJkO6LGBbXTSpo0fCSIhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynqs4s9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E32EC4CEC5;
	Mon,  9 Sep 2024 09:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725873684;
	bh=EN0rYz6GhfIyTI+7CtSvs0C+p/rAFAhcpRv46mV8xGg=;
	h=From:To:Cc:Subject:Date:From;
	b=Ynqs4s9i289Kjnz+D0c9Kzwx0R66UgrbNR2HM7qHCC5oRV9i805EeEMRdAb+7xmVB
	 4faMC9umuh6eSc9KPtO7zCUr9hOGXPnQHUdc0DQDMbRDOxk4tKcLtboAlgSL43UGJy
	 DLOFJcBdTRmtc7sjcbLfH9cuDkdz6Yz5i20Qc4r71XA8htOEpcS/7UANODsUydoypH
	 P7SWFWEm4kVLXdMGJYRk9/bm5PIrmIlbZy7uvch0N7xs/fIYPQBK/JuPvNKNEkMUyF
	 vLQLsFGjza47lSucx/cWzOKELJgL7X7aq2jNE3E+nvTU9SQGMMhvNujWj2zRYTrZJG
	 rzec96+/ZD/Ig==
From: Arnd Bergmann <arnd@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel@pengutronix.de,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: rockchip_canfd: avoids 64-bit division
Date: Mon,  9 Sep 2024 11:21:04 +0000
Message-Id: <20240909112119.249479-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new driver fails to build on some 32-bit configurations:

arm-linux-gnueabi-ld: drivers/net/can/rockchip/rockchip_canfd-timestamp.o: in function `rkcanfd_timestamp_init':
rockchip_canfd-timestamp.c:(.text+0x14a): undefined reference to `__aeabi_ldivmod'

Rework the delay calculation to only require a single 64-bit
division.

Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 81cccc5fd838..43d4b5721812 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,8 +71,8 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift) / 3;
-	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
+	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift);
+	priv->work_delay_jiffies = div_u64(work_delay_ns, 3u * NSEC_PER_SEC / HZ);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 
 	netdev_dbg(priv->ndev, "clock=%lu.%02luMHz bitrate=%lu.%02luMBit/s div=%u rate=%lu.%02luMHz mult=%u shift=%u delay=%lus\n",
-- 
2.39.2


