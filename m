Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850F85439CD
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiFHQ4P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbiFHQyN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:54:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC33C8817
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:51:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o7so9330222eja.1
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHEZAJdjR8GiF2rcZjyRDsrMR8WF0LYSErHxMnZ6s20=;
        b=MZKbWtENK8RJ8mhEjef9zX1yTSZS9BgXM713QnAIg2L5afXoz8jXYkkuBHY/6qGvq2
         Xe/QJ8v++KscQsY1vp5+FFXyjT5O8ONPWQHFmXAXNoZICKoiCOJhQrjDn+sSrZffVhnr
         COMtwcIGOuyD8SJi3niX6Nfuh82Vs1jbao2PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHEZAJdjR8GiF2rcZjyRDsrMR8WF0LYSErHxMnZ6s20=;
        b=V4jknxXpIgrwNG6qOzuHVv89LI2cu7R4Y0poBL8mkswSi9BH5h0syeSn0gYF79vGWF
         N7BIk/CsH6NhIOFvKwRJ9+SaLtnFgcXo7e9qdZ3nd8KRaZAaY7l4XsNASimWgFWTaR3C
         REUn+bixaSUo5Z6pw+aDqyJdkKsLfAikqNA1fiT5LGuVS0lsOnRfikdkRSTXX2sYcDKw
         RLZiUq/cScKL1e39/cc9/Iz1lYUNABEZm4NcvkF2g6LPflUxt/bRTud2LaK47edGt/aR
         jnfc8M3URuHBLWot98uCFt+t9QbUGf01+kkvT2MRMeHlu8XxL4I+lFYaU/zW5rhamuYv
         73bQ==
X-Gm-Message-State: AOAM5319B+iG1Kp51B2csTvs0aU992y5a4m+WY5MRrx5nJZJHzDq9px3
        +pweNfZtfetOl73RfSsrpygJtg==
X-Google-Smtp-Source: ABdhPJz1QODapFEAg4YigkTF2RHGdIx+/6uauzW1WsQ+9FsAAZvY0lK1/PlsjrZhGolAZLbjarVnZA==
X-Received: by 2002:a17:906:4a83:b0:70b:156f:9098 with SMTP id x3-20020a1709064a8300b0070b156f9098mr31951137eju.109.1654707095099;
        Wed, 08 Jun 2022 09:51:35 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:34 -0700 (PDT)
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
Subject: [PATCH v2 08/13] can: slcan: send the open command to the adapter
Date:   Wed,  8 Jun 2022 18:51:11 +0200
Message-Id: <20220608165116.1575390-9-dario.binacchi@amarulasolutions.com>
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

In case the bitrate has been set via ip tool, this patch changes the
driver to send the open command ("O\r") to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Improve the commit message.

 drivers/net/can/slcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 8561bcee81ba..ec682715ce99 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -461,8 +461,15 @@ static int slc_open(struct net_device *dev)
 	 * can.bittiming.bitrate is 0, causing open_candev() to fail.
 	 * So let's set to a fake value.
 	 */
-	if (sl->can.bittiming.bitrate == 0)
+	if (sl->can.bittiming.bitrate == 0) {
 		sl->can.bittiming.bitrate = -1UL;
+	} else {
+		err = slcan_transmit_cmd(sl, "O\r");
+		if (err) {
+			netdev_err(dev, "failed to send open command 'O\\r'\n");
+			return err;
+		}
+	}
 
 	err = open_candev(dev);
 	if (err) {
-- 
2.32.0

