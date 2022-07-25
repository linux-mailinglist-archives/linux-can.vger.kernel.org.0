Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B8580245
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiGYPyZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiGYPyX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054B112638
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so10745835pgs.3
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=kIbX0RE3RXEjraeg0bpmrGO+e05aey7JSmknIni7hX+gDXVcvo3SL0Vi77IF9LDTre
         94tCUihbpBzI8DdoUcNxIiTg054go6nsn8uR50TolD22V8nuRZttee/3FRrdOkoDxDBS
         aRhvZ09koKp1yub9NSZn0qgJ/VqeyhUVSpavkhODbl+0eEHYXaXusrflYmM3+N5gqYCw
         nQuGU2aW/W+RdwYoo5yF34x+xZrsocigo/0Ez8NQMABaANxzUQSFx65tCYvf/GOEHHLJ
         IvP+hT7wfUNqBEW1xjlC9ec7xMeJY/GU4d9OYpSar/E3gazkecPqAeOYKPvvGfaKD3EK
         YhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=w9zmAln6zwXtj/jUrDmVOlo1sHIbz76KIfIX/0FOYOc0YmNpa+rSfaIgrpxvE17mCK
         u0gVXMNZ1O2nXZOmcAvVkqomdefI5HyYzdKxAwjw0JTp7yhGTKQnE1NC8kBguoMThZjf
         OxHCfGvc+Glz1qz0aq0P8AqI12rzUzd0A1x8W/DgoSKhaBdy28yh7BLtKfbBat3jiVP6
         RJC5hgc8xU2rIgTyCnpnV6Nz4wF+gUwbXD6Mz4h08kODF8at04xSa1aAO+SGs/0gqGpM
         HY3pjRAkw1Regn1XvUBDQxkzw2XTDUsayFSZBOMpfyoDUBd3c07LuTEa5A8nmAiwpeLT
         F8QQ==
X-Gm-Message-State: AJIora8gnPpASKiB6eRUTlMiJTeuLQqOMf+R/41YR4/nPs1ywH7rD++5
        ROi7Eh6HMpBFStBwYJmaf86LeZ4iIgh6uA==
X-Google-Smtp-Source: AGRyM1tu1/1CigPwqJXqU8YnuVxzkzzCpoNGohlbCBYR2/VJbQ1UnQ1sraNbjhBmRsispcbBGjjmXQ==
X-Received: by 2002:a05:6a00:2495:b0:52b:7a9:9c72 with SMTP id c21-20020a056a00249500b0052b07a99c72mr13295317pfv.46.1658764461808;
        Mon, 25 Jul 2022 08:54:21 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:21 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 06/14] can: dev: add hardware TX timestamp
Date:   Tue, 26 Jul 2022 00:53:46 +0900
Message-Id: <20220725155354.482986-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
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

Because of the loopback feature of socket CAN, hardware TX timestamps
are nothing else than the hardware RX timespamp of the corresponding
loopback packet. This patch simply reuses the hardware RX timestamp.

The rationale to clone this timestamp value is that existing tools
which rely of libpcap (such as tcpdump) expect support for both TX and
RX hardware timestamps in order to activate the feature (i.e. no
granular control to activate either of TX or RX hardware timestamps).

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/skb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 8bb62dd864c8..07e0feac8629 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -72,6 +72,9 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		/* save frame_len to reuse it when transmission is completed */
 		can_skb_prv(skb)->frame_len = frame_len;
 
+		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
 		skb_tx_timestamp(skb);
 
 		/* save this skb for tx interrupt echo handling */
@@ -107,6 +110,9 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
 		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
 		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
+		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)
+			skb_tstamp_tx(skb, skb_hwtstamps(skb));
+
 		/* get the real payload length for netdev statistics */
 		if (cf->can_id & CAN_RTR_FLAG)
 			*len_ptr = 0;
-- 
2.35.1

