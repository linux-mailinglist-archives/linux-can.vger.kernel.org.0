Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A472D5439D4
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbiFHQ4n (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiFHQyk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:54:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA293C967C
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:51:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so42627538ejq.6
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1QllzXGCUo8JTE+hOZVBSnNVj6x3XTlbwu5/oui3J8=;
        b=PkT9jSzS4isGLZXYztnm7o7vihYHoIHdoouV2PmxWHm+ZtkDJguI+SyPGHfY3BlHN0
         eex2ws/05yiq4L48cvhQazSfP/UoXuMi+2wqtFGQAWA+C6Cu9CdGYqxHroe3UBakK7Mv
         wEzRRXTa/ZhUMrwFiKB0Sd8oI4DuYGM3i1pF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1QllzXGCUo8JTE+hOZVBSnNVj6x3XTlbwu5/oui3J8=;
        b=nTyoVP6R0nSrNyk4dLXcBs+LQsOWCUoXwysQAdzNppkgpuxJqnX7ozu/Rhxf6SrJHG
         qdSTDtpge/Bd6pvBIHm0Yj+5Zsc7wAcbkvLfnji+lYcwnmX1KIcGhA54KQNEUO6IX6WT
         JfMKYG6ehDeFePheJjMZ16ReqIAnpvkNY+gZDRUpUmwi/zMzaprfXuMJYv+kXMu9FsOi
         bu/KdzZ5k2iseHd3D3FR5uZ0ot6b6UCEB4v1FCEndX0oOhF16BtQ2a6yGzkBp8Ezml9r
         pAL6SwZdRUWFFtcBIroaw6A4K4SDdZpEjeh63hzoN3vUZk95VjWTA7uMBafhfYihiHw5
         J6eQ==
X-Gm-Message-State: AOAM533rSANmbzG/MgiCCPwgAGDP/W4UUC6ZZbMrzOKz3AMjHdoVLZ1H
        7XPSaAkMbiXgwbiVvln3aLzmdg==
X-Google-Smtp-Source: ABdhPJxJpwfsJG+G/dyZuB393+fk2YFC3C7TABhD1j9gPxpe7Tw5UdZQXyQmWlzzVjmkyyTU0PEJbw==
X-Received: by 2002:a17:907:9482:b0:6f5:171d:f7f5 with SMTP id dm2-20020a170907948200b006f5171df7f5mr33336054ejc.68.1654707098018;
        Wed, 08 Jun 2022 09:51:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:37 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
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
Subject: [PATCH v2 10/13] can: slcan: move driver into separate sub directory
Date:   Wed,  8 Jun 2022 18:51:13 +0200
Message-Id: <20220608165116.1575390-11-dario.binacchi@amarulasolutions.com>
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

