Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E51175DA
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLITaA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 14:30:00 -0500
Received: from first.geanix.com ([116.203.34.67]:44464 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLIT37 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 14:29:59 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 38F83406;
        Mon,  9 Dec 2019 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575919777; bh=sRQSN5mNkMyQPICJpBmI7K06zjXe8V0ws1KCQs7Mz/8=;
        h=From:To:Cc:Subject:Date;
        b=AMp46wk1EkKy7NbscP228kR5qC2zKws5RYrayNE+ooImiqu+wrifN/EVy4Pd5oFYw
         MRyR0qodpGFQDT1Ra35MG6ggw0pzqK+/Obqbp+9E+3aqQwdkSEnXMtAe4gTy3ak6pm
         xoRACkdCROjtNAG9rwbNbC+aio/PEfGwZCBO4xbJs3yOgvrfrOSC4bjPg0GY+vf4q4
         0aYSJNx9Xq2nTd+7D6kj9nkdD6K3pl9HLLPFeAnFRxNltso8nCoiCo5KpwqJh7NFgg
         GG/pWq6eGbdmtcy+2ECcjD7jlO0M8mCnn5/WlTyiFlqOCdRJTplRCpaA8VneDmy7W2
         n8yaQM6tOSP/Q==
From:   Sean Nyekjaer <sean@geanix.com>
To:     sriram.dash@samsung.com, pankj.sharma@samsung.com,
        mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH v2] can: m_can: remove double clearing of clock stop request bit
Date:   Mon,  9 Dec 2019 20:29:49 +0100
Message-Id: <20191209192949.998976-1-sean@geanix.com>
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

In m_can_config_endisable the CSR bit cleared 2 times while enabling
configuration mode.
The CSR should always be cleared when writing to the CCCR register.

According to the datasheet:
If a Read-Modify-Write operation is performed in Standby mode a
CSR = 1 will be read back but a 0 should be written to it.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Acked-by: Sriram Dash <sriram.dash@samsung.com>
---
Changes since v1:
 - Changed CSA -> CSR bit in the commit msg

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

