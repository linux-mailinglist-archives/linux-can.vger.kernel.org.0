Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA37DC991
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbjJaJa3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbjJaJa0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:26 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E819A3;
        Tue, 31 Oct 2023 02:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744597; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V97ICwzDmgyVNmXWNbF57ToZCurZB7XvyasjEeaz+rmQJNbyHusuB0L+XvE2k23Sl3
    1m40LfHo3bXHu4HZjgRCCp6CQRV3GVX/VA8hu5iZ/YIPEee6URznRUaXrDYtRJJZWoBH
    Mu7jgyInZYb8a8M3mIgavup28wwZSYnosUab/cCRFeQTnADUxLvrfe9X51eAp21SzeCE
    w/iH8DxTaFJKwRIHtJ+GVCOVxrctuRBLtQvJa2Xi9wLuwnUMmozC+zIdCAk1xWfYgqiw
    YYPK4vuvf9fzdvJCNp0MBp1ppCtz5XDO3VoVPHU6nND94g/22fIVCu+tvpAOvI/zDkEY
    oKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744597;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cMohUgZNJMTVeoM6OkAxwBWpzdf/KkSfTakcu6Sty1g=;
    b=XTPHlNFTPJq0gVlqrCNYBrqVDKzzhbEE3yihhmhF8GiMMUlYMIpczwFdBl9vwFGMi0
    JTt7JBI/3sGhBasXJtIhbAoX7txGjmKcS217GdGML+T2XMkWUi82TSdi787etTp0Fs/9
    rKsZkqWpPT5Fo3BXbI3MQ9oWLF8Lj90WLbOzHyO7kO3/bvdkjZ2PuZIzURP7PcGoH9LC
    eABv7N1QPWuVVsueROwN8mdJ/BO2w0Cvt01dA+idWbY+tTiwT0AHGa9v884iU12CDklp
    6tz/+axq9sdkEvbzHarnCvSyQ2YZgyExsuf79K7oS4u2QzX7fFyBCcyWxO3AxI4j6rGB
    5dag==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744597;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cMohUgZNJMTVeoM6OkAxwBWpzdf/KkSfTakcu6Sty1g=;
    b=lmcibq+LIMbtb47LsA+dHQXGPxLKuO2VmHiBghdBBPRAoI8FITKFQkp96rD9ZlMcCG
    QteEFVouEmPlizZcF2FMEHe1abV9IC+VO+J2uAGK4sHwmuhXpjeI+9nwu3mZ2SWpaRsS
    BX93RD5+qB293rY+DARas+ls1Cy0qnZzE1zErQ4lC6MOkCRjIAiBjcUb8d2JS/lQ9dg5
    M6EzB/h680b+wTiaJdXDll15wSY7VhQ6f6nW4+CgZr3OFz4p2usHEJnZvScQeMG4cJJW
    /S3GSKqM6nGZNBoCGfpgTtpSYNDSfjvMjOh5oQAcd7BGf32DB04O8spkGWZQbG8FqmmT
    +vTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744597;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=cMohUgZNJMTVeoM6OkAxwBWpzdf/KkSfTakcu6Sty1g=;
    b=L+9eP1Fjq+VI3wlbybXTVWsqU+JIh/WP+3LPRwFAzRrOmSAcLL9ESCXrWqjCeyAUDF
    ZIYbC2mAFnogLgjrKOCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TvFhK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:57 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.10 07/10] can: isotp: handle wait_event_interruptible() return values
Date:   Tue, 31 Oct 2023 10:29:15 +0100
Message-Id: <20231031092918.2668-8-socketcan@hartkopp.net>
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
index 87de9a08cc85..42194b0d176c 100644
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

