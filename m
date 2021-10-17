Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9B43088E
	for <lists+linux-can@lfdr.de>; Sun, 17 Oct 2021 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbhJQMEX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Oct 2021 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhJQMEW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Oct 2021 08:04:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C21C061765
        for <linux-can@vger.kernel.org>; Sun, 17 Oct 2021 05:02:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mc4rj-0001kh-P7
        for linux-can@vger.kernel.org; Sun, 17 Oct 2021 14:02:11 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9A1C6695CAC
        for <linux-can@vger.kernel.org>; Sun, 17 Oct 2021 12:02:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D342E695CA7;
        Sun, 17 Oct 2021 12:02:09 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ce074a80;
        Sun, 17 Oct 2021 12:02:09 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Xiaochen Zou <xzou017@ucr.edu>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: j1939: j1939_session_deactivate(): fix potential UAF access
Date:   Sun, 17 Oct 2021 14:01:58 +0200
Message-Id: <20211017120158.2024996-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Xiaochen Zou <xzou017@ucr.edu>

Both session and session->priv may be freed in
j1939_session_deactivate_locked(). It leads to potential UAF read and
write in j1939_session_list_unlock(). The free chain is:

| j1939_session_deactivate_locked() ->
| j1939_session_put() ->
| __j1939_session_release() ->
| j1939_session_destroy()

To fix this bug, move the j1939_session_put() behind
j1939_session_deactivate_locked(), and guard it with a check of active
since the session would be freed only if active is true.

Link: https://lore.kernel.org/all/CAE1SXrv3Ouwt4Y9NEWGi0WO701w1YP1ruMSxraZr4PZTGsUZgg@mail.gmail.com
Link: https://lore.kernel.org/all/aa64ef28-35d8-9deb-2756-8080296b7e3e@ucr.edu
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I picked up the patch from Xiaochen Zou. I think it is the proposed
fix for:

| https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1


It turned out that

| 0c71437dd50d can: j1939: j1939_session_deactivate(): clarify lifetime of session object                                                                                                                                                                         

is wrong, and should be removed, as Ziyang Xuan proposed in:

| https://lore.kernel.org/all/20210906094200.95868-1-william.xuanziyang@huawei.com

Ziyang Xuan, Oleksij, can you have a look at Xiaochen Zou's patch and
give me an Ack, then I'll take both patches upstream.

regards,
Marc

net/can/j1939/transport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index dc3c30810833..35530b09c84f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1072,7 +1072,6 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
 
 		list_del_init(&session->active_session_list_entry);
 		session->state = J1939_SESSION_DONE;
-		j1939_session_put(session);
 	}
 
 	return active;
@@ -1086,6 +1085,8 @@ static bool j1939_session_deactivate(struct j1939_session *session)
 	j1939_session_list_lock(priv);
 	active = j1939_session_deactivate_locked(session);
 	j1939_session_list_unlock(priv);
+	if (active)
+		j1939_session_put(session);
 
 	return active;
 }
@@ -2152,6 +2153,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 {
 	struct j1939_session *session, *saved;
+	bool active;
 
 	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
 	j1939_session_list_lock(priv);
@@ -2165,7 +2167,9 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 				j1939_session_put(session);
 
 			session->err = ESHUTDOWN;
-			j1939_session_deactivate_locked(session);
+			active = j1939_session_deactivate_locked(session);
+			if (active)
+				j1939_session_put(session);
 		}
 	}
 	j1939_session_list_unlock(priv);
-- 
2.33.0


