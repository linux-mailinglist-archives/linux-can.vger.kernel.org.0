Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0103011ACDE
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfLKOEC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 09:04:02 -0500
Received: from first.geanix.com ([116.203.34.67]:60288 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfLKOEB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 09:04:01 -0500
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 60AA7490;
        Wed, 11 Dec 2019 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576073011; bh=mu00ivLCk4ZkEa4sx9AqXK90V3ztVOr4pFUkVSstv3U=;
        h=From:To:Cc:Subject:Date;
        b=KcVvLM4qiTLhs+OP2wC3UoQOKXxeRV1zemsrCWlms4ycxaKKPbH2G0lHbA55RBPt9
         Jj7zyVwSrNJTp58iVACF5Mfm1iEu/nu58igA3bjPMGmrYJ/LWsk7H1/ndm4yH7Lssg
         q/MnKcqA/P3CmkOrhYMETw/4ewFFcovW/93y/qkG4naz/THudjm6fps0YbQbQtMkLh
         RGwQOueAmb7Nexb8q9c1Ddum1wTa6P5mEDDsFuGJ7iBP/eWzIXPCIU4M1KFf0m1VoG
         p4uLrRnAa6RBWtrcx9dFhBHf9XUaNfCwq7fi7XHPf1AcW336OzXkBlGUmabzefvfkw
         BhZgbwh0vVC8A==
From:   Sean Nyekjaer <sean@geanix.com>
To:     mkl@pengutronix.de, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, martin@geanix.com,
        esben@geanix.com
Subject: [PATCH] can: tcan4x5x: remove redundant return statement
Date:   Wed, 11 Dec 2019 15:03:55 +0100
Message-Id: <20191211140355.321479-1-sean@geanix.com>
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
 drivers/net/can/m_can/tcan4x5x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 8ed2813f227e..9a33fcaaf067 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -329,8 +329,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 
 	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
 				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.24.0

