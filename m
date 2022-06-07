Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696453FA3F
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbiFGJtI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbiFGJsd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 05:48:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDEEE733F
        for <linux-can@vger.kernel.org>; Tue,  7 Jun 2022 02:48:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so23363352wrg.3
        for <linux-can@vger.kernel.org>; Tue, 07 Jun 2022 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rU6AiPibH9nPjTI2YMHiF2ibJt+OjRoO+BIERVnAwAU=;
        b=XBJoJxny7hKfatnte2GxHsKCTr5HmbSa2HX7z2Oon+3tp6gqSpMNrsozStQxyX+/i8
         6ZBuiMvGaFnPKR7uDYIf+GZ9VlEqid4N/lJaYDl7QIzgLlD+9KO8++3nYsVmHuFgb5Dr
         yxyYAy5XHqhFLRgEfLXwEqRD4AddRRa2jY4Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rU6AiPibH9nPjTI2YMHiF2ibJt+OjRoO+BIERVnAwAU=;
        b=LEX1EL0XHS6LsjaipstiO3+TwV+n0K/t2rba5X6jLfzwJCi4ErP3YD1aI/Ha9O9gx0
         qzHnc2bDj0fRoxpikjXUt1nHs3vjaiIZ/Bmqqt4SFiuE4M3rvdpcbYM9s7lrnDRMnRUu
         MILs9kJG6t7ObkiTdbb0prFZu8U2nrkWApP2osmC/evAUjt43taEb91ByV9yICXMBKNR
         0IO1wNkVo9Lf3pRpJveu7m+lTGM/yNoNPkKZKGJ54pPv9UC4m5GgpPP2NefvPpF/M2C+
         IOFs4P4RS0fRlG4zzyIvrowBUcgWBN2KZ9aCjHpBVZNZuOsPS/f2TymWb+5YT/I8d+kk
         wq4w==
X-Gm-Message-State: AOAM5329GymeJavw4ScEVh5cST0qy8/N02cerx3UlAn0aNMwVhf0TWcs
        ojlpFrveFG7HWTMO7jB2AH1eCQ==
X-Google-Smtp-Source: ABdhPJxWpSQZMMlLoNuWN1W3nkSA26lOK6DFhDAfwDjaK3p3poJehcnXzGH/UYToEGi2OU6/PPSoEA==
X-Received: by 2002:a5d:4572:0:b0:213:bb00:86e6 with SMTP id a18-20020a5d4572000000b00213bb0086e6mr21860193wrc.284.1654595307649;
        Tue, 07 Jun 2022 02:48:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:27 -0700 (PDT)
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
Subject: [RFC PATCH 09/13] can: slcan: send the close command to the adapter
Date:   Tue,  7 Jun 2022 11:47:48 +0200
Message-Id: <20220607094752.1029295-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
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

In case the bitrate has been set via ip tool, it sends the close command
("C\r") to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index f18097c62222..d63d270d21da 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -438,9 +438,20 @@ static int slcan_transmit_cmd(struct slcan *sl, const unsigned char *cmd)
 static int slc_close(struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
+	int err;
 
 	spin_lock_bh(&sl->lock);
 	if (sl->tty) {
+		if (sl->can.bittiming.bitrate &&
+		    sl->can.bittiming.bitrate != -1) {
+			spin_unlock_bh(&sl->lock);
+			err = slcan_transmit_cmd(sl, "C\r");
+			spin_lock_bh(&sl->lock);
+			if (err)
+				netdev_warn(dev,
+					    "failed to send close command 'C\\r'\n");
+		}
+
 		/* TTY discipline is running. */
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
-- 
2.32.0

