Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037A311AC7E
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKNxv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 08:53:51 -0500
Received: from first.geanix.com ([116.203.34.67]:59724 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKNxv (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 08:53:51 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 7E771492;
        Wed, 11 Dec 2019 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576072398; bh=x37RrImUycmmLa+gn+Tnt5kcAwZNg5NLbu1avv6oeOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fU9W3Hwkf8BfQx6LIxoU0+7GMQr5TaJ/7ff+yFkY16fex62AYzGBetghf/h1EfgKC
         YXbcjnlnwVV9tD5CA8QJXF9QIFo/FUrPB/80TkJmYVQIk8qK4QoaX0RYcutVcSI5FN
         d04sczg0mCn8yAREK3mlCM+Sz5kksfKgCr66SfW5j1tA8ADeBT7LfCI2T+TK83f+xb
         X5VHxwUd9Xl9eQ6jbQXLpy9Xd44P2t3tiWj9bKunOSsRYt+fMziFco8S9n7VW3Cw2J
         ZQaydVQPgk9xoDyTQlJiQ+pooxs8IVZuKmcjm+z97tKSJIag192h8mj0K1S+D4N99/
         MrdKbt6PWw0/Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>
Subject: [PATCH v6 2/2] can: m_can: remove double clearing of clock stop request bit
Date:   Wed, 11 Dec 2019 14:53:40 +0100
Message-Id: <20191211135340.320004-2-sean@geanix.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211135340.320004-1-sean@geanix.com>
References: <20191211135340.320004-1-sean@geanix.com>
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
 - Fixed fixes tag

Changes since v4:
 - None

Changes since v5:
 - None

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

