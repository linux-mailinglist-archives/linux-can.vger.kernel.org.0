Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1B3AD9C9
	for <lists+linux-can@lfdr.de>; Sat, 19 Jun 2021 13:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhFSLZu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Jun 2021 07:25:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:28103 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLZs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624101812;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aAIe1ntCdeVHlSG24jsbLt3hU5nfnfJXFYRMpbjcRVQ=;
    b=dUoOnfyyjBtlOWmny57+oDEXOSkZttM2vVbD5s7LYtW5/5FGmuBjqEZNuev+yxvDQl
    xjR5SMiXVlmFp70xpA8MeFQIZzlxWhZy9TS02fdr1cu+Fnl5KESZp1NbjIVdefj5ERac
    HzzUqcOnkFFUikGN7rSx+3bWrPbfJFWnOvabtyqaiq8Ui2AvikXzO3d4O7DeWWVrKEdG
    J6n50NEF5PokRaI1H/8vZcGh0KJKoIWwG5tSq8lT4oj5/jPNT0jfYZTavsM6oGK7K+dZ
    R3RBQG7fOs9WQetMLkSB+jQ7zRRGTj9JOyGciM/G5zYNHhUuK1+aFq0hmpmuCfFOmFtV
    Lgdg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJywjsS7yVw=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id N0b2dax5JBNW3Z1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 19 Jun 2021 13:23:32 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] [RFC] vxcan: enable local echo for sent CAN frames
Date:   Sat, 19 Jun 2021 13:23:18 +0200
Message-Id: <20210619112318.79145-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 8861a7d875e7..be5566168d0f 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -146,11 +146,11 @@ static void vxcan_setup(struct net_device *dev)
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

