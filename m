Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898257DC99C
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbjJaJay (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjJaJaw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:52 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898DB7;
        Tue, 31 Oct 2023 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744633; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ki1WecRyHZq1BaXVz48SBh00kGu9Uu4LvI/O2i9AdB+M3fuBYqPdCvYrARe9HnOW74
    0ETO3MC4LQjvzo5Kb4bSfwdKlpHpkAVI8ic8n59+YgksHQ7QSHc/ATJDR6LxaIRsKbdH
    QbaeRCAuzkTpcQktAfl2Cc91xoIo4qD+8xaOlxTn+pFFaP9QmxjEy3mfP/S5Pk99kvan
    NV+nFhEEYHe/+7M3QYNixXe3mcOPMxKGfkg6jEWmCcgpWW1C37i7XJNUMk0ObmEYXp+1
    iVUeeqcsSILLqV8J+zaNtO25Y5Sv+0dXPkXNf5Lzf1siOtvXeuamIo7UOgrnlA4kxPh5
    UIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744633;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fWDmKNduZW32ZnQUBctI2DiGvAEE01WL3BcUXhWh/LI=;
    b=JR7mWFc7Aq41wQ38+1c7NKHdMNL0hQE30q+GFo+l3c4qWI8ojFZmArw/Nxq6e0OgLc
    WDhMRompTaCBbBmLfu+7/LXQXFebohpmTpe6UIxUqfC4iE2qV7qT9V90iB4NgMoBs3co
    TV/DDKAaMysrsIP0Ir7R4OY41+Adt7EIayv2e/ct+hY3Eo7U5NGTI9CgKWC0xPVdBQI6
    +rhW8P9oNeQzv8vPRKQ+8nySL82cbLPSF9AW5r116EvOtUr5w4xPXYQDBua6mO6DX+YI
    kCI8PzzaBlM0W56Y2UC/MCHNWfnwoM1PWqT7VhSckd3Xk9aJULjIsAZHLWnzRj7QpjAK
    YClQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744633;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fWDmKNduZW32ZnQUBctI2DiGvAEE01WL3BcUXhWh/LI=;
    b=fzeHofjJVJdIDzpjHfkwYb5bNmx3aMcy+KbJU+L7FflX3Slu1TbfyI1P4uQLYbbCWX
    oBE9u/u9Zk/nYQtz8mHEEBdPgEsVfvC9tkkuAQGPFevDX8py/7Z4zF8hm/2ddTbLb/Tr
    yGCqakP1zKhXIAyymMquwnDq8ulxTkJeUvl2RL9TGUHkQ9W7jhmR7IQHogtGq1J3ayZw
    xNh+zdNF9UcnhX5FGoyMDCCo9tCbQ4AK1qhRRqaYJ59rMZU0cdbgV61ZNaHrQSXyDd3P
    aPvJEIK1G/C3q+OdNJwPruVc+hnZ6dUcarPvQxtj6I0f6D/PM7kQRQGMydbeEakwie86
    gBmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744633;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fWDmKNduZW32ZnQUBctI2DiGvAEE01WL3BcUXhWh/LI=;
    b=f6q3VlM0A3MennfyKt88Z0SBbh+d8KbGUaU9tN7ea7Q/eWU+dFcZnjQLe3ZE1NI9wA
    Lb+OZEW2nzOIXLMCONDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9UWFhb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:30:32 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.15 4/7] can: isotp: handle wait_event_interruptible() return values
Date:   Tue, 31 Oct 2023 10:30:22 +0100
Message-Id: <20231031093025.2699-5-socketcan@hartkopp.net>
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

commit 823b2e42720f96f277940c37ea438b7c5ead51a4 upstream

When wait_event_interruptible() has been interrupted by a signal the
tx.state value might not be ISOTP_IDLE. Force the state machines
into idle state to inhibit the timer handlers to continue working.

Fixes: 866337865f37 ("can: isotp: fix tx state handling for echo tx processing")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20230112192347.1944-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 82e56f3dd2c6..683010c71a8a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1069,10 +1069,14 @@ static int isotp_release(struct socket *sock)
 	net = sock_net(sk);
 
 	/* wait for complete transmission of current pdu */
 	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 
+	/* force state machines to be idle also when a signal occurred */
+	so->tx.state = ISOTP_IDLE;
+	so->rx.state = ISOTP_IDLE;
+
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
 		spin_unlock(&isotp_notifier_lock);
 		schedule_timeout_uninterruptible(1);
 		spin_lock(&isotp_notifier_lock);
-- 
2.34.1

