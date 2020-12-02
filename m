Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90182CC081
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 16:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLBPOC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 10:14:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8922 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgLBPOC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2020 10:14:02 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmMsc6tBgz725D;
        Wed,  2 Dec 2020 23:12:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Dec 2020
 23:13:13 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <linux-can@vger.kernel.org>
Subject: [PATCH] can: Fix error handling in softing_netdev_open
Date:   Wed, 2 Dec 2020 23:16:32 +0800
Message-ID: <20201202151632.1343786-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If softing_netdev_open failed, we should call
close_candev to avoid reference leak.

Fixes: 03fd3cf5a179d ("can: add driver for Softing card")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/net/can/softing/softing_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 03a68bb486fd..40070c930202 100644
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
 
-- 
2.25.4

