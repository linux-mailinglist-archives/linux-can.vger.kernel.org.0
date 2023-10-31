Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5F7DC986
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbjJaJaY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbjJaJaW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:22 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B15DA;
        Tue, 31 Oct 2023 02:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744598; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FzRkYUirqGaO1C4NygaInluxg+F2JCnAl56XhScwb3BcG88g+/dmppMFX7z0gX5SJU
    26SqPvcGvvKLlGVavBrD2R8FdCWDNoz9YkMyrrOmuAXtJ4BIRYIXpVMX9+Uf4Wf0P6uv
    JhCDdZmBqjtqatc/jLYzUtE20j7muHCiiMyLJNGHvMsOG7/GrO2+oAsdJVY9l8ZiUzpr
    okUesp3XCKPk6UmGSnyKJC2GAdF96i2ndPoDRyvkViMAWGQISpeiBs3BX+5ruWyYmEYO
    5Cf2hcNEb/KM0IVNg6QsHAlZ2cwtuj4MyBhiCFYG1+XdbTXssjVmXFLhLCOF3OaSn9Y0
    Nyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744598;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=030TI2FTmhttZO7MOklzZoQHhWilFAJBJVHJcoTc1vs=;
    b=mPFZkHx83PXWZIWYmsjzdkpP2etGezUfCOjK6/IGEEQawLaKR+I0C2INZ+IxGXvXI3
    5gCvBXAGPeiBomtkxNJdwALzRDgWCEt3s4iELVW6B2PpDJBZKZgU1U6elnBLKuYY1DZO
    5yhxtC1QIh2N7llv3Vlnm+Z8MHsN6GCJArtnnVGIvVe7SoFlOuGKXKkb2Kq7hXh+BqTZ
    5FdAEytOFKElAlaGwIzNRWMq8PMMx2FiXt56thqxTqIW85O0T3bAqctIOZ5CGttwclYb
    4U7j7vcHBjfVyTaKElHV6MA1oVVA1zlp1OuCONbnqfu4/gjkiiJAeQLU7eQ+ZRdYBqtz
    wh/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744598;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=030TI2FTmhttZO7MOklzZoQHhWilFAJBJVHJcoTc1vs=;
    b=EUXWZ+M7C9nKQJ8B6lST6aDpo6YSgqQmByEgyf3bfquZPYAKfTtAKsY1qbQzhvtDZP
    KKFVG5YOnim+rvV4NUXC8coAao4uUk9KCljOSNbtBoPIrWGEKMTQ9+XaeKDin/xeTi1n
    OPI1cYgXM/xsJ4FSjtZ1zz+2GCeNCOA82vSeYMAurusvGQMREhQ+5mSuvhklTNRL61l4
    MQYsnBAX4V6MMRO8EU8kg+KYbm3IYYoXXQpdSGPomB+AUTxkNT9nXeKsZsxHiY3bPVBq
    42PB+1eDHt1zPEMghkoCIO3EkecPWxg8d0VO/bwv/0lVMu4kLv6qlwaR4N654229vl7n
    U65g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744598;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=030TI2FTmhttZO7MOklzZoQHhWilFAJBJVHJcoTc1vs=;
    b=R+B+eBrPKfLyWLu2KXe4fVnyIFK4pTu8Hccftu7jx2px7WA2rFeo+2Wy1TYIB9KtrI
    58HgfUtN5k0ZwjJvJWDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TwFhN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:58 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.10 10/10] can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
Date:   Tue, 31 Oct 2023 10:29:18 +0100
Message-Id: <20231031092918.2668-11-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031092918.2668-1-socketcan@hartkopp.net>
References: <20231031092918.2668-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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
---
 net/can/isotp.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 08dfa34d68d5..c646fef8f3ba 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -923,25 +923,22 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	int err;
 
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
 		err = -EINVAL;
 		goto err_out_drop;
-- 
2.34.1

