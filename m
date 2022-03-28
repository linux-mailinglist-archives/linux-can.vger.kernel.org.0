Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128AC4E9558
	for <lists+linux-can@lfdr.de>; Mon, 28 Mar 2022 13:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiC1Ll0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Mar 2022 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiC1Lik (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Mar 2022 07:38:40 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2FC3
        for <linux-can@vger.kernel.org>; Mon, 28 Mar 2022 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1648467384;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UUda1Ase6POUEiPeAv8aGAFt0YeYA3hCqadxM5jbnXo=;
    b=Xyg6rfhrUTkhwbBKVBUN3FhGmxknv9iyVBI3jdggDBgO07KQRse0TTZQDOfRcfJMzI
    L9LDcszIyT2PxgWrykF9UTVV0REPBruWc7H7hTYet5fPEjIApL4+V9YUXt4l0P4wl6Ee
    NVT7hnJOMTlt84NMIIkx7IyTXc0NtkwJrKgN+xKN4Dmf9yv39BqO+muiIHpmk6v+Z2uw
    +xomRm3o1ocBtxzKxC/7QrKgYnZhgZRn5Ofbfk5ZqpInX8o7jBc/zlaSmQaVxPeo6zv+
    WTEC3e4777UuQGMV48Yt0NcTf4RfJzESGZe6QHDQ6rHBD23GlvBZ93UuZOc+az/0eXNz
    /+AQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9IyLecSWJafUvprl4"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.42.1 AUTH)
    with ESMTPSA id ed8ce5y2SBaO22p
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 28 Mar 2022 13:36:24 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>
Subject: [PATCH] can: isotp: restore accidentally removed MSG_PEEK feature
Date:   Mon, 28 Mar 2022 13:36:11 +0200
Message-Id: <20220328113611.3691-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading
from socket") a new check for recvmsg flags has been introduced that
only checked for the flags that are handled in isotp_recvmsg() itself.

This accidentally removed the MSG_PEEK feature flag which is processed
later in the call chain in __skb_try_recv_from_queue().

Add MSG_PEEK to the set of valid flags to restore the feature.

Fixes: 42bf50a1795a ("can: isotp: support MSG_TRUNC flag when reading from socket")
Link: https://github.com/linux-can/can-utils/issues/347#issuecomment-1079554254
From: Derek Will <derekrobertwill@gmail.com>
Tested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index f6f8ba1f816d..bafb0fb5f0e0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1048,11 +1048,11 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	struct sk_buff *skb;
 	struct isotp_sock *so = isotp_sk(sk);
 	int noblock = flags & MSG_DONTWAIT;
 	int ret = 0;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
 		return -EINVAL;
 
 	if (!so->bound)
 		return -EADDRNOTAVAIL;
 
-- 
2.30.2

