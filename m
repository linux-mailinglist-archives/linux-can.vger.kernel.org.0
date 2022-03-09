Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6E4D2EA5
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 13:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiCIMF1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiCIMFY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 07:05:24 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAED1171EDE
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 04:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646827462;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PAh0g0fO78QHblS/+kNp6tb2FmnZYXXzS4UBzo76n9Q=;
    b=dD4eMShwa6H583iHmSHBv0xWRPm5BPu3tC+izvR1eCqc7LTCjmc3JsI/YQLMeRjRf7
    TGpkCpb/u4SZh0xnxNa2H31DWV1wBkcVQXns2y9izbaCI2x3dM7FVeHETuCzQ1vlUBOc
    nH8uOAvvKTeNkpKHfUt3XzdhwxiS8ewF70AG+i02iCtqQRtXFf/9hwnHJALAI/fRLdgH
    DX2oZZqNtsEdgrD5jLeK2xgSZZ0s3/h9XdTxtkWviwzgl02T5YicIFwOprh5LkSS6wzm
    sTua5XtR93Xh2PwLy4WyNSkj/S/L7eGfO0lOFoILveQcVca+fHJgUrLnix89TKnyoaar
    Kc3A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.40.1 AUTH)
    with ESMTPSA id 6c57e6y29C4MEQB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Mar 2022 13:04:22 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next v2 5/5] vxcan: enable local echo for sent CAN frames
Date:   Wed,  9 Mar 2022 13:04:16 +0100
Message-Id: <20220309120416.83514-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309120416.83514-1-socketcan@hartkopp.net>
References: <20220309120416.83514-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
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

