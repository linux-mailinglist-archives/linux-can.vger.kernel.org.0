Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72B6D0C21
	for <lists+linux-can@lfdr.de>; Thu, 30 Mar 2023 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjC3RDM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Mar 2023 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjC3RDJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Mar 2023 13:03:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127B213C
        for <linux-can@vger.kernel.org>; Thu, 30 Mar 2023 10:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680195775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EZwFkqYw6UVslz7DiFo24Q79VTju0uogACAsWRw7/6W3kex35FqGjLl/to6Eh8Deja
    7toaVLSYNdRlH7drAQkLSj21dmsZliGkQTvP3d6D90o5hibhEdc4/qHqn06vev3kokP1
    5x5cRFYSElq8azKxBI+fi8hrQ3KC4H4Nnz4pg61QMDAWB8CyOZ2q04hSoXqn8r3ug3nE
    vmo5tM0nJTWL5gSbFiY5+tdq8WSjUjpRKt2e2m7Ht5PKK2L5UuPrsabMwFL+YEyX1FTL
    Dl6jPmmVccndIt6JiVcUOrmxSzgm6Q0WIDUTknwE7BwLPHhrxQljKCY8Z1KN1D8PrPVv
    mg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680195775;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PnrJ49A8P2QXYkF261xzJD2DOzYc2TPKoQ5uUNNMR1Y=;
    b=bVpfVbGP9bMBEDut55D5v8kWWsPc9ZyzhXhOGPFluUOJoIFG1bR3XjyC1Ga8DrqtD6
    OGPqCB5tW7L9dD0giyEv8gervY4d9zNDdWGkN7exqrBSJMrkYXPhjIcB78MLzMOW49Kl
    jR7EGy9PzIyqNCrtP4o+DxRkG2O3Yqperkv8T8zUTjJ2SYkuKB93FHrRuVtp6JiUe47c
    DT0ul1ky97Ru5gMqd5cnaxQ1YS5x/Ab/TA4Urr0WA8i47TwWu5peP9WNyeQ/C49jsL8s
    5D7gS86h2uoOPltfgu1D444I9Sa9+9GhnwKNjFLZ39G0bY/5KcLsocE4UEqayQpOSaQb
    u9WA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680195775;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PnrJ49A8P2QXYkF261xzJD2DOzYc2TPKoQ5uUNNMR1Y=;
    b=QjAzhQ8UabWdzZtUezwtJ6EyLaounS6pFES/RWLlzzOYAgDjh1sy957inREwf+X+od
    geMlM8TCatLwXqzbEaDCFkNSk6pFbPvCowuFIIbjOBfbHbKCq2bMYXrIF7fqhivzeCyY
    kzIA/9OeE+2gifuGQEuMWd7pN8PJv+U8GRzTXPPxQLpQJKXugL07LblJM1x8c3TqFXfk
    EMBPmYY0edsKGWitJjhcVekmGf/3ptk0Tn7jvYb42fgrQBlBBKa3U2tJAEPFovvaO5IK
    P74i2H0y2XqrXSfcIM0JfWTjuKMlPtwDoOGauhzCQVYAR2U3iMWG2t3uRusSwhIsjP1N
    JKJw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfh+rd"
Received: from silver.lan
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2UH2sgtL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 30 Mar 2023 19:02:54 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: isotp: use sock_recv_cmsgs() to get SOCK_RXQ_OVFL infos
Date:   Thu, 30 Mar 2023 19:02:48 +0200
Message-Id: <20230330170248.62342-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

isotp.c was still using sock_recv_timestamp() which does not provide
control messages to detect dropped PDUs in the receive path.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9bc344851704..47c2ebad10ed 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1118,11 +1118,11 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 
 	ret = memcpy_to_msg(msg, skb->data, size);
 	if (ret < 0)
 		goto out_err;
 
-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_cmsgs(msg, sk, skb);
 
 	if (msg->msg_name) {
 		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
 		msg->msg_namelen = ISOTP_MIN_NAMELEN;
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
-- 
2.30.2

