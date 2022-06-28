Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4BC55E9FA
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiF1QgJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jun 2022 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiF1Qe7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jun 2022 12:34:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB333585F
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 09:32:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so18329690edb.11
        for <linux-can@vger.kernel.org>; Tue, 28 Jun 2022 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1QllzXGCUo8JTE+hOZVBSnNVj6x3XTlbwu5/oui3J8=;
        b=DV/JgG9StAMjN5vbyosSc+Tz1ANvXg+nXIb8iIu03TwzUf+XAWtjO/GFjAG6hEeJMG
         nJ9r5+2xCIoIBz0v0nVkWT5ZJWFl0tABcnXp0o4PGc4ZPc2KnyBQdjS2Pg+9jVP6N1OI
         4U2kwYJbqS2eQPi3lDsI154EmbPK3VQz0tOiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1QllzXGCUo8JTE+hOZVBSnNVj6x3XTlbwu5/oui3J8=;
        b=a+hR/sdXIk8+9+lfsd7n0C6xGrxdjiP5Ha0cZCN1HgVZpucPUS0gjML6xr82GGvGxt
         M/EUUC0bcKr4xcOwh8iJPmmwd0f0cT/srBPAZNj9UbWjclVQK85/Gct2ezJeH65OSfYA
         xWXsIHsrbg0LX3ml71mK+g2dOEzDA/dMgQHF2m+lctWonWpz7Oe7SZQaOPcLlJhS7L39
         uz2w3ksbD0RIXjNm9pHLFu8AdDHFkQpCG1naMUVsRrzquz7nW2oQ8JQqO/ELhNHqgeVh
         Emoij/hunaDMEbktN/VSUxaEoKxpx7500onQw9diI6tjSMOchyfwVtKkxO/Q4fDBsSmG
         qsdA==
X-Gm-Message-State: AJIora9gxZwKdHZckjdYvOdDVVjDOsms9rLHVwt28SKcyi7jDH0SwtAE
        VEzAveUQaHeiSBCeEl6Xt+UKJg==
X-Google-Smtp-Source: AGRyM1s6gLZPSYO2oaziV5t5Vt0umQTthq84byZbwpX3hmbv/j6UzlpWvhzkgMgRnMCARNB87ghK4g==
X-Received: by 2002:a05:6402:43c5:b0:435:89ee:578f with SMTP id p5-20020a05640243c500b0043589ee578fmr25080462edc.225.1656433921691;
        Tue, 28 Jun 2022 09:32:01 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b0042e15364d14sm9916952edb.8.2022.06.28.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:32:01 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 09/12] can: slcan: move driver into separate sub directory
Date:   Tue, 28 Jun 2022 18:31:33 +0200
Message-Id: <20220628163137.413025-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
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

This patch moves the slcan driver into a separate directory, a later
patch will add more files.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/Makefile                        | 2 +-
 drivers/net/can/slcan/Makefile                  | 6 ++++++
 drivers/net/can/{slcan.c => slcan/slcan-core.c} | 0
 3 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/can/slcan/Makefile
 rename drivers/net/can/{slcan.c => slcan/slcan-core.c} (100%)

diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 0af85983634c..210354df273c 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
-obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
+obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 
 obj-y				+= dev/
 obj-y				+= rcar/
diff --git a/drivers/net/can/slcan/Makefile b/drivers/net/can/slcan/Makefile
new file mode 100644
index 000000000000..2e84f7bf7617
--- /dev/null
+++ b/drivers/net/can/slcan/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CAN_SLCAN) += slcan.o
+
+slcan-objs :=
+slcan-objs += slcan-core.o
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan/slcan-core.c
similarity index 100%
rename from drivers/net/can/slcan.c
rename to drivers/net/can/slcan/slcan-core.c
-- 
2.32.0

