Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E69117732
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIUPp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:15:45 -0500
Received: from first.geanix.com ([116.203.34.67]:48892 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLIUPp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 15:15:45 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 42208451;
        Mon,  9 Dec 2019 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575922522; bh=8yiQkWpmX2p4bdPVGyfpRWoILGxZXOkUqL9+2QIEQeE=;
        h=From:To:Cc:Subject:Date;
        b=lT7VDc8LzCjUmGeQODrqdtW/FxVD9qfnIDDxaSHmOlS7ypvU2k7R2WIy7RO7TMxFm
         s+cCpdF4KafQ+xhqfCix4xPGZ+X3rtaRg3YTT0UCOI7/6oQSb0gMGqV6ci5OCgb+8f
         TJh64jlCeUMNQniIHuOpLK5MMqLROC2zLh9SbB5xi4Bbn/vsq08xnoptmZWHshm2j+
         c19LiSBX8vJhnCjFSwZWWF6cR/5EZdEnR6Bgd7BDQCk8LMvLCeZuoMrNkZ8Yxd4EYV
         aOTqns3Ab22QrQ2BV9mzEP89w8Wc21kFeEoxNbwTp64utTEOF78gEVkql/hIeTRYm6
         BF/BDO6p+gIqw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     sriram.dash@samsung.com, pankj.sharma@samsung.com,
        mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v3] can: m_can: remove double clearing of clock stop request bit
Date:   Mon,  9 Dec 2019 21:15:28 +0100
Message-Id: <20191209201528.999698-1-sean@geanix.com>
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

Removal of duplicate code

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Sriram Dash <sriram.dash@samsung.com>
---
Changes since v2:
 - Changed commit msg not to confuse :)

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

