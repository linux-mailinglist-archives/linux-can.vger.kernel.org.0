Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DD7E2525
	for <lists+linux-can@lfdr.de>; Mon,  6 Nov 2023 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjKFN2h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Nov 2023 08:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjKFN2g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2023 08:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D87107;
        Mon,  6 Nov 2023 05:28:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC529C433C8;
        Mon,  6 Nov 2023 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277313;
        bh=gD3nrT77EDN+SE6o+ELuhn8JxT8+1R359eaKWQLB7wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mk5fTPnRAtORGOfCiqpOZQIyGa52Q4NUI7PuB50Hn9eyqJ7v4KOmAVUDVQwKADumk
         PuZlNJmlOnq98nxBnCE2OnHdR5P8nPsY4bXUh5pkwSdFRboXi9YgnC/UgHBbq9YEf7
         aJSrOZcTadtAzxmPM9jYBmiVOJNeBj7gAmQacvwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz, Oliver Hartkopp" 
        <socketcan@hartkopp.net>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Lukas Magel <lukas.magel@posteo.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15 110/128] can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
Date:   Mon,  6 Nov 2023 14:04:30 +0100
Message-ID: <20231106130314.174525847@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

From: Lukas Magel <lukas.magel@posteo.net>

[ Upstream commit d9c2ba65e651467de739324d978b04ed8729f483 ]

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
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Fixes: 79e19fa79cb5 ("can: isotp: isotp_ops: fix poll() to not report false EPOLLOUT events")
Link: https://github.com/pylessard/python-udsoncan/issues/178#issuecomment-1743786590
Link: https://lore.kernel.org/all/20230827092205.7908-1-lukas.magel@posteo.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -925,21 +925,18 @@ static int isotp_sendmsg(struct socket *
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
 
 	if (!size || size > MAX_MSG_LENGTH) {


