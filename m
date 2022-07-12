Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22A571F49
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiGLPcj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiGLPci (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D945A026D
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so11773371pjr.4
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZqEPU1WDNQ8J4+T8+EKTbu2caHVGNO8vlxdrD765lg=;
        b=aHz4cTFBZnpvssZ/ubg7sEFD19mrU2QG0BaXC6vF05bi2e47t6vQ+ksgrF9gNSFQ8z
         TPQ4Tnz7H8fHiJ2/L0SAzDM0Gzkg0ajwH8oOmmZzCIe9hOmclUwTTajvkDReiXYTsVba
         Lvpc0u7jUinIXePffl1AQlXgSyVsWy9phBVHSIrLDHGOCls/wKJfbQQFiszIGKfLIFS0
         nt9mU9jA6L3Qkc3sP8LxWPZW+Ft4KICHbUkJEZAUN/dl34V4CRLErXdR00OdN11RRhC8
         aNCZY/fifrI1mu9IToIhhHbYJmC3JHCBkoln7TNFxrgs5WUOEHKYYX5lHokx7vg3TI4V
         EUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DZqEPU1WDNQ8J4+T8+EKTbu2caHVGNO8vlxdrD765lg=;
        b=5qz8Uiq3sUQBw2CQTPUd8bZ6VPqW2qZqpZMJbnHZL145L6ad+6xj0V78rz/qnGqJjE
         F3OEisiYdTNVrw94CV3rj9Odh/lBc+/HTjrg9uvQpFEJ24Os3tYZOntIA8Hhumn8cOs1
         G0M84zj+abTvCS07cNbug0PssiIJimcdCZ3VSbE3gprJBmp75NXORoUmgGe2osWodg52
         SOoJXvtXDnhT73I4M92DwnazBYVUQ+YkufkmvJtUpfKyDn6X8UWShiJKET0QuZ2oyiZE
         Z0XJiHCqdcNSI3bFTW/XOYPf+gag4ry15+GHxmJ7czw8+SflPMjnRR+CZb7KyDSL+7Wn
         2A2A==
X-Gm-Message-State: AJIora9Xw2U8wiLgdGNQMOaTKTHw43tdtcmZt15EeLz1I/xXhn2Q3057
        11m4w93dDYR6unOHDnbV8/ZOJgUVoucwNw==
X-Google-Smtp-Source: AGRyM1sEqAIPNYFhWRjgt+HBj9NLjkQZjHTIYCeme1S+MrxEduQwf5AbeVn0V0QG1jN8OC+jD9baFg==
X-Received: by 2002:a17:90b:48c7:b0:1ef:a692:9593 with SMTP id li7-20020a17090b48c700b001efa6929593mr5083817pjb.184.1657639956714;
        Tue, 12 Jul 2022 08:32:36 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:36 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 08/12] can: kvaser_usb_leaf: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:53 +0900
Message-Id: <20220712153157.83847-9-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

