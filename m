Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065DE7DC9A4
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbjJaJa7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbjJaJa6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:58 -0400
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBEFD8;
        Tue, 31 Oct 2023 02:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744634; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CzgwnzOFo/vg4xtlwHCHeDWAwbzLIQWQMiSaSBahJZ8+f41n9oIMl3kTE2QsnoomIW
    4tgoiUtSuSeNT7/+U5uFwaRBqGCYWBlbzpLm+e/+R9VbozwYWdpT9XtOaMfvPTLCxzSR
    avIW/w/QCF1Cy9bufds+Iq0c8upncjqdpHPzYxyN6rOJJ3CnvJrHISsxTsj4wTDP8UXy
    ufBH1cueg/e1lB1GWB6IO8Lab4N5qggemu/UZhnhDFIVN3bz727aVbfqTXLFHPRmH7C/
    vwN52Yf0j9tYoW/CLJHFVeITe4Ex5/Zz3SyrRJgZ0/tGoc8f5Ezv1GS4ZXzMkIEf+KaR
    ZWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744634;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bQvEpAAuHnU3tatG52dBHin+zv30ZyBfz5/VVPFy72A=;
    b=ghXYIYD/fmhe1cjWdsvOeIu+Z9xwcrtX4prcD9bnWz7VcvutvzHMZY5SAzyzbU1isX
    5flO2I70jQNf5CTXC2eOhoXWVWQuwSB0m+8q/RKdJxOdrijf5EAAY+LthOR2tnjNXgKa
    m0LfCzwudNZDboac6VwRikp1DAiK3S0oK4LHUv/06hRX8C6Ho3GodDGn3GThAlrtsWva
    wJt7YeCxq2LwUsyVklZQ6n7//ItZXxn1S3sFNxUyWBFUsN3CFx3Cs3NElX+rWFUlyB6E
    VOX9CGtSAi+3r5hzWesCHZfIud7tiEOOy/iscbSNe9XyJ+BCqASCX9ds2jZxLRw8jgoV
    zR7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744634;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bQvEpAAuHnU3tatG52dBHin+zv30ZyBfz5/VVPFy72A=;
    b=H+vubt/k2jhsuoNZtiu8ppxinw69ay3q7ZVaWyFOwKhMV0Khom8qQxIexU4QcTiWW+
    cQPk1fwGB46WJUP7LOYB/vyjp4Y7BjTUJYBul7ZhLjjdIzXanp1cPrl6NINDAEm2DlFA
    pk40fQBOU7wV9/J2AUqzNrNWMnfGHLLYFbCnY/c09LlW2q9SzUFiDqPuCYtmiSv3mYxc
    8FlxyiufoFqxPY1mHXvIKglvt1MMGonhSL/oECO+S2aQqtUGs2ZDElqbDPAJU4reCDRa
    1OB2S43q5qES/xVmnBilyYImyFyzslW5cyfqqchbZPHgCKxjidLgc0PmJDCc+ftrNao5
    r/Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744634;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bQvEpAAuHnU3tatG52dBHin+zv30ZyBfz5/VVPFy72A=;
    b=jVSOUNLSHlMLuUKLLzRRrQij3lvnZt4QNUSlVe0zJwiQjC7OaLeF5pZOx5fbc3vIeK
    pfyfLHbIE6ZU+jK4djAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9UXFhd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:30:33 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.15 6/7] can: isotp: isotp_bind(): do not validate unused address information
Date:   Tue, 31 Oct 2023 10:30:24 +0100
Message-Id: <20231031093025.2699-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031093025.2699-1-socketcan@hartkopp.net>
References: <20231031093025.2699-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

commit b76b163f46b661499921a0049982764a6659bfe7 upstream

With commit 2aa39889c463 ("can: isotp: isotp_bind(): return -EINVAL on
incorrect CAN ID formatting") the bind() syscall returns -EINVAL when
the given CAN ID needed to be sanitized. But in the case of an unconfirmed
broadcast mode the rx CAN ID is not needed and may be uninitialized from
the caller - which is ok.

This patch makes sure the result of an inproper CAN ID format is only
provided when the address information is needed.

Link: https://lore.kernel.org/all/20220517145653.2556-1-socketcan@hartkopp.net
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 19fffa8676f9..00cb38b4a6f4 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1214,38 +1214,43 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct net *net = sock_net(sk);
 	int ifindex;
 	struct net_device *dev;
-	canid_t tx_id, rx_id;
+	canid_t tx_id = addr->can_addr.tp.tx_id;
+	canid_t rx_id = addr->can_addr.tp.rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
 
 	if (len < ISOTP_MIN_NAMELEN)
 		return -EINVAL;
 
 	if (addr->can_family != AF_CAN)
 		return -EINVAL;
 
-	/* sanitize tx/rx CAN identifiers */
-	tx_id = addr->can_addr.tp.tx_id;
+	/* sanitize tx CAN identifier */
 	if (tx_id & CAN_EFF_FLAG)
 		tx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
 	else
 		tx_id &= CAN_SFF_MASK;
 
-	rx_id = addr->can_addr.tp.rx_id;
-	if (rx_id & CAN_EFF_FLAG)
-		rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
-	else
-		rx_id &= CAN_SFF_MASK;
-
-	/* give feedback on wrong CAN-ID values */
-	if (tx_id != addr->can_addr.tp.tx_id ||
-	    rx_id != addr->can_addr.tp.rx_id)
+	/* give feedback on wrong CAN-ID value */
+	if (tx_id != addr->can_addr.tp.tx_id)
 		return -EINVAL;
 
+	/* sanitize rx CAN identifier (if needed) */
+	if (isotp_register_rxid(so)) {
+		if (rx_id & CAN_EFF_FLAG)
+			rx_id &= (CAN_EFF_FLAG | CAN_EFF_MASK);
+		else
+			rx_id &= CAN_SFF_MASK;
+
+		/* give feedback on wrong CAN-ID value */
+		if (rx_id != addr->can_addr.tp.rx_id)
+			return -EINVAL;
+	}
+
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
 	lock_sock(sk);
 
-- 
2.34.1

