Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0AE547CAA
	for <lists+linux-can@lfdr.de>; Sun, 12 Jun 2022 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiFLVlO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 12 Jun 2022 17:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiFLVkp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 12 Jun 2022 17:40:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5348E2A972
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:40:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 25so4887354edw.8
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0zVHGTWOUK0yHY7/MxDgofJ+b/Xb1B9oJbEk1RTZ7Q=;
        b=gKCrFNo3kTznvykOJ58dS73QN8xWLbgkEjvPMu7P0GX3Qr6KU25fZIpnewqc0feaFJ
         B/QBHD8NmlFK9oUBiJNaAdLkrVrZ5pTPmPTZIJG7ctdmND4+VeeL6dCQzxOWbTZG+x2o
         niNarrRIk6rpP0LRhpdivQKYVVzl64mtTe5GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0zVHGTWOUK0yHY7/MxDgofJ+b/Xb1B9oJbEk1RTZ7Q=;
        b=yKBc65tQjgI1eElmiUtUU4flEsmmG4F1lmhW7jpFFkJDpwhCBMqQKD7i8wfpLhvlHB
         Hkc/6+LPenzdPsmCk+gDZw1QlB1WiCpM2iSaohvZQgBdoum8DppccfDtu6oksHaqpE77
         rGv+YKPEui45eFE8J4XsMOPtE/pF0adNcBI08FgHgWqHN0mj7Bp4zED2m9cpENkBqJaW
         DaggTAXYByMaGusumnYw8FaiDWOyf/uhUlU26sYQ9UIC1bgbpZrRfHBs53i/WfwbT4YH
         jNO8Bd2QWHajL9aD6RlEk3RMZAe70FDapfz+5YTdP9NW+3NB5qN54OWmnvVraQfMFcue
         Tnww==
X-Gm-Message-State: AOAM533yekUoOtQOMlNDFUKYho6qkfY0iAfLG0Uk7bat8kkeFdFeaxqt
        q+B3ATJUeL2MWOkeyw3V/VCdGQ==
X-Google-Smtp-Source: ABdhPJwLv5x5X+tOe8+lCoVfKwj1mURnOLFqMTJ3A5RGDhSM/FYTfgbAMdlvrESeXqZHdOpkI+W4xg==
X-Received: by 2002:a05:6402:1543:b0:431:9d90:49f7 with SMTP id p3-20020a056402154300b004319d9049f7mr28466532edx.397.1655070014591;
        Sun, 12 Jun 2022 14:40:14 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b00711d546f8a8sm2909398ejh.139.2022.06.12.14.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 14:40:14 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 09/13] can: slcan: send the close command to the adapter
Date:   Sun, 12 Jun 2022 23:39:23 +0200
Message-Id: <20220612213927.3004444-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
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
driver to send the close command ("C\r") to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Improve the commit message.

 drivers/net/can/slcan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 9bbf8f363f58..82a42cec52d3 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -436,9 +436,20 @@ static int slcan_transmit_cmd(struct slcan *sl, const unsigned char *cmd)
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

