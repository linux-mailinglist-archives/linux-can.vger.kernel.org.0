Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5314F5397
	for <lists+linux-can@lfdr.de>; Wed,  6 Apr 2022 06:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiDFDtt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Apr 2022 23:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573080AbiDERxa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Apr 2022 13:53:30 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECCBDE098
        for <linux-can@vger.kernel.org>; Tue,  5 Apr 2022 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649181088;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=puLez7TQYKOrkK2OoEMVI7H8q7SKXTqsmVL0/NYnldM=;
    b=aRkhbb7+9aruzrVFqUpJGysDEF0tUzVi5e2OOWDmAp1lDLyWtkPhU033hjoFexCFr+
    2y5GGC7Qc5StTvU6R7ucugxLs3+ijOqamhIQHDBr/RU9T4eD7b45XTTFNhHv8oQNl1Vo
    MdAEugtGJvKrtu5spfXwuAOeqpzch541jI/KOqOKIv9VVFnJ4eZptavy+JThgSxY6PxJ
    u39zogtsev7tLbZqDXk3xnoTKi/yEF6Q61BC6uXs4mPefzIIoU2xPALaVzL6Cbnd34K0
    44Sm/G7tGwlUQHLs+yPuAsnd5VWel4zzfXLATnTzwVAlDiuy/Ga0JeEdh/J5MtvKscCZ
    oETA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWNadSQUT9H"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y35HpSQz9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Apr 2022 19:51:28 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+2339c27f5c66c652843e@syzkaller.appspotmail.com
Subject: [PATCH] can: isotp: stop timeout monitoring when no first frame was sent
Date:   Tue,  5 Apr 2022 19:51:12 +0200
Message-Id: <20220405175112.2682-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The first attempt to fix a the 'impossible' WARN_ON_ONCE(1) in
isotp_tx_timer_handler() focussed on the identical CAN IDs created by
the syzbot reproducer and lead to upstream fix/commit 3ea566422cbd
("can: isotp: sanitize CAN ID checks in isotp_bind()"). But this did
not catch the root cause of the wrong tx.state in the tx_timer handler.

In the isotp 'first frame' case a timeout monitoring needs to be started
before the 'first frame' is send. But when this sending failed the timeout
monitoring for this specific frame has to be disabled too.

Otherwise the tx_timer is fired with the 'warn me' tx.state of ISOTP_IDLE.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: syzbot+2339c27f5c66c652843e@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index bafb0fb5f0e0..ff5d7870294e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -904,10 +904,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct sk_buff *skb;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
+	s64 hrtimer_sec = 0;
 	int off;
 	int err;
 
 	if (!so->bound)
 		return -EADDRNOTAVAIL;
@@ -1002,11 +1003,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		/* send first frame and wait for FC */
 
 		isotp_create_fframe(cf, so, ae);
 
 		/* start timeout for FC */
-		hrtimer_start(&so->txtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
+		hrtimer_sec = 1;
+		hrtimer_start(&so->txtimer, ktime_set(hrtimer_sec, 0),
+			      HRTIMER_MODE_REL_SOFT);
 	}
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
 
@@ -1015,10 +1018,15 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = can_send(skb, 1);
 	dev_put(dev);
 	if (err) {
 		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 			       __func__, ERR_PTR(err));
+
+		/* no transmission -> no timeout monitoring */
+		if (hrtimer_sec)
+			hrtimer_cancel(&so->txtimer);
+
 		goto err_out_drop;
 	}
 
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
-- 
2.30.2

