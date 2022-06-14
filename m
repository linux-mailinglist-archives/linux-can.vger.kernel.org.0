Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15054B0DA
	for <lists+linux-can@lfdr.de>; Tue, 14 Jun 2022 14:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiFNMaz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Jun 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbiFNM2i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 08:28:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B123E0D8
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so11367849edj.11
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7Zmyhhovdg7jA4sbkGr15373g5fZzWXwn/PzaeWDng=;
        b=oyKoCpe6Et5htQdcXy2fQRoA8XFpBI1ozrSVuX76KcLzpkF/2kSXD3WdLcabVUE7eK
         wz/QavsFVQPt0Z6e7JZF7qAuYQsULzhq2vmd84BnIiU215InQijl3uzf/UOXyQu3Sxbd
         qq2G8TGd56pKCf91XdJ6RN+wQRHq+oxfb60To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7Zmyhhovdg7jA4sbkGr15373g5fZzWXwn/PzaeWDng=;
        b=afQxtk4icfFE9xbYaB7bSWbJkbAPJ+YzjQ3NIHxsWXDqSIeZubVhHiE3Ke1f11r/vN
         Tbomg6F2edbD4v5Sd6+tzZ/bbLAGDOOcDwoNYdguY+Tt9HMURDjNa/cKMAwmqK1F5WQ6
         X5FbOoj0bbsgZPQjStVzA+b7YNtSV50kYGwa8QiOruvNEDPqksIWUjXrh61AI54MknKP
         HYt1fNlAyVOHVSM4aY8OAq7VeRA4MZ+vUbJbu59ZCqVXWnB9WbthPIDPcX7R1V3wrZgD
         cPa0hnwTjOQBKgHPlVIVs/3K4yzGthGi3ZMpuJaiQL5Sw4m+kxcC6todrihYSkOp+XUV
         wjmg==
X-Gm-Message-State: AJIora+ct+2s9ruhHaOf3nOyh4CJk8Xe5r9pkSERDWeraiBdO/8ggicU
        B+TYTPalF7MaPG50VfOJXdP5gA==
X-Google-Smtp-Source: AGRyM1t+BFdrqvcBq6yfsdEGiIsmtskF8SSI6ppRrG78PCWZDjRV1IbsiR7l22djA+NvUN8mBOynNA==
X-Received: by 2002:a05:6402:25c3:b0:434:dfbd:913e with SMTP id x3-20020a05640225c300b00434dfbd913emr5808884edb.27.1655209711597;
        Tue, 14 Jun 2022 05:28:31 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006f3ef214e2csm5087043ejp.146.2022.06.14.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:28:31 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 04/12] can: netlink: dump bitrate 0 if can_priv::bittiming.bitrate is -1U
Date:   Tue, 14 Jun 2022 14:28:13 +0200
Message-Id: <20220614122821.3646071-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
References: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Upcoming changes on slcan driver will require you to specify a bitrate
of value -1 to prevent the open_candev() from failing but at the same
time highlighting that it is a fake value. In this case the command
`ip --details -s -s link show' would print 4294967295 as the bitrate
value. The patch change this value in 0.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Move the patch in front of the patch "[v3,04/13] can: slcan: use CAN network device driver API".
- Add the CAN_BITRATE_UNSET (0) and CAN_BITRATE_UNKNOWN (-1U) macros.
- Simplify the bitrate check to dump it.
- Update the commit description.

 drivers/net/can/dev/netlink.c | 3 ++-
 include/linux/can/bittiming.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 7633d98e3912..5427712fcf80 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -509,7 +509,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
 
-	if ((priv->bittiming.bitrate &&
+	if ((priv->bittiming.bitrate != CAN_BITRATE_UNSET &&
+	     priv->bittiming.bitrate != CAN_BITRATE_UNKNOWN &&
 	     nla_put(skb, IFLA_CAN_BITTIMING,
 		     sizeof(priv->bittiming), &priv->bittiming)) ||
 
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 7ae21c0f7f23..ef0a77173e3c 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -11,6 +11,8 @@
 
 #define CAN_SYNC_SEG 1
 
+#define CAN_BITRATE_UNSET 0
+#define CAN_BITRATE_UNKNOWN (-1U)
 
 #define CAN_CTRLMODE_TDC_MASK					\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
-- 
2.32.0

