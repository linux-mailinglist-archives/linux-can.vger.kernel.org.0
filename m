Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5936BEDD
	for <lists+linux-can@lfdr.de>; Tue, 27 Apr 2021 07:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhD0FWm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Apr 2021 01:22:42 -0400
Received: from mout02.posteo.de ([185.67.36.66]:55243 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhD0FWg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 27 Apr 2021 01:22:36 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 150CB2400FD
        for <linux-can@vger.kernel.org>; Tue, 27 Apr 2021 07:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1619500913; bh=8NbX+gqxbeCIGv7VCqrOFR0diq4cOe6r5151fpv3NGw=;
        h=From:To:Subject:Date:From;
        b=FQIbgFv/VNB0Gem5XxlbQyznhnupJ5TLX0Nvf43MLUNX7XaLD+ta+CVXojjfI+tAp
         hz1fV1TiKWX/lWA1ybUuo/TcVM0eovgbUHQ4Q1pwMXZHIAe+311DIbsPw1cenzkHUl
         KekaIBajGPUx6q6po6Guw6egba3rCUf+QXcHATS2RvSV2F07riZ1PwiGScGnxQuo4P
         J08xc/im5jDGuNzac1/9l+X9X7ZKnkONntNqAoI0rDGPI1dg6gE/41CrjtjzajpyHF
         Zayv2xum91aIYUgos9x0adlxfYmquTICulayJXrG6ez9RalbjbalferNbxjaQ3njss
         CsfxXW32ZemRw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FTqrJ1nMmz9rxG;
        Tue, 27 Apr 2021 07:21:52 +0200 (CEST)
From:   Patrick Menschel <menschel.p@posteo.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] can-isotp: Add symbolic error message to isotp_module_init()
Date:   Tue, 27 Apr 2021 05:21:48 +0000
Message-Id: <20210427052150.2308-3-menschel.p@posteo.de>
In-Reply-To: <20210427052150.2308-1-menschel.p@posteo.de>
References: <20210427052150.2308-1-menschel.p@posteo.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds the value of err with format %pe
to the already existing error message.

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 2c4f84fac..2075d8d9e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1433,7 +1433,7 @@ static __init int isotp_module_init(void)
 
 	err = can_proto_register(&isotp_can_proto);
 	if (err < 0)
-		pr_err("can: registration of isotp protocol failed\n");
+		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
 
 	return err;
 }
-- 
2.17.1

