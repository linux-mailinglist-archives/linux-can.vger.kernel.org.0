Return-Path: <linux-can+bounces-1489-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C379763F9
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9861228524C
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB469192B87;
	Thu, 12 Sep 2024 08:06:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4519049A
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128379; cv=none; b=LcRUPibHBW9fbDnCNXwG/9jI83MNMXHlFySKGeVoxl/cqu/HjzvcsywdGvUT1IJN17zUqGRr2XT8/Fgsse/Duf7muz/KcnGMfoSfw8np8ygMb3DubGOyR84YEzdBfuih8BxOuOhH/W1aRG1/C2NilyKce4W035dU9ct3ehBhaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128379; c=relaxed/simple;
	bh=4P1K442832dak6+Bgq7vXlyn6mx6zC0TKdd9/3nRDAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNwDJzagtekgIKm7Y3fKPy+kE7/JNHl8nEtuEjDz1uwFgF40y6v+okwE5kqHDnT4MNydkldjlo3TPR3u0jrgy5TsNdoKQi4G4B06p8/P/+ViBcqelsawEIhbTNLqsB7N8ff4k4ymjuCNak4JTb92hWiQpdhI772EEz3T29Bu5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq9-000499-NV
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-007KgY-0g
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5C56F338EDB
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:04:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E2367338EA2;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 60b262a0;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/5] can: rockchip_canfd: rkcanfd_timestamp_init(): rework delay calculation
Date: Thu, 12 Sep 2024 09:59:01 +0200
Message-ID: <20240912080438.2826895-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912080438.2826895-1-mkl@pengutronix.de>
References: <20240912080438.2826895-1-mkl@pengutronix.de>
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

From: Arnd Bergmann <arnd@arndb.de>

Rework the delay calculation to only require a single 64-bit division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[mkl: port to on-top of existing 32-bit division fix]
Link: https://patch.msgid.link/20240911-can-rockchip_canfd-fixes-v1-1-5ce385b5ab10@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index fb1a8f4e6217..43d4b5721812 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,8 +71,8 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = div_u64(clocksource_cyc2ns(max_cycles, cc->mult, cc->shift), 3);
-	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
+	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift);
+	priv->work_delay_jiffies = div_u64(work_delay_ns, 3u * NSEC_PER_SEC / HZ);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 
 	netdev_dbg(priv->ndev, "clock=%lu.%02luMHz bitrate=%lu.%02luMBit/s div=%u rate=%lu.%02luMHz mult=%u shift=%u delay=%lus\n",
-- 
2.45.2



