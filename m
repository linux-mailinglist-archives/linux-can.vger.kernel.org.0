Return-Path: <linux-can+bounces-1434-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93849970DF3
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5354D281AD7
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 06:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50991AD3F4;
	Mon,  9 Sep 2024 06:37:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A51AC8A5
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863825; cv=none; b=tpkolHUtSIHNdyCkes1bhknJunE/b5EQIhG3Wz6NyDbEktp3ING3sV+0xvJdQ+YoSBcSf++jd2ZuYBJlusbBAQkiUCj68JAH7hhoMXVv4N9ICSifefVBfrqfgb2F49esI7GQCLkg+71+TrmjiW6I3QkUStS2ZhXnLVhjnhLAF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863825; c=relaxed/simple;
	bh=z3+Ly/FjeievgkLB7Q6V0xxEhP/+DbAG30rRW69OnMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLxwrElTBqK+EPusXRe0A7+f9j06lbePrgp4cnrE0LiZEslVbYt2O8Mp9n6dhSIfSBl7yx/HTpaHqIRD8tSzSDUhu7nANTza2xL0BlUdPhArhkCKVkqHITAfPMtaFv+Kb3hg43HWBR6Zr8z3xlwkD8MttNERsxoa9iNwRKGdbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1G-0005wd-DN
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:02 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1F-006aXN-Sq
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9416D336452
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 06:37:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 34DDD33643C;
	Mon, 09 Sep 2024 06:37:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 09d1cf27;
	Mon, 9 Sep 2024 06:36:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net-next 3/3] can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64 bit division on 32 bit platforms
Date: Mon,  9 Sep 2024 08:33:55 +0200
Message-ID: <20240909063657.2287493-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909063657.2287493-1-mkl@pengutronix.de>
References: <20240909063657.2287493-1-mkl@pengutronix.de>
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

On some 32-bit platforms (at least on parisc), the compiler generates
a call to __divdi3() from the u32 by 3 division in
rkcanfd_timestamp_init(), which results in the following linker
error:

| ERROR: modpost: "__divdi3" [drivers/net/can/rockchip/rockchip_canfd.ko] undefined!

As this code doesn't run in the hot path, a 64 bit by 32 bit division
is OK, even on 32 bit platforms. Use an explicit call to div_u64() to
fix linking.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409072304.lCQWyNLU-lkp@intel.com/
Link: https://patch.msgid.link/20240909-can-rockchip_canfd-fix-64-bit-division-v1-1-2748d9422b00@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 81cccc5fd838..fb1a8f4e6217 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,7 +71,7 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift) / 3;
+	work_delay_ns = div_u64(clocksource_cyc2ns(max_cycles, cc->mult, cc->shift), 3);
 	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 
-- 
2.45.2



