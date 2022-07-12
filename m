Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA54B571F45
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiGLPce (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiGLPcd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D867A238C
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e132so7888783pgc.5
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vamJgnrfzwT8m7GZ7hiPkkIVWa36uk6MV/+2rVsaG+Q=;
        b=cexG/hwGECB/oRs3SrTnUQw1J4l9afs6wGxWXbf2MohZIDgYWCLNU6kDkhzkc66h0I
         tFBQYae9zw4UvrU+f55Lq1f3j6SUkH6mBd+dCW4hCf9KrH1rGCBrHlgWGnilNfroX0jy
         HjXA/yjyE+huN1wEeDocOSawItRJCE3iVKkyuIpLlE1/xXfRfVeupAg22KpxYinMPlRs
         3UX7Pl5rXbZZDV8bHtgtQkvF+RiD4xAqYT/YNAxzdJoC/cbqZaAXFu5iOTSxZHn7R2+Q
         7XXU9XnDnj/WfZxlmytIuQzCyIY5xvkbh08FNGdPlpwXeglpAEmV2hHTanKiPfJw3CU9
         TZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vamJgnrfzwT8m7GZ7hiPkkIVWa36uk6MV/+2rVsaG+Q=;
        b=6WeZO61y0dtNFt1E8Wbe8WSl8k+1Cnb47zenVXd/JTW2KIkAkz29bJ0OsBQc9jl+x1
         mivIqPRE4R3q+USmkTw6kxoV+/e1Ax67MaXO2Cz9j/tyoWnKvPlmh3+IUig3GvDvZk3A
         TitizjVu6nKZj7DtrE5CDJ5Y8UxZDotFscXNvRcwU6WCKW/sDklmMd6LXRJQiZbMIwoz
         z/MEorVSbLmLEl4itjRGVvR30UigSIAGzRjxiP0lGAr67Yp9SxBIO0L3Gm2qeSC0ocji
         NgjL18jalG46MISf+KP+5gterrizVtsRVM3cnGpwiNdpnDU+dwM9Z3X/N+ZKuGKvZ1N6
         ftgw==
X-Gm-Message-State: AJIora8EI+5vuiFz9y321jCKnQoiTXjva2vSgFNOLdoPVPjNuu7vjv4Z
        m096wuHiqWeKPjpSvwvwKyUXZo6w14qzwQ==
X-Google-Smtp-Source: AGRyM1vqAnBavQFB7pmajfwOLPZooSHN4Zx8PRirYMyqlBhO0nEm0stPYXOauRpaEdT2MzgIjjvjJA==
X-Received: by 2002:a05:6a00:189e:b0:52a:c147:ee70 with SMTP id x30-20020a056a00189e00b0052ac147ee70mr15627597pfh.61.1657639951407;
        Tue, 12 Jul 2022 08:32:31 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:31 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 05/12] can: hi311x: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:50 +0900
Message-Id: <20220712153157.83847-6-mailhol.vincent@wanadoo.fr>
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

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/spi/hi311x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index ebc4ebb44c98..bfb7c4bb5bc3 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -667,8 +667,6 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 
 			txerr = hi3110_read(spi, HI3110_READ_TEC);
 			rxerr = hi3110_read(spi, HI3110_READ_REC);
-			cf->data[6] = txerr;
-			cf->data[7] = rxerr;
 			tx_state = txerr >= rxerr ? new_state : 0;
 			rx_state = txerr <= rxerr ? new_state : 0;
 			can_change_state(net, cf, tx_state, rx_state);
@@ -681,6 +679,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 					hi3110_hw_sleep(spi);
 					break;
 				}
+			} else {
+				cf->data[6] = txerr;
+				cf->data[7] = rxerr;
 			}
 		}
 
-- 
2.35.1

