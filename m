Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E795824C9
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiG0Kt5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiG0Kt4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:49:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E952613C
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 17so15824347pfy.0
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EbiOiFF/9P5FcIKX3oR0MccYxIjApSG+xgxsu5PhJJ8=;
        b=Dc7eFD9UZSyuyEktp0N+mVRwBvek+1xq12Vgp3pKpcFw+QVwV2TKlF85GPtSYT+baK
         1C3KhsHdRHu7HW2gYmMyQ+9NMz2I1OvvgatnExJ0o2/z3fTTeLvK9cs5L4wzs48Ry0AY
         xG3iyLqRBCAPCOnq2wLrhu/RyQjI/0H+3wXfpZ844xYifYTATA2bU3jMD2lV0QJwuehW
         m+92Xj864JBa5sU4CZUgeUb5aXUc/Gh7K0urfXodv8fqGTIs5t3UxU8RBDycw4FTSce/
         9VT3DNz1KNupI4l4vWP10Nm70Z+Gp8Oe7Ddm12hGiAsyd+857eZF8mjjc2PIqaFmtz/i
         YWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EbiOiFF/9P5FcIKX3oR0MccYxIjApSG+xgxsu5PhJJ8=;
        b=yvgMNMrlz0wywPBxRW7YQuQYqK52/ewrSvlV1/LXf5CYNtrlYgZgVSTE+OZqwqtrqo
         /ctZcVjkpWeLOE1xddjBs0qRmXXQ8WanvpJevN/i1dzythJ2mPCjE23dGF7F0a6LSZ5X
         wYLSYmGZlTEOvL/mlV1PUgxrLqUTgXRfuvP2gJwcRGRGGmcZbsDyUx1yWUT45v5/dQWz
         TSWUCosOYWKXn7pmNS0+nAif2uE3rcGKQkBU6u836+uNt1pJKN6w4HmnBZhBqZeJET4C
         cp6jCHzFeCDyLw7u0Pf20FaNIxImJ9UhZjV7dmVnXc/i3DxtsaK7Qeb3FqDu1huN2skW
         LXMA==
X-Gm-Message-State: AJIora8kxP1tWTfFhqX8/90FkFVkkquEabObG+3QLRiCEM2jNdGWW1SA
        6LK9ASdluX2PeOC9/eXSEnQrrbEig28=
X-Google-Smtp-Source: AGRyM1tCXzvX+PpbjYt+U6TCT5NjhbQo0C06Kwa5xhpABFEv9DTHyjHQtFzFt13oqJ0xINHw/k299Q==
X-Received: by 2002:a05:6a02:310:b0:41a:19a6:3281 with SMTP id bn16-20020a056a02031000b0041a19a63281mr18731388pgb.412.1658918995059;
        Wed, 27 Jul 2022 03:49:55 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id o19-20020aa79793000000b00525343b5047sm13526114pfp.76.2022.07.27.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:49:54 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/3] can: slcan: export slcan_ethtool_ops and remove slcan_set_ethtool_ops()
Date:   Wed, 27 Jul 2022 19:49:37 +0900
Message-Id: <20220727104939.279022-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
References: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The function slcan_set_ethtool_ops() does one thing: populate
net_device::ethtool_ops. Instead, it is possible to directly assign
this field and remove one function call and slightly reduce the object
size. To do so, export slcan_ethtool_ops so it becomes visible to
sclan-core.c.

This patch reduces the footprint by 14 bytes:

| $ ./scripts/bloat-o-meter drivers/net/can/slcan/slcan.{old,new}.o
| drivers/net/can/slcan/slcan.o
| add/remove: 0/1 grow/shrink: 1/0 up/down: 15/-29 (-14)
| Function                                     old     new   delta
| slcan_open                                  1010    1025     +15
| slcan_set_ethtool_ops                         29       -     -29
| Total: Before=11115, After=11101, chg -0.13%

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/slcan/slcan-core.c    | 2 +-
 drivers/net/can/slcan/slcan-ethtool.c | 7 +------
 drivers/net/can/slcan/slcan.h         | 3 ++-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index dc28e715bbe1..6162e6132ea4 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -866,8 +866,8 @@ static struct slcan *slc_alloc(void)
 
 	snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
 	dev->netdev_ops = &slc_netdev_ops;
+	dev->ethtool_ops = &slcan_ethtool_ops;
 	dev->base_addr  = i;
-	slcan_set_ethtool_ops(dev);
 	sl = netdev_priv(dev);
 
 	/* Initialize channel control data */
diff --git a/drivers/net/can/slcan/slcan-ethtool.c b/drivers/net/can/slcan/slcan-ethtool.c
index bf0afdc4e49d..328ae1fb065b 100644
--- a/drivers/net/can/slcan/slcan-ethtool.c
+++ b/drivers/net/can/slcan/slcan-ethtool.c
@@ -52,14 +52,9 @@ static int slcan_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
-static const struct ethtool_ops slcan_ethtool_ops = {
+const struct ethtool_ops slcan_ethtool_ops = {
 	.get_strings = slcan_get_strings,
 	.get_priv_flags = slcan_get_priv_flags,
 	.set_priv_flags = slcan_set_priv_flags,
 	.get_sset_count = slcan_get_sset_count,
 };
-
-void slcan_set_ethtool_ops(struct net_device *netdev)
-{
-	netdev->ethtool_ops = &slcan_ethtool_ops;
-}
diff --git a/drivers/net/can/slcan/slcan.h b/drivers/net/can/slcan/slcan.h
index d463c8d99e22..85cedf856db3 100644
--- a/drivers/net/can/slcan/slcan.h
+++ b/drivers/net/can/slcan/slcan.h
@@ -13,6 +13,7 @@
 
 bool slcan_err_rst_on_open(struct net_device *ndev);
 int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on);
-void slcan_set_ethtool_ops(struct net_device *ndev);
+
+extern const struct ethtool_ops slcan_ethtool_ops;
 
 #endif /* _SLCAN_H */
-- 
2.35.1

