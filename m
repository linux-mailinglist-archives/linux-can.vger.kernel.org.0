Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D157A1F6
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiGSOks (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiGSOkR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:17 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8852125FB
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so7458240pjl.5
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZqEPU1WDNQ8J4+T8+EKTbu2caHVGNO8vlxdrD765lg=;
        b=fYvVPUDqfTzzOOO1K/sNhnc/daKB+2U03y7rzF9Et89ziNk7WIj3QHc2lO+D/lLlOY
         qxF8NQV2dX7D2UeHBVdf69cftDh3uvq4HB62fgeLT3d+MTELEhOfbOAuiDsQ4F51Ad3W
         /5elRq2cAMbpwf8T9HyboCrQUynygSqHraQT0Zuyf8/HwPExPL59sYbaylFbzZM7v9x+
         JNo2NAGp8m2i1HZS/3AfMkKnb/s6axYTymdQwBwo32npQF4Shkx1JG77L6ehLiqy6HRB
         ca49HM3ti7cC4BD/FNE8CE52y9CigsAhR11fvo8Xw6Kv/MRwf2tJ+NXzd0l0YPBQfUx2
         EYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DZqEPU1WDNQ8J4+T8+EKTbu2caHVGNO8vlxdrD765lg=;
        b=5QdYH4XPx/y0UIpmkMZJNnXuniDujdBBJCQSWiUkbjWfYD4nj7hzAddmMFVat0uqZd
         UsnxZbYAxp4xLGnw/7K6mEkx6SjydRK28+mzqy8fCggVP2bl7OvURfpP+/jIRJKiZbxe
         PRya5jQLigMDQiZZHECZFIAW4ckoXTIapebu+lXdBvQu9zFp6F+ALovV/EOK57HSrZoI
         +2Mww8wQfyfPea+SsozI4yc/BDblrQIAgst/ib2QOS0Zdh9vzkBFgReNvw8T0s+gVwF9
         2cFqQTZXGpttnzT3cEAQp95KnOxzxjsjYe9ebSIZM04CElDfa8Se7lpkhcKamJUtLQhV
         sMQg==
X-Gm-Message-State: AJIora8SKidVp3lGZ96jPRMFNJUq7F6o4yBZGpkwcHHKpxS0Pd0FAzGh
        K3eXB6ow56NARKo+b/ZxXFJQe8FmjcMZdw==
X-Google-Smtp-Source: AGRyM1uCMbSjsdJdq70wlFwan/EitnSW8JZKN4eybbQ3pnLeWJ3V7/F6JUhr1LSoKH7paVVDEq94tA==
X-Received: by 2002:a17:903:3093:b0:16b:deea:4d36 with SMTP id u19-20020a170903309300b0016bdeea4d36mr33627481plc.126.1658241377859;
        Tue, 19 Jul 2022 07:36:17 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:17 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 08/12] can: kvaser_usb_leaf: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:46 +0900
Message-Id: <20220719143550.3681-9-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
 <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
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

During bus off, the error count is greater than 255 and can not fit in
a u8.

Fixes: 7259124eac7d1 ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
CC: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c805b999c543..088abeae30ad 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -836,8 +836,10 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		break;
 	}
 
-	cf->data[6] = es->txerr;
-	cf->data[7] = es->rxerr;
+	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = es->txerr;
+		cf->data[7] = es->rxerr;
+	}
 
 	netif_rx(skb);
 }
-- 
2.35.1

