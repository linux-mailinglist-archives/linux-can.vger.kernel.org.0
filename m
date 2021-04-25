Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA936A7E6
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhDYPLL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 11:11:11 -0400
Received: from mout02.posteo.de ([185.67.36.66]:43155 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhDYPLL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 25 Apr 2021 11:11:11 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 406F62400FC
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 17:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1619363429; bh=Z9soVQG98yv4Sne1cc+vGVqI7CCnMtVZOoPMJQfSt98=;
        h=From:To:Subject:Date:From;
        b=LQbuzjKLUehHIZ5e12INIDALMngukkByy4uy1LNQjuQu4bRNa7xq+xXnKTTgRxI/A
         1SuKoHSHbpdMZ4ecAzlWobw0GCU5xvhJTWO/qCVGWVc1PJgPejts9ThjcMZzHlAgEH
         T39XgikB+1qpMizWDnU+q2FTzrboFDz5fmnsfJzR5aUGdiz+8vc9rBV6dMWooOXVhi
         ZLN3T8AZKPUA3lRKZrIglyD+2bK3zccu0JbCmtRHNiWI7OuyO4et3CUstb12s/ht/y
         0qTe6jC95IAXO9LTk1Q86/KcY2tRVsIAGIxVRdBqjXUeAGWHXAoX5SXHRS5Ggxr0Ne
         2X3/+zhuE9FKw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FSs0N5HQzz6tmJ
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 17:10:28 +0200 (CEST)
From:   Patrick Menschel <menschel.p@posteo.de>
To:     linux-can@vger.kernel.org
Subject: [PATCH] can-isotp: Add error message if txqueuelen is too small.
Date:   Sun, 25 Apr 2021 15:10:28 +0000
Message-Id: <20210425151028.8238-1-menschel.p@posteo.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds a comprehensive error message in
case that txqueuelen is too small and the isotp
driver encounters ENOBUFS (105), e.g.
"no buffer space available" while it does
enqueue its generated frames.

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 net/can/isotp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9f94ad3ca..c50e238b0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -946,8 +946,17 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = can_send(skb, 1);
 	dev_put(dev);
 	if (err) {
-		pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-			       __func__, err);
+		if (err == -ENOBUFS) {
+			/* if txqueuelen is not of sufficient length
+			 * for this transfer
+			 */
+			pr_notice_once("can-isotp: %s: can_send_ret %d : No buffer space available in tx queue\n",
+				       __func__, err);
+		} else {
+			/* general error */
+			pr_notice_once("can-isotp: %s: can_send_ret %d\n",
+				       __func__, err);
+		}
 		return err;
 	}
 
-- 
2.17.1

