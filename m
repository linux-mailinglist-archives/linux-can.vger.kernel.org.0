Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC55439C3
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 18:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbiFHQzi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiFHQx1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:53:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8023C6DA5
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:51:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gl15so28761732ejb.4
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5VTRziMnkGl4xU+BjwtCkmgql6hb+Z7QIN+Rj1ilOY=;
        b=GL2/5+TAp2pCEdHfQjTf3qp6TnHIgDKiGZCM9GYA8KeppoGt7LaELuW2XfFj50OSGV
         +ms6qSWcZgedGSWQOsfL6aFERIBd8eSMCSsty6uIUF0t/ZMQtv+mfrB5sRhpMXrq+Se7
         t375ns2CbOCjT/WTu6fER4CUTRIteo+P7v+KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5VTRziMnkGl4xU+BjwtCkmgql6hb+Z7QIN+Rj1ilOY=;
        b=xT7oQTo2gBIsU3CzMUf8x3Hu3WX4lSVLs82vfh+tWo6aThXsaRuwCGCBCjKJ6AMdAM
         MoJ01KxnaG8O9TQlRSis3W8y2/oVnIoYV/Srt/fQr6WiyZZOO8OCp8kDRn+zaX+XRGPh
         J2jfv+Ho1mMXKk1k9LVJC8pOare7LrV2GjKxcR4jTsInM43fxjJV0zcGY/x/0HguiLOY
         EAr0nLk4KnRh+OXyv6Obk7qXn1m9XvK1thbRYHybTktUJMXlT12rItLuF/cpHCmcUc3O
         VAPoUAkeWvAKrW5YvGD/4AoNFTNK/IhNybaJauqwdz4noo1z/6MHdMkv5wCbRez7YaUR
         L/1g==
X-Gm-Message-State: AOAM530k8umlJK/OZKEj4Pk+Rg6aIbxXVK6USY6KNL1Dyt43GOvA3hXc
        WSPg5PMOv6bGozreWEWoyUw8wQ==
X-Google-Smtp-Source: ABdhPJyZoLJRVZQupGQWtXsIWh3QTK3xk6DJUkI7csBK98pda16YzwvC04ry6ZVCTx7GS1yDfbvy3g==
X-Received: by 2002:a17:906:9f1c:b0:711:cdda:a01f with SMTP id fy28-20020a1709069f1c00b00711cddaa01fmr16104703ejc.372.1654707087890;
        Wed, 08 Jun 2022 09:51:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:27 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 03/13] can: slcan: use the alloc_can_skb() helper
Date:   Wed,  8 Jun 2022 18:51:06 +0200
Message-Id: <20220608165116.1575390-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

It is used successfully by most (if not all) CAN device drivers. It
allows to remove replicated code.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Put the data into the allocated skb directly instead of first
  filling the "cf" on the stack and then doing a memcpy().

 drivers/net/can/slcan.c | 69 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 6162a9c21672..5d87e25e2285 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -54,6 +54,7 @@
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
 #include <linux/can.h>
+#include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/can/can-ml.h>
 
@@ -143,85 +144,79 @@ static struct net_device **slcan_devs;
 static void slc_bump(struct slcan *sl)
 {
 	struct sk_buff *skb;
-	struct can_frame cf;
+	struct can_frame *cf;
 	int i, tmp;
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
-	memset(&cf, 0, sizeof(cf));
+	skb = alloc_can_skb(sl->dev, &cf);
+	if (unlikely(!skb)) {
+		sl->dev->stats.rx_dropped++;
+		return;
+	}
 
 	switch (*cmd) {
 	case 'r':
-		cf.can_id = CAN_RTR_FLAG;
+		cf->can_id = CAN_RTR_FLAG;
 		fallthrough;
 	case 't':
 		/* store dlc ASCII value and terminate SFF CAN ID string */
-		cf.len = sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
+		cf->len = sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
 		sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN] = 0;
 		/* point to payload data behind the dlc */
 		cmd += SLC_CMD_LEN + SLC_SFF_ID_LEN + 1;
 		break;
 	case 'R':
-		cf.can_id = CAN_RTR_FLAG;
+		cf->can_id = CAN_RTR_FLAG;
 		fallthrough;
 	case 'T':
-		cf.can_id |= CAN_EFF_FLAG;
+		cf->can_id |= CAN_EFF_FLAG;
 		/* store dlc ASCII value and terminate EFF CAN ID string */
-		cf.len = sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
+		cf->len = sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
 		sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN] = 0;
 		/* point to payload data behind the dlc */
 		cmd += SLC_CMD_LEN + SLC_EFF_ID_LEN + 1;
 		break;
 	default:
-		return;
+		goto decode_failed;
 	}
 
 	if (kstrtou32(sl->rbuff + SLC_CMD_LEN, 16, &tmpid))
-		return;
+		goto decode_failed;
 
-	cf.can_id |= tmpid;
+	cf->can_id |= tmpid;
 
 	/* get len from sanitized ASCII value */
-	if (cf.len >= '0' && cf.len < '9')
-		cf.len -= '0';
+	if (cf->len >= '0' && cf->len < '9')
+		cf->len -= '0';
 	else
-		return;
+		goto decode_failed;
 
 	/* RTR frames may have a dlc > 0 but they never have any data bytes */
-	if (!(cf.can_id & CAN_RTR_FLAG)) {
-		for (i = 0; i < cf.len; i++) {
+	if (!(cf->can_id & CAN_RTR_FLAG)) {
+		for (i = 0; i < cf->len; i++) {
 			tmp = hex_to_bin(*cmd++);
 			if (tmp < 0)
-				return;
-			cf.data[i] = (tmp << 4);
+				goto decode_failed;
+
+			cf->data[i] = (tmp << 4);
 			tmp = hex_to_bin(*cmd++);
 			if (tmp < 0)
-				return;
-			cf.data[i] |= tmp;
+				goto decode_failed;
+
+			cf->data[i] |= tmp;
 		}
 	}
 
-	skb = dev_alloc_skb(sizeof(struct can_frame) +
-			    sizeof(struct can_skb_priv));
-	if (!skb)
-		return;
-
-	skb->dev = sl->dev;
-	skb->protocol = htons(ETH_P_CAN);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
-
-	skb_put_data(skb, &cf, sizeof(struct can_frame));
-
 	sl->dev->stats.rx_packets++;
-	if (!(cf.can_id & CAN_RTR_FLAG))
-		sl->dev->stats.rx_bytes += cf.len;
+	if (!(cf->can_id & CAN_RTR_FLAG))
+		sl->dev->stats.rx_bytes += cf->len;
 
 	netif_rx(skb);
+	return;
+
+decode_failed:
+	dev_kfree_skb(skb);
 }
 
 /* parse tty input stream */
-- 
2.32.0

