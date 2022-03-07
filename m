Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B5A4D04BA
	for <lists+linux-can@lfdr.de>; Mon,  7 Mar 2022 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiCGQ6A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Mar 2022 11:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiCGQ5t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Mar 2022 11:57:49 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D417E0BB
        for <linux-can@vger.kernel.org>; Mon,  7 Mar 2022 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646672212;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PAh0g0fO78QHblS/+kNp6tb2FmnZYXXzS4UBzo76n9Q=;
    b=q2AFufRJVziTAvAt6hxNriGMIV6+UWqt9yQdL3NF3EDv9gc5KNlfAXs4APIlBkb6ct
    wT3DzcaNy0qmXOzNM/LrU5JztW0DWuE5KZvWab7KPPME5swzYkg5MeR5vjcA2eolAvVR
    KwJ73LE+/js31/EIQhOxXEHmGzvcWo6zgzbegl1dpiF3ZfiCW31htXAC553GVe344UpK
    uBddVXl0H5TDHSNQesF2iRtig/Cp5h3rMagWA9LDk1ZYMXlIoMoHtMlIrZtHz+Qx8J+I
    8DWDt92OnVtLS4bA2cUwyso68mRRAhf/V3rCgGVBYAYUUxZ2m+D+cHCRO+tV3cSngrXS
    yywQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y27Guq8gb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 7 Mar 2022 17:56:52 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 2/2] vxcan: enable local echo for sent CAN frames
Date:   Mon,  7 Mar 2022 17:56:44 +0100
Message-Id: <20220307165644.9689-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220307165644.9689-1-socketcan@hartkopp.net>
References: <20220307165644.9689-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The vxcan driver provides a pair of virtual CAN interfaces to exchange
CAN traffic between different namespaces - analogue to veth.

In opposite to the vcan driver the local sent CAN traffic on this interface
is not echo'ed back but only sent to the remote peer. This is unusual and
can be easily fixed by removing IFF_ECHO from the netdevice flags that
are set for vxcan interfaces by default at startup.

Without IFF_ECHO set on driver level, the local sent CAN frames are echo'ed
in af_can.c in can_send(). This patch makes vxcan interfaces adopt the
same local echo behavior and procedures as known from the vcan interfaces.

Fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 1c944b7d4bcc..0c69453054da 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -151,11 +151,11 @@ static void vxcan_setup(struct net_device *dev)
 	dev->type		= ARPHRD_CAN;
 	dev->mtu		= CANFD_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
-	dev->flags		= (IFF_NOARP|IFF_ECHO);
+	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &vxcan_netdev_ops;
 	dev->needs_free_netdev	= true;
 
 	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
 	can_set_ml_priv(dev, can_ml);
-- 
2.30.2

