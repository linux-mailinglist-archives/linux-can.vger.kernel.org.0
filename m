Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0CE57A1EA
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiGSOk0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiGSOkG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3C3DBC9
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso21546914pjc.1
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfloflcr6GeunKX6dITsf1MVbmVF9Kn5MVpeW2/yFrE=;
        b=OlHp7UDaw9hiJMMOSd1SO2u2/LS7nxSOA3ocqVqtsZtfvj57qlwlCL2VXQYfWH3tYP
         1kLRpkqF4W6sAdTDZYEoWE6tBk8HTc6IgStK7/I9q6ph1VQOcqGtMhDUoSH6ZVrQ/E+J
         dnVoFVYLueBV34d6ovqv/VjmBujuXluUihU36I1eQvyn/NCqQSaA6I+8YB5VsfzAFbgk
         KmuM2mRfHVFce/0VHWbpKdX5AsQqt3j7oFHAVFRGUvJ4eK+dRmuTlXbyVAwonawFuaYj
         Ea2Bo+IH16QYYrJowzPe7jwnq3syFrBwWe4HNWEdNq0z6/s2q6VUJrS+2MM/Wkj2un0D
         /yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bfloflcr6GeunKX6dITsf1MVbmVF9Kn5MVpeW2/yFrE=;
        b=jXoHquekUCqzL7dqMoJIioZKrltncHn6DOq6pgUOaliqOzhexsmrS13kX0CJ6HzydK
         WGoW3Vhs69EcamPTsZgf4Hc39E0RJiWimZrCyj6evlY56kNBZYgFF6f8GLgg2h996DUG
         yooHMme1S/NVU0MsNds7Xth6U/aQPJZp1fDvfzbP5OyZcgwb2+IHXvdq/1k+1crP9LM0
         SiroI/BkPV0Hpr8aDWkbsSKM3/M+vx8lNIURUTXns9fSHLLxnd5PSeiHDdxm/ZHSDdkK
         J3m0wGPTyG1DD6AV5TQ6oCBt1m9TiByboGdrfaRSgrTXY2DR+wEWN3uar1l/4I7FTf2P
         SXXw==
X-Gm-Message-State: AJIora8YDK8MZnVzXaCDCR5V/DDlTPgb+I89oZ9GSwilMfscAMthpWQa
        DXW9uIWhAoGYKlA13FtK+Hu4zRzmRlI=
X-Google-Smtp-Source: AGRyM1tHD+M4+2zi1DyiQ7v1LDWdPrW9x05Cojz0TGeUd2jFVxUe5PIPnySm1/rG6H9RAUgd1nrzWg==
X-Received: by 2002:a17:902:6ac5:b0:16d:1664:39c9 with SMTP id i5-20020a1709026ac500b0016d166439c9mr1528201plt.104.1658241364840;
        Tue, 19 Jul 2022 07:36:04 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:04 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 01/12] can: pch_can: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:39 +0900
Message-Id: <20220719143550.3681-2-mailhol.vincent@wanadoo.fr>
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

Fixes: 0c78ab76a05c ("pch_can: Add setting TEC/REC statistics processing")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/pch_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index fde3ac516d26..497ef77340ea 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -496,6 +496,9 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		cf->can_id |= CAN_ERR_BUSOFF;
 		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
+	} else {
+		cf->data[6] = errc & PCH_TEC;
+		cf->data[7] = (errc & PCH_REC) >> 8;
 	}
 
 	errc = ioread32(&priv->regs->errc);
@@ -556,9 +559,6 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		break;
 	}
 
-	cf->data[6] = errc & PCH_TEC;
-	cf->data[7] = (errc & PCH_REC) >> 8;
-
 	priv->can.state = state;
 	netif_receive_skb(skb);
 }
-- 
2.35.1

