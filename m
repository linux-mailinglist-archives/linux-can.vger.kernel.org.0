Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506435709FD
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 20:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiGKSet (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGKSes (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 14:34:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B8DFB0
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657564481;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NDgco5RYdDcJV1LfdfGi1QhL4NgTbUq2Mx33c4Z84lg=;
    b=rQDLq/B/Ri9EzYF1kdtDxm6uUxLyuYCo41NjfT/mz6njbYXTJLElvFFMEWC9+k4fhY
    KL8Vtasgc6OI96ovSTQXZIp0CKGGQXQvV52wx9n0XmIZXg9htF28K7oZJYGdGkE2ynee
    XxV2oNI9mn2VP909oKT6gUv+cU61mfuwzOR7fVcvBBwIi2hEZgbXTSPQKYG/5Xp8Obk3
    O1fzCjlrRasd2gD3zMzWky3v/EOvoihxyRH5Aw3DQbSrtZSUbp4YedB1+Sjf9PBw48Fs
    Em1TJP++k4KL9GjxvxDKB0TgW1PKjr9iMXi8qc8kZpwm9sROi6OlMCP47q+sBipXx1bY
    GV2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6BIYfReP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Jul 2022 20:34:41 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 5/5] can: raw: add CAN XL support
Date:   Mon, 11 Jul 2022 20:34:26 +0200
Message-Id: <20220711183426.96446-6-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711183426.96446-1-socketcan@hartkopp.net>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Enable CAN_RAW sockets to read and write CAN XL frames analogue to the
CAN FD extension (new CAN_RAW_XL_FRAMES sockopt).

A CAN XL network interface is capable to handle Classical CAN, CAN FD and
CAN XL frames. When CAN_RAW_XL_FRAMES is enabled, the CAN_RAW socket checks
whether the addressed CAN network interface is capable to handle the
provided CAN frame.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/raw.h |  1 +
 net/can/raw.c                | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 3386aa81fdf2..ff12f525c37c 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -60,8 +60,9 @@ enum {
 	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
 	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
+	CAN_RAW_XL_FRAMES,	/* allow CAN XL frames (default:off) */
 };
 
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/raw.c b/net/can/raw.c
index d1bd9cc51ebe..c036de63fcfa 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -85,10 +85,11 @@ struct raw_sock {
 	int ifindex;
 	struct list_head notifier;
 	int loopback;
 	int recv_own_msgs;
 	int fd_frames;
+	int xl_frames;
 	int join_filters;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	can_err_mask_t err_mask;
@@ -344,10 +345,11 @@ static int raw_init(struct sock *sk)
 
 	/* set default loopback behaviour */
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
 	ro->fd_frames        = 0;
+	ro->xl_frames        = 0;
 	ro->join_filters     = 0;
 
 	/* alloc_percpu provides zero'ed memory */
 	ro->uniq = alloc_percpu(struct uniqframe);
 	if (unlikely(!ro->uniq))
@@ -667,10 +669,19 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
 			return -EFAULT;
 
 		break;
 
+	case CAN_RAW_XL_FRAMES:
+		if (optlen != sizeof(ro->xl_frames))
+			return -EINVAL;
+
+		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (optlen != sizeof(ro->join_filters))
 			return -EINVAL;
 
 		if (copy_from_sockptr(&ro->join_filters, optval, optlen))
@@ -749,10 +760,16 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->fd_frames;
 		break;
 
+	case CAN_RAW_XL_FRAMES:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->xl_frames;
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
 		val = &ro->join_filters;
 		break;
@@ -795,14 +812,21 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	dev = dev_get_by_index(sock_net(sk), ifindex);
 	if (!dev)
 		return -ENXIO;
 
 	err = -EINVAL;
-	if (ro->fd_frames && dev->mtu == CANFD_MTU) {
+	if (ro->xl_frames && dev->mtu == CANXL_MTU) {
+		/* CAN XL, CAN FD and Classical CAN */
+		if (unlikely(size != CANXL_MTU && size != CANFD_MTU &&
+			     size != CAN_MTU))
+			goto put_dev;
+	} else if (ro->fd_frames && dev->mtu == CANFD_MTU) {
+		/* CAN FD and Classical CAN */
 		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
 			goto put_dev;
 	} else {
+		/* Classical CAN */
 		if (unlikely(size != CAN_MTU))
 			goto put_dev;
 	}
 
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
-- 
2.30.2

