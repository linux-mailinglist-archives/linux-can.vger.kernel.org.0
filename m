Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC9789C95
	for <lists+linux-can@lfdr.de>; Sun, 27 Aug 2023 11:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjH0JXA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 27 Aug 2023 05:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjH0JW5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2023 05:22:57 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF52D107
        for <linux-can@vger.kernel.org>; Sun, 27 Aug 2023 02:22:51 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5F758240029
        for <linux-can@vger.kernel.org>; Sun, 27 Aug 2023 11:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1693128169; bh=aU7Lz8VSpXefwDcM1PXz2ijKmxeB6hpy1PBp+gbpQvo=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=B3sgS7dMT2+sTyNs3NgxpbEnogZbix3uQ/pinPmZiIjFiX/5rZkL2YSD1CfVukUAN
         6rpb4843eLKSfzJi1+0NA1BxE/F3tYmMCRRTuoXgRi9vSDC0NoIduSL/otQpPN1MFv
         E9x/nmH8TNbb/Kref0YdX2oQr5ThqXnTQ9BfyCxum/6Ubv+WduSOtHm5JfuwRiW6qx
         xL7tUVXolqF1lnVEz4M3Un8gtJ+NKo0njxLxGeWdvweSCVJK7dj1BKpDYk7uoR+QQq
         MD68kQ0JuTLFNfq/WH3imiTCzIxsRBH02Qcza6L5ugKkDAPaFGBOnLfH1E3+iegvwS
         5ijgGrY4sDYZg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RYSs13FGBz6vDN;
        Sun, 27 Aug 2023 11:22:45 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc:     linux-can@vger.kernel.org, Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v2] can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
Date:   Sun, 27 Aug 2023 09:22:05 +0000
Message-ID: <20230827092205.7908-1-lukas.magel@posteo.net>
In-Reply-To: <20230818114345.142983-1-lukas.magel@posteo.net>
References: <20230818114345.142983-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With patch [1], isotp_poll was updated to also queue the poller in the
so->wait queue, which is used for send state changes. Since the queue
now also contains polling tasks that are not interested in sending, the
queue fill state can no longer be used as an indication of send
readiness. As a consequence, nonblocking writes can lead to a race and
lock-up of the socket if there is a second task polling the socket in
parallel.

With this patch, isotp_sendmsg does not consult wq_has_sleepers but
instead tries to atomically set so->tx.state and waits on so->wait if it
is unable to do so. This behavior is in alignment with isotp_poll, which
also checks so->tx.state to determine send readiness.

V2:
- Revert direct exit to goto err_event_drop

[1] https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut.cz

Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Closes: https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824dfb041@munic.io/
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>

---

 net/can/isotp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 99770ed285..61caf48cf7 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -954,21 +954,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
-wait_free_buffer:
-	/* we do not support multiple buffers - for now */
-	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
-		return -EAGAIN;
+	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
+		/* we do not support multiple buffers - for now */
+		if (msg->msg_flags & MSG_DONTWAIT)
+			return -EAGAIN;
 
-	/* wait for complete transmission of current pdu */
-	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
-	if (err)
-		goto err_event_drop;
-
-	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
 		if (so->tx.state == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
-		goto wait_free_buffer;
+		/* wait for complete transmission of current pdu */
+		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		if (err)
+			goto err_event_drop;
 	}
 
 	/* PDU size > default => try max_pdu_size */
-- 
2.41.0

