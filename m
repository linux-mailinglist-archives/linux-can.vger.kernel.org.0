Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757A465DABF
	for <lists+linux-can@lfdr.de>; Wed,  4 Jan 2023 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjADQvQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Jan 2023 11:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbjADQuy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Jan 2023 11:50:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8124FD5B;
        Wed,  4 Jan 2023 08:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672850770;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rgR+5VJsgD/WBWe5mrMSuHTk0M7qJ7yy5//Dvc46/PA=;
    b=m2D1r/OlIV1UBy9027egyts+MJKX0E0N1SDstQ2+2FmOBHguSCCsG+6yhD7eHODhRC
    cZpt9QhPCdBPB8w1roidTydw5s58/8idcGtSG1LIeoLmWksPKxIpiBCxVqlyPo8wee9G
    jPROswcztxuDHh5bVzKVYZ0BoTfYCe4xUabQVjXdP36vScQs52axX/ybL6yAaMbGVC9H
    z9w09EJgIZeY6HdpWtAPKu3SyyKKcaybwVOMBzhPFz1o+DbwxogS8MzGBpyHMu4whbaW
    9Od+mfCb6QYv22Ld2Oi6/RBPpbTNZPuEgdFyRqiNd6A7aJX6sAT5/qMurnMC+3A3VdQJ
    jjpw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJygjsS+Kjg=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id j06241z04GkA11Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 4 Jan 2023 17:46:10 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, stable@vger.kernel.org
Subject: [PATCH v2] can: isotp: handle wait_event_interruptible() return values
Date:   Wed,  4 Jan 2023 17:46:05 +0100
Message-Id: <20230104164605.39666-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When wait_event_interruptible() has been interrupted by a signal the
tx.state value might not be ISOTP_IDLE. Force the state machines
into idle state to inhibit the timer handlers to continue working.

Cc: stable@vger.kernel.org # >= v5.15
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

V2: fixed checkpatch warnings m(

 net/can/isotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0476a506d4a4..fc81d77724a1 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1150,10 +1150,14 @@ static int isotp_release(struct socket *sock)
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
2.30.2

