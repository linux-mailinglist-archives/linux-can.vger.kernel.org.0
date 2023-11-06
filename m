Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02F67E2522
	for <lists+linux-can@lfdr.de>; Mon,  6 Nov 2023 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjKFN2c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Nov 2023 08:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjKFN2a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2023 08:28:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFDA9;
        Mon,  6 Nov 2023 05:28:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DDCC433C8;
        Mon,  6 Nov 2023 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277307;
        bh=A2bR43LHmqL1wU1auzRI6+9//d06Jzsx5FFntdSLDY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r362mpr8Tx4ZYKRq11UzBc01y0xI+rRxWqQvcPRqI4akU36KJIJ6R4ztL4EcHbn+U
         EzfxYbEybHyB7XKiv7Jj3eni1+K79hEIy4n+GM9kr0+8Ec+1MTB6+ActMIdmxS7y9g
         St+GxTu6Ud9MbYshv7Mp93j4If8f15uQFHjhkF6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz, Oliver Hartkopp" 
        <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5.15 109/128] can: isotp: isotp_bind(): do not validate unused address information
Date:   Mon,  6 Nov 2023 14:04:29 +0100
Message-ID: <20231106130314.126278717@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/isotp.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1216,7 +1216,8 @@ static int isotp_bind(struct socket *soc
 	struct net *net = sock_net(sk);
 	int ifindex;
 	struct net_device *dev;
-	canid_t tx_id, rx_id;
+	canid_t tx_id = addr->can_addr.tp.tx_id;
+	canid_t rx_id = addr->can_addr.tp.rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
 
@@ -1226,24 +1227,28 @@ static int isotp_bind(struct socket *soc
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
 


