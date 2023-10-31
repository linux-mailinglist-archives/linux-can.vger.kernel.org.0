Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE377DC983
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJaJaW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbjJaJaU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:20 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DF8C1;
        Tue, 31 Oct 2023 02:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744595; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Oi3lRsfP339z7GzySLlcFWCElboDJPhaCBdy8pUFQiq4IqHcV0a9qcdiv53458sLnp
    cjHW63pHjorWEjJvgZafaUqwXwNceF9FiMoIEQ0b0bbAssBHRLDAXpywJ5J0dBJGgwBm
    jBhV1anQyE4OTFo+DLFYzI1eOOJgZDlRLO3SRx0dArfgfwc21Cqvn/BDPT/jM4yG8wB8
    n/PHh+nYo9ciNqzSvCrc9z4RQkSh3UTAaxNTn2Y9qc9c0yTBKY89nS5JqRoJzzc6FH/Q
    wrbjg6GyDqhdPVL+H0Y4K0DsAQmYDcX0IIiZvomuk2ckn1slPpCYHl7G5m4Qwr1TAUwq
    c8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744595;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kCiPsmHP7A+8+OSHVc4VVcQK0OfGm/StDJ6OGxer1S0=;
    b=BBBwb/wUOoyvriS6qDFDbI8NfOqCNvw6KJrJAtXA1Yhg4sSUwM49pp1TMIk33+rWQz
    Y+GQEU1ZJ8GL7k403DplVwLAii8BJRVb7lmDjkpv5nFjez2WGoskxs7Doy3xFyN8oME3
    XeVOgRnZlpQOaRMN66iflX9SVKHvBXbOY7o+r9rHIluB4lBTeQ6ylYCHevoLtJ4jEByV
    N706ihBBJB80TxCSfmJUJMugNvG8vBM7bXdclaR1/kNj4JnK0vpoEq/SUme3lTIjKK3+
    bQTXkY2zFpNRXNiw7YxVhS5UBYOtwCZbP/SNPXqJXzygCg9ZesKH66coYInh+vYTghFf
    +1NQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744595;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kCiPsmHP7A+8+OSHVc4VVcQK0OfGm/StDJ6OGxer1S0=;
    b=YN+exxeaBMFYyaCiIHQukjkmMzRVYMvc7swu5VIbZd2g5uiApPY/4KHBr+IyDVATTm
    n4bT3jS0emwlppbvig7D0S1mtC/CpnoV5W4JJnm9eYRAiHxScmCwwOAW1MKYUSENguWT
    77Ohf4hA6Wra9SjJYoJW/+vAR0MvbRw2WRD6vd8w/Vkgv+X3665jwAXCEzm2jG5JlIsJ
    6Bv/enUrxESJBUBfs2pfvjpU5JNNcaDdlbV8k3O9l3mTkjKWIb9ePMyioQ9JoTbEglWr
    y7Z4kd89zTIevOxCLIL3Hq7NqpATsOGFgxBUPaorfwRZcOZLrPoyxb+Zm3zc2pFuycJn
    Im5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744595;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kCiPsmHP7A+8+OSHVc4VVcQK0OfGm/StDJ6OGxer1S0=;
    b=P65ZEk70H9dcYD0pqpZfhDUGEjoOEi42dMTvS8RGAlY4fpP3oiGgxqQCFYDoU5JD1B
    xnTRiIekbzK2JdsD66BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TtFhE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:55 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.10 03/10] can: isotp: Add error message if txqueuelen is too small
Date:   Tue, 31 Oct 2023 10:29:11 +0100
Message-Id: <20231031092918.2668-4-socketcan@hartkopp.net>
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

From: Patrick Menschel <menschel.p@posteo.de>

commit c69d190f7bb9a03cf5237d45a457993730d01605 upstream

This patch adds an additional error message in case that txqueuelen is
set too small and advices the user to increase txqueuelen.

This is likely to happen even with small transfers if txqueuelen is at
default value 10 frames.

Link: https://lore.kernel.org/r/20210427052150.2308-4-menschel.p@posteo.de
Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 009d5216f3ea..ef72e5344789 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -811,14 +811,16 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 
 		skb->dev = dev;
 		can_skb_set_owner(skb, sk);
 
 		can_send_ret = can_send(skb, 1);
-		if (can_send_ret)
+		if (can_send_ret) {
 			pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
 				       __func__, ERR_PTR(can_send_ret));
-
+			if (can_send_ret == -ENOBUFS)
+				pr_notice_once("can-isotp: tx queue is full, increasing txqueuelen may prevent this error\n");
+		}
 		if (so->tx.idx >= so->tx.len) {
 			/* we are done */
 			so->tx.state = ISOTP_IDLE;
 			dev_put(dev);
 			wake_up_interruptible(&so->wait);
-- 
2.34.1

