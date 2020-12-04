Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316472CEEDA
	for <lists+linux-can@lfdr.de>; Fri,  4 Dec 2020 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgLDNf7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Dec 2020 08:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbgLDNf5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Dec 2020 08:35:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FEC061A52
        for <linux-can@vger.kernel.org>; Fri,  4 Dec 2020 05:35:16 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1klBEx-0004e2-EQ
        for linux-can@vger.kernel.org; Fri, 04 Dec 2020 14:35:15 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C76C55A43AD
        for <linux-can@vger.kernel.org>; Fri,  4 Dec 2020 13:35:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 833F15A4399;
        Fri,  4 Dec 2020 13:35:10 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d7bdb389;
        Fri, 4 Dec 2020 13:35:09 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Zhang Qilong <zhangqilong3@huawei.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 1/3] can: softing: softing_netdev_open(): fix error handling
Date:   Fri,  4 Dec 2020 14:35:06 +0100
Message-Id: <20201204133508.742120-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204133508.742120-1-mkl@pengutronix.de>
References: <20201204133508.742120-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

If softing_netdev_open() fails, we should call close_candev() to avoid
reference leak.

Fixes: 03fd3cf5a179d ("can: add driver for Softing card")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Link: https://lore.kernel.org/r/20201202151632.1343786-1-zhangqilong3@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/softing/softing_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 9d2faaa39ce4..c9ca8b9fceb9 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -382,8 +382,13 @@ static int softing_netdev_open(struct net_device *ndev)
 
 	/* check or determine and set bittime */
 	ret = open_candev(ndev);
-	if (!ret)
-		ret = softing_startstop(ndev, 1);
+	if (ret)
+		return ret;
+
+	ret = softing_startstop(ndev, 1);
+	if (ret < 0)
+		close_candev(ndev);
+
 	return ret;
 }
 

base-commit: bbe2ba04c5a92a49db8a42c850a5a2f6481e47eb
-- 
2.29.2


