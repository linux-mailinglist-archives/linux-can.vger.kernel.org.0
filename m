Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4667AA23
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 06:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjAYFyh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 00:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAYFyg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 00:54:36 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B329E37
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 21:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674626064; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gu0gypew9JtcYTFNdEFJ4ISMHmwtYGurxmGesVd/0r9NdvwiIdaeYYOm+5o8EGCUkj
    /J+RTco56DrttBu0Oud/nWSOo4pELZ89QVQschgv53POiM6tWuHaWXqwbG0t0x8jZQ7C
    1B7xrllIfkybIqzix5mBkMUFKBoFJxf9x+xldOEa8lCBMZbl5EgcbtoK7w0CXkVmiSJJ
    Ri/5bSfFprOssF40ooHfvdnl59R1oPmlefaw7UrZ+X8zXjYVpcx4bDjmg2s4POgpO1cv
    PCeMuXzzszDIjr7zs6/Ov+189IXsRnPQA4I8Dh3JU81c1c5+vrABjGHzsg5c4VJ5b9J2
    OxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674626064;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Et0mnbI89EmDl8itcZMjqeK6atZVnsIj3PkuzT9n/kU=;
    b=Yuuxqdkq40DTK+Zo3iyLp76DKaXQDa9nDyQ7c2vcf+zr+VhtNVOBbMuUflYcWFzbAj
    N22FhRmjzLK1bqKwo4H7PXLO4u7yOKYlyVxxfbdr4WIT6Zk8DuatlnwD1SV/8CrGGy8q
    6ciOwTHNzqrwkbm/xbrB7V2z3lB5kY+MCsli0RymrD/9y4vYQ5JvGcJLibeOR8gZYe8Y
    Ej3eU7ziEhsxU8nQqKCW2bkSRx6rdFWyTDKp4gjzgjJ1VPK0oCR3z2YsuzTsXK2cX3Yz
    JSn26Mpu7vKMOgoBEdfU/hsVN5WXrh2Aaa1W25c8OH3VsgH31pQ/q3Lymocy12zjIsIa
    w1gg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674626064;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Et0mnbI89EmDl8itcZMjqeK6atZVnsIj3PkuzT9n/kU=;
    b=maroxMdnCFntV64aJq/0Ne7X7ljHfXPkDpX+YWlWrUGakeFAShK9Uh3phO8X6wh5W2
    nIZtzZNEnrEKlrqOLeTVQvciTSJXWVVmHGDcMuMEEHOnrCXy4BqQPUIXh/9w/EiWxHUV
    8zHZWuWDr0CRTFWngUQQ1j6hawGtZDkL1Cd5zuHpU0XICZupLDMH+Wrh91jtgurtS3If
    O15t9BhDkYq5oyQ0SPO8NF55FqOxlO80ZoNXJNXfMo3hdbH3K81v2ObLacN0HLYyK0Qr
    Bp/0TxFp6P9QTH8YFQe3zE2VbNKhVG0mRw6aPJKASk0pU0PgN/Yk7oTk1XBArAAwILP2
    U6KQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.2.2 AUTH)
    with ESMTPSA id qa71b9z0P5sN2o6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 25 Jan 2023 06:54:23 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jannik Hartung <jannik.hartung@tu-bs.de>
Subject: [PATCH can-next] can: gw: give feedback on missing CGW_FLAGS_CAN_IIF_TX_OK flag
Date:   Wed, 25 Jan 2023 06:54:07 +0100
Message-Id: <20230125055407.2053-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

To send CAN traffic back to the incoming interface a special flag has to
be set. When creating a routing job for identical interfaces without this
flag the rule is created but has no effect.

This patch adds an error return value in the case that the CAN interfaces
are identical but the CGW_FLAGS_CAN_IIF_TX_OK flag was not set.

Reported-by: Jannik Hartung <jannik.hartung@tu-bs.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/can/gw.c b/net/can/gw.c
index 23a3d89cad81..37528826935e 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1137,10 +1137,17 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 		goto out;
 
 	if (gwj->dst.dev->type != ARPHRD_CAN)
 		goto out;
 
+	/* is sending the skb back to the incoming interface intended? */
+	if (gwj->src.dev == gwj->dst.dev &&
+	    !(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	ASSERT_RTNL();
 
 	err = cgw_register_filter(net, gwj);
 	if (!err)
 		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
-- 
2.30.2

