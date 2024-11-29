Return-Path: <linux-can+bounces-2261-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAB9DE662
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07419B2324C
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319419DF4F;
	Fri, 29 Nov 2024 12:27:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36719D065
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883257; cv=none; b=GkOCLFmZmq7OsiFe52TuM/JD26xFwY24DahZVY+d9IbkF6kbBOOAQPq8hOQCL2rKFJgOOv97PcYx2PyAvmP0HkCW+rWVtNHTH36YVT0oPhvb/bZtB/hZVR8b02Ol1o0tmJLcxpgbAlrVo89fIagyLM3J2mpE9U2OFpFQEtOjJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883257; c=relaxed/simple;
	bh=r5PlcXUYBo+yvNKc0PBkrA67Y3wssAcxdPfyy7DF4Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJPuybYGU8PP1spy0iRxfVZ2pYxNkGK6fKN9kPot5SPpb/gLfUj3HXsQxk3KH4tmSDQS1czZlQJNcLfAmLElfzfUJkn8/LEK1ffAuGy9Jfw4qJpdMBUoaVJ6xoLt3yrLhvD5+c/Z8fvZdRziylFFgffjbjzLYubCUXLp31U0Vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05t-0007mW-1M
	for linux-can@vger.kernel.org; Fri, 29 Nov 2024 13:27:33 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05r-000mhN-1t
	for linux-can@vger.kernel.org;
	Fri, 29 Nov 2024 13:27:32 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0DE4C381137
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EF52F381102;
	Fri, 29 Nov 2024 12:27:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a2bd01f;
	Fri, 29 Nov 2024 12:27:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH net 01/14] can: dev: can_set_termination(): allow sleeping GPIOs
Date: Fri, 29 Nov 2024 13:16:48 +0100
Message-ID: <20241129122722.1046050-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129122722.1046050-1-mkl@pengutronix.de>
References: <20241129122722.1046050-1-mkl@pengutronix.de>
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

In commit 6e86a1543c37 ("can: dev: provide optional GPIO based
termination support") GPIO based termination support was added.

For no particular reason that patch uses gpiod_set_value() to set the
GPIO. This leads to the following warning, if the systems uses a
sleeping GPIO, i.e. behind an I2C port expander:

| WARNING: CPU: 0 PID: 379 at /drivers/gpio/gpiolib.c:3496 gpiod_set_value+0x50/0x6c
| CPU: 0 UID: 0 PID: 379 Comm: ip Not tainted 6.11.0-20241016-1 #1 823affae360cc91126e4d316d7a614a8bf86236c

Replace gpiod_set_value() by gpiod_set_value_cansleep() to allow the
use of sleeping GPIOs.

Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: stable@vger.kernel.org
Reported-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Tested-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Fixes: 6e86a1543c37 ("can: dev: provide optional GPIO based termination support")
Link: https://patch.msgid.link/20241121-dev-fix-can_set_termination-v1-1-41fa6e29216d@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb..681643ab3780 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -468,7 +468,7 @@ static int can_set_termination(struct net_device *ndev, u16 term)
 	else
 		set = 0;
 
-	gpiod_set_value(priv->termination_gpio, set);
+	gpiod_set_value_cansleep(priv->termination_gpio, set);
 
 	return 0;
 }

base-commit: 9bb88c659673003453fd42e0ddf95c9628409094
-- 
2.45.2



