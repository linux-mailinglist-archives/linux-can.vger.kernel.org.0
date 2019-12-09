Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5F1168F6
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 10:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfLIJPF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 04:15:05 -0500
Received: from first.geanix.com ([116.203.34.67]:42746 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLIJPE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 04:15:04 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 69CDF407;
        Mon,  9 Dec 2019 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575882883; bh=dkT4RzL73L7OFKrEnCCykRy9G61/e1U5TpAvL/r0tKU=;
        h=From:To:Cc:Subject:Date;
        b=DF3C6Qgt1Vw1qLc1q9y8LenOsFLiFcndG/whgTbydD9JelNXq6kX2rEF3O4AoUQO9
         DMOAz4FXweOcBa4CQgAcWCxtY8bNUFWZEo7iYcqJAriLqEwjGiLrtHwNM+cub4UuHH
         tgJWxpmgtd/IX8hURbmGZLIiC8xBUWaxI0IxSmAoMf9CKKP/m1hI1i4EopJjMVC5Cd
         MCoTVIPuj+3IxJ5uDY7Fw6HpXPUf1dyQOhwUQ8DueWAlEFr5e96fs4cY3kDpo+4YwY
         9MG6KOHVN6fFVPoW918lvCcWQPiDzCdCqBwraj0gy+MVsWV4TqcQRXeqCuf36G/jYQ
         4fMQpsHnvqn1w==
From:   Sean Nyekjaer <sean@geanix.com>
To:     sriram.dash@samsung.com, pankj.sharma@samsung.com,
        mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com
Subject: [PATCH] can: m_can: remove double clearing of clock stop request bit
Date:   Mon,  9 Dec 2019 10:14:49 +0100
Message-Id: <20191209091449.909319-1-sean@geanix.com>
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

In m_can_config_endisable the CSA bit cleared 2 times while enabling
configuration mode.

According to the datasheet:
If a Read-Modify-Write operation is performed in Standby mode a
CSR = 1 will be read back but a 0 should be written to it.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
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

