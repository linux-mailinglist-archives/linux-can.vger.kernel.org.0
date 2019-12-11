Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C211A488
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 07:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfLKGcj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 01:32:39 -0500
Received: from first.geanix.com ([116.203.34.67]:39796 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKGcj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 01:32:39 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id CAEEE449;
        Wed, 11 Dec 2019 06:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576045926; bh=01E4TfS2Ehv0T/CR8VkBXnGoy5zjYv92zNbThK0C1qk=;
        h=From:To:Cc:Subject:Date;
        b=fbejObPtl4C5YXqNyKvPXwaTJufv6luLHi1pxRiWpoHSHFsn8CosZ2Im9ycA8mD7z
         2Ehxv5nEOsyAt6abJm1Nit1HdpKrNtraqkNHfDdHoR4j46+xgwl6J2lh5i4Bnvw2V3
         PIaVnQy9ZyEckMb3LY9EO4Da3LN3eMl2l2fpN3j0xvLaR4j+1+ZOj9nUHfKvXyfiPr
         Lp/SEjlLtfoPVqFV6DhOOm5nXTECxR6/yhko0e6IhEkr6ZN9ulflYJ3cP6ssBGeLKN
         sjD4rcQYhD1NbCps8EOOLQGe4p2lqQE2CKKbFYZrSXnLwwbo1Rcbxg0XW37Dxa1JGH
         WamaQ4XJfRj3A==
From:   Sean Nyekjaer <sean@geanix.com>
To:     sriram.dash@samsung.com, pankj.sharma@samsung.com,
        mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v4] can: m_can: remove double clearing of clock stop request bit
Date:   Wed, 11 Dec 2019 07:32:27 +0100
Message-Id: <20191211063227.84259-1-sean@geanix.com>
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

The CSR bit is already cleared when arriving here so remove this section of
duplicate code.
The registers set in m_can_config_endisable() is set to same exact
values as before this patch.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Sriram Dash <sriram.dash@samsung.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
---
Changes since v3:
 - The commit msg got longer :)

 drivers/net/can/m_can/m_can.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..4edc6f6e5165 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -380,10 +380,6 @@ void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 		cccr &= ~CCCR_CSR;
 
 	if (enable) {
-		/* Clear the Clock stop request if it was set */
-		if (cccr & CCCR_CSR)
-			cccr &= ~CCCR_CSR;
-
 		/* enable m_can configuration */
 		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
 		udelay(5);
-- 
2.24.0

