Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B877DC989
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjJaJaZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbjJaJaW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:22 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41842B7;
        Tue, 31 Oct 2023 02:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744598; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AK0RI7g7OWhU5BBxH5S4cYSbhMesglfOcXp4KimSomyyenq4ZJk5O4C3ggQLz+UAu2
    f0y6cSIezuWzipoQDqj9dIKEsaOe1oW2b9H00XWni1AzMIKfq5oVlyo7jkiBV5dgtYZP
    kyyAiSteILfb1ysB6gfPyptY8g06GPIqtx0iQb5ZoXbfF4LMLPm/e8d43h/jNNjS3/A1
    lNYXrv0gg0Qt49rXegW1oUg0Or/jAFieFLy9X48rhnwo8/OEcmTqnbS4ABkF7MLcFv3m
    SB3cMNER4er1Oy/y9SuiecodD3Xl6KA00N6mqDGqZjWbULCVXuSFsnz6EzXA9FvdkZnm
    XUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744598;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ebGAvzRCuJbCaJaJS6/JZmOl0rVWjzcFYSvIW/E7qT0=;
    b=MDOU0nhMfeQq1rJZ6uLji9PFgQrWJjAus2qXHGf/PRZaAGDQx5UFclN+7+y86sOzj8
    tMNfyDLv1qf7m7nR+d5tQV+9P8IfHbjSnwZWYF4HWfx39YVPNwwbYNhv9TEp5sEBX7Y0
    U59czErMynHGaozJ2p1U0SphtZbMlCIL09DjY9WdkOwzF2L6sVwFzNhCpmTQRhC4xFta
    vDyhFR8SrDOUCgEiKFt9M3sAc4qhctD04YqojsFM0ac1l4AODrvTlGk2mHGlIF5BTXRD
    KrPYTaaYif7uZYsPeM12+PuCk5GuvyeyaUC+cS1vdfPXW0NHtMmEyIiPECF6gTUiRkjy
    gbDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744598;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ebGAvzRCuJbCaJaJS6/JZmOl0rVWjzcFYSvIW/E7qT0=;
    b=NcbayBmMvyYKg4cDMMlg2PHKsPn6RfLAaxIrpMdC8QMDrpwKNJoA1Edv1DrFdRJjAy
    3ncNk0HVucP41dlFpkFPjthWf7A3Qskv+uP/1Nlie5CPZIZ9vHwT16G/tDwHLzfSO9vu
    vXj9C/9rn5Scd7LottH+zGg5rrb5axqwCKoZkTYaf4AoODodQ/EhM1cOSDqFJ7/mT6UP
    yp6iobl7D/KcAgsQz8ADZhaG05v1Ggl+nTAMcKvBrNENA1VuY5e4ZrMvyQycttMpFeX1
    aR777gd7sy3F1mvtTH5OYBIdH+mV9n0W1v9+Ryn479SJGskKeBFA27JMu4FIUaGUwKvn
    TVzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744598;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ebGAvzRCuJbCaJaJS6/JZmOl0rVWjzcFYSvIW/E7qT0=;
    b=7DJBThody0Sm8OROlSjJySLEt5IH0glAxwSWvMGH2KjY/Uu8y45PQH0WnMDdyNz9ca
    Yezni/3FibzHI9VXw8BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TvFhM
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
Subject: [PATCH stable 5.10 09/10] can: isotp: isotp_bind(): do not validate unused address information
Date:   Tue, 31 Oct 2023 10:29:17 +0100
Message-Id: <20231031092918.2668-10-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031092918.2668-1-socketcan@hartkopp.net>
References: <20231031092918.2668-1-socketcan@hartkopp.net>
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
index f362b50484fc..08dfa34d68d5 100644
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

