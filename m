Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08ED50B2D0
	for <lists+linux-can@lfdr.de>; Fri, 22 Apr 2022 10:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiDVI0s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Apr 2022 04:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiDVI0s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Apr 2022 04:26:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E252E62
        for <linux-can@vger.kernel.org>; Fri, 22 Apr 2022 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1650615833;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aaTYFrs40ucoG/AdOlb2vvxFZY62Sm7sFiGuOeQ1IFc=;
    b=N0SHLtdQm4427YM0eP3ulc2Hklpgc/AmIhRa0del3pWGeobo2jiuqjMO9iPvoN3V9d
    GVqPPStJqyRU0QnwlXedXaiR2L17cAK10ebgPymilFlJ2zsz8Qh5KbzoqQ7ZFWOnne2B
    p7JawUFouc+6sRhvjCZY1r14QmSlmLVWS5vpWsL41YrJT1V8VSPY6yRMEiC333C/40Fo
    npATh2XYYJABowwdRj5bWmYuxk4dhWfjBp4HLLJD8EjkqYx5Dc9YCf8WWjuhfa8nlthV
    pDoqkzzVoBQm3qL7Clammu9nrghqJvf3aJArFoT5ZU6FbdQ1++OCiK6Pb6etqZz3Sn3E
    MbgQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JCKNKiWJaRDy1ex1"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y3M8Nr8KP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Apr 2022 10:23:53 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: isotp: remove re-binding of bound socket
Date:   Fri, 22 Apr 2022 10:23:37 +0200
Message-Id: <20220422082337.1676-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

As a carry over from the CAN_RAW socket (which allows to change the CAN
interface while mantaining the filter setup) the re-binding of the
CAN_ISOTP socket needs to take care about CAN ID address information and
subscriptions. It turned out that this feature is so limited (e.g. the
sockopts remain fix) that it finally has never been needed/used.

In opposite to the stateless CAN_RAW socket the switching of the CAN ID
subscriptions might additionally lead to an interrupted ongoing PDU
reception. So better remove this unneeded complexity.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index ff5d7870294e..1e7c6a460ef9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1187,24 +1187,25 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
 
+	if (so->bound) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	/* do not register frame reception for functional addressing */
 	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
 		do_rx_reg = 0;
 
 	/* do not validate rx address for functional addressing */
 	if (do_rx_reg && rx_id == tx_id) {
 		err = -EADDRNOTAVAIL;
 		goto out;
 	}
 
-	if (so->bound && addr->can_ifindex == so->ifindex &&
-	    rx_id == so->rxid && tx_id == so->txid)
-		goto out;
-
 	dev = dev_get_by_index(net, addr->can_ifindex);
 	if (!dev) {
 		err = -ENODEV;
 		goto out;
 	}
@@ -1235,26 +1236,10 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 				isotp_rcv_echo, sk, "isotpe", sk);
 	}
 
 	dev_put(dev);
 
-	if (so->bound && do_rx_reg) {
-		/* unregister old filter */
-		if (so->ifindex) {
-			dev = dev_get_by_index(net, so->ifindex);
-			if (dev) {
-				can_rx_unregister(net, dev, so->rxid,
-						  SINGLE_MASK(so->rxid),
-						  isotp_rcv, sk);
-				can_rx_unregister(net, dev, so->txid,
-						  SINGLE_MASK(so->txid),
-						  isotp_rcv_echo, sk);
-				dev_put(dev);
-			}
-		}
-	}
-
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
 	so->bound = 1;
-- 
2.30.2

