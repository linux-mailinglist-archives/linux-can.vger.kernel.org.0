Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1727DC9AA
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjJaJbF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbjJaJbD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:31:03 -0400
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [81.169.146.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B1FDE;
        Tue, 31 Oct 2023 02:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744634; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WEtcoBxq607FNl7RXl7ybICm+I7J9vNC4D87MqspYXjhQQOQRztbNk6YWIRhP6/gDq
    FN/hXnL8k+/Xkr+CIpe+Bkz+F66b0fqZhqndIg96lAIk3TjKpJBW4uVPmHXpj2Lgmpbf
    vqcYqn0VCrVMoeOyYB9ZsfWJWPhJ3dS8qMbKdjZScMB2GFIUa4Oiq1LxzIDp6sCsmUoC
    ideM7/OBHVeYhCDthfC7aDgy+BmDWIdm86O/7mN5vBXLirMS0wFfAjoX9rFFgJuqsP5l
    WDu+X/knAbaExKQGQTJ7Ux3rVYTVr5hgIeJsC91ystOqOp6XAJ15dpzQhipT1iAhsU7s
    zNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744634;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xdObQ6rRlhqkD+wsQSFHGBaasDNQtFt5NFcRHBEmpSI=;
    b=coeS+hJVWLwvTt1KNMN5vYU553YOKyp7qu04smPnvvysXjfghk5OtTfebLBE4OgAYS
    uMi3lK5Oe+o1ps7xwq9ukE2A3s/iDhznbt6z7A5B0wROo2froKzd7fSEkM6kLri9iiZR
    gASl9X1gLDRC3CcqgyZchm2hG3GxOki+qnf02Ze73Yiy8c59BXRsQfvuwAuDITmI58d8
    BPVLblMKb5EEPbDdL6bnLgmnMe8CxejKuAcdozOW+P6gfSFehfXEdQMPuhqWNd/KtqQg
    TYG7jbQQwL3XFwquyFvKQZwG7benv1bzKfJs8VMyNB/AnuDUCvg4otkp3onfg5IYUqnB
    Vw0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744634;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xdObQ6rRlhqkD+wsQSFHGBaasDNQtFt5NFcRHBEmpSI=;
    b=QCLvKWPZUrO3c2Q7WuoAa1IVCoM9XWVaiYTjhtSFYRscX1L2zI029UKugE3JhFXvq+
    68mwK4VqwPNnU22gWsfoVly6rgLyeWYu72Cx9cSuc4bIppx1N5yFgnYAcsRUZUcVp338
    om3+P7kk6wk0cL2UjlSHjYVODirb8P0TVSly1dBZQLPmLOMRmKpiEgXfrgDkLx4Ddcod
    oH6zQdhlnwdk43ndV6QvvtXtbqXVry0g9DR0aWlHYThZxLPUBmZMG1ewHeIx8n7Dez7i
    IwyaH8fbLGNJObmBszW5PA6X8pgM0xhDqVvhWDdr4jD2+c5usZf3rJthUxsBtQGqM+4b
    sKYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744634;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xdObQ6rRlhqkD+wsQSFHGBaasDNQtFt5NFcRHBEmpSI=;
    b=OCP4GPaQh9FHXx/VR1d/YYIjcNjgaL6valXec3Y188GfFmew1YcZhfBSOHC3xraSrQ
    SCTG6FQK65WF/+jGQCBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9UYFhe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:30:34 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.15 7/7] can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
Date:   Tue, 31 Oct 2023 10:30:25 +0100
Message-Id: <20231031093025.2699-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031093025.2699-1-socketcan@hartkopp.net>
References: <20231031093025.2699-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 00cb38b4a6f4..7f62628c6ddd 100644
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

