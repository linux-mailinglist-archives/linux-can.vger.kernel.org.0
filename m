Return-Path: <linux-can+bounces-5018-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4EB9F246
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E34E4BAF
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED32FFFB9;
	Thu, 25 Sep 2025 12:14:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C42FD7D6
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802448; cv=none; b=iWClNW8klnrGoxH1c6Pc7dSNN5chVBr9XzIjjWgstk/mgFCfhM49xFAjmspH1wQemaQu9lqBRkkMwnA3b9bob0eyyz+zF/V64iZOndBHwqHwMkkZHRz9rJi7QDg6HoUIc6LBY3zIdr5cgpiw+o2JcMBS20rsvHUQBhIL0R+ZbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802448; c=relaxed/simple;
	bh=cFLbESbAIn/mr9J6GG4FjnQgFD5qgg6MmivH5+SLSRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbUvvZKuit5g79ZZyoAF7gpVcU91KJDy/IFJEof9dvCdx8p5+Iau27G05wXk+bwsqvy/m1gnlEMFUcwTPxnZwF04P83fj/4FjLmR+CZSDN/opYU5PbpLJetPvpZ/yd0HYrrGQGP4BxtMmW8BD46FJYA1sxfaM4TdFUkYKV7hR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vf-BO; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000PvA-16;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 047CE47996F;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/48] can: dev: sort includes by alphabetical order
Date: Thu, 25 Sep 2025 14:07:40 +0200
Message-ID: <20250925121332.848157-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

Includes are out of order in

  drivers/net/can/dev/dev.c

Sort them by alphabetical order.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250830152107.694201-2-mailhol@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3913971125de..99b78cbb2252 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -4,17 +4,17 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/workqueue.h>
 #include <linux/can.h>
 #include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/gpio/consumer.h>
+#include <linux/if_arp.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
 
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
-- 
2.51.0


