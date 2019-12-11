Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7711AD24
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfLKOQl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 09:16:41 -0500
Received: from first.geanix.com ([116.203.34.67]:60968 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKOQl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 09:16:41 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id CCBBE467;
        Wed, 11 Dec 2019 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576073771; bh=65ZLBsOy94T1lMy1uq4UWPshJZkQrX7oTEE4T6TUAME=;
        h=From:To:Cc:Subject:Date;
        b=PNdLnUJf8ztzbFQoJnued1/6imBXV+v7KjCZTgUJ78uqryqyMXCiXSxtQbZ9xXfnh
         DCVI38y97lVSvDqM3NvA7ExCSfJtXnIx39++o/LUEzNXNV9NEE0h0cF2aK060UfRCX
         8lHXdmENvaOBvBoPoHOsueGqddMNewJH9iHtxqlG9daeDv+/8cF4PZlnyY5rd8LIPS
         WvOUoRHTtdufRLvnrUDTpFza+rJbX0H+LJ6T4aoGlYnv6OScI/P/p/8ci+BGBfi81J
         58zQU6nYEOfC4x3jVMrMlzV1JwBPZqzEgOU8VF9lS5RMt2OzW0oxEa2rvxX0VJGOxH
         PhtOOWTXwTXcQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com,
        esben@geanix.com
Subject: [PATCH v2] can: tcan4x5x: remove redundant return statement
Date:   Wed, 11 Dec 2019 15:16:35 +0100
Message-Id: <20191211141635.322577-1-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 8ed2813f227e..0fd83045f371 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -327,12 +327,8 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
+	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
 				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
-
-	return ret;
 }
 
 static int tcan4x5x_init(struct m_can_classdev *cdev)
-- 
2.24.0

