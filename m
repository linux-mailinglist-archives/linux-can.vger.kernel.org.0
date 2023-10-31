Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBFB7DC98C
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjJaJa1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbjJaJaX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3277C2;
        Tue, 31 Oct 2023 02:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744595; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mR2xWAVpv+8xC0PiZLKs3i5n38Ax4Z1Vq1juZVi6qMQFF9uQGtPpRtXjL70s6YrUky
    ijHu4xkSFjguMbpmcjWzxQu1ZhmoHIhy2kraGX0I8NIO/bvYNvu52piiicy9LPhJP97O
    AAA/5QDw3l6yTELnD3YhhT+UTivEwSSO/u7Wflu5+ggoINQCYQIW+1FjqHIGDfmPAHRv
    Wfz9m/kS0NJQN2WBGoavr12dxzh+M8SDHjCtphEU8nZuoNLKKeRkOoEOVSylahFru5+X
    R4vwtML+dNDvz6mQm7AEgi4ekDILvTpeOZf2Ue84xgbwRFeeUZ9Eye+VwB/G6y5gFULF
    Rcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744595;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fwr9Yyps0n7xorku1FmI8M8T/JglpqalD+8WKBvgPlA=;
    b=n+ug/XpTp1uQkX4ewonxAkXlGm3LSeO2NvZdr00s8R89WEhYUlV6k2DddE7wLQnOCO
    YnfsvHVcfyWDDHWYfHhxqb389ki4uzi38EWwnWZO3uYOnrdlh3l5+lxTZ4I1OCD9SUW8
    FicL2f6sl2M/0zpWLhKS1z2CNYOVc3P9jTy9pvnc+GIrfRjzYqeD4pglE0GLNy5LS0VY
    4LIFreO3IGTW07iouTbbSCaStjUFDqU7h/7oQ8T7cmMP2dN5Wh5aW+4+WKUuJRyMeM7j
    DKEVjC2VIjWgXK0LDmds4aFEhewx9iZRbYYrUs+UlaHvgywy6p0+5ORtfhqjzEzDetSz
    OS/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744595;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fwr9Yyps0n7xorku1FmI8M8T/JglpqalD+8WKBvgPlA=;
    b=blrYdijHjjPusnsmDToyb8kiN1c3leB3Lux6YOhXvocFvXoPx2F1+i/u3lBljls/zN
    ZwJdPL/xB6hnAWMDyw4M5ZkO+UcAEsCytmuC7+Gg+llEctZoBWX69EVTD2Pe4dxFGqaI
    INA545Q86QObp5PWnBbjUKWAoaiobMhLhBFG4GvQd88XhMczswQi57lNwX3IrxaTX1Ug
    5e4nYdSYj1alPeav2wIfuDATAMxMOu2YurrVhKaz5sETA+azhT+F00HY2lypZeBh+Ir9
    +HHe7Y/Qz7f8wSf9S5RnhpRRC81asMqEf5O7PZLoPOlugjyrQJi6Wrw5tTjU9VR9Q0D1
    6Cqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744595;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fwr9Yyps0n7xorku1FmI8M8T/JglpqalD+8WKBvgPlA=;
    b=2QzYqLNlCaM2aj9bbQzHgae511gj7jxYAnq4pb+c0m6KTBBHg6Mq6MLj1zfJ/M35/Z
    y4+ncnHzRwfVYe/vVABg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TsFhC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:54 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Patrick Menschel <menschel.p@posteo.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.10 01/10] can: isotp: change error format from decimal to symbolic error names
Date:   Tue, 31 Oct 2023 10:29:09 +0100
Message-Id: <20231031092918.2668-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031092918.2668-1-socketcan@hartkopp.net>
References: <20231031092918.2668-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Patrick Menschel <menschel.p@posteo.de>

commit 46d8657a6b284e32b6b3bf1a6c93ee507fdd3cdb upstream

This patch changes the format string for errors from decimal %d to
symbolic error names %pe to achieve more comprehensive log messages.

Link: https://lore.kernel.org/r/20210427052150.2308-2-menschel.p@posteo.de
Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 16ebc187af1c..d34f9ab2eb62 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -226,12 +226,12 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	ncf->flags = so->ll.tx_flags;
 
 	can_send_ret = can_send(nskb, 1);
 	if (can_send_ret)
-		pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-			       __func__, can_send_ret);
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(can_send_ret));
 
 	dev_put(dev);
 
 	/* reset blocksize counter */
 	so->rx.bs = 0;
@@ -812,12 +812,12 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 		skb->dev = dev;
 		can_skb_set_owner(skb, sk);
 
 		can_send_ret = can_send(skb, 1);
 		if (can_send_ret)
-			pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-				       __func__, can_send_ret);
+			pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+				       __func__, ERR_PTR(can_send_ret));
 
 		if (so->tx.idx >= so->tx.len) {
 			/* we are done */
 			so->tx.state = ISOTP_IDLE;
 			dev_put(dev);
@@ -974,12 +974,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb->dev = dev;
 	skb->sk = sk;
 	err = can_send(skb, 1);
 	dev_put(dev);
 	if (err) {
-		pr_notice_once("can-isotp: %s: can_send_ret %d\n",
-			       __func__, err);
+		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
+			       __func__, ERR_PTR(err));
 
 		/* no transmission -> no timeout monitoring */
 		if (hrtimer_sec)
 			hrtimer_cancel(&so->txtimer);
 
-- 
2.34.1

