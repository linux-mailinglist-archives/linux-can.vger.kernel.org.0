Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7180C57F9C0
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiGYG4H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 02:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiGYGzN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 02:55:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B912A8A
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 23:54:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ss3so18743369ejc.11
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=42msKn5+43W2nDXBTScN29lMEs7hqwpf7Xhq17IH5cY=;
        b=DyfTiEUMRkIwWhb8HTM8IcCI9df/WFXrvhdkwpkc38iFnxOhsV9DvHvC6r8ZDWqZDU
         y4MwZUMdJV0PMhBO9bPg7N9ilwc6c9yaDV8W8NfWh69Xa1uU/tJTEaF8tcq87zznmmyE
         hEVTb/ftAGx6aOKwqol+DewRvDYBQbngIuLv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=42msKn5+43W2nDXBTScN29lMEs7hqwpf7Xhq17IH5cY=;
        b=dZN3qzyGvUQq9Tx4vWMpqG/gWQ8jDhR+oL29etpKoX0cVtHGJGGUS9E2aygPbawAjs
         PYQJ4APgyXg7vYSGQXqPCFwfG6u1aQGS6bd8bk6jFrRZ0aehDY34mx6/r5xUlUnoHBZ+
         Y4KJWFMDnSqQV/huvVnmkeCozFo0LAUO+8fLnj6OjcdOCDJ8qpgh80PDXA2PUoljdHb3
         G0C9/0714tnPmeA0AUK0N1XJUGgveyCq+Si8SfHTs/f4N3skv1wFuoFP8SCZa7FDS7iI
         yInCjOKIIxZ9n0RWfnYY0s/mqMiQAyryW6S6w9bOQ92pIU44buN6nKGhlD3X5x3bnCaN
         pOWA==
X-Gm-Message-State: AJIora836C+FIe4hTLhCqouTZA78j464ujsHdjtdL4YnpR0FRoPSY0E+
        Jyk1kCh5Yf2V52FNhAwJ/1rJiQ==
X-Google-Smtp-Source: AGRyM1vF5ZVzk0W7PV3udWbZvg9GB1BbplqYZ1ugpxe7+rKxWpYXX9OpNYUGyckInTlGzsEz7DztOg==
X-Received: by 2002:a17:906:6a29:b0:72e:e716:d220 with SMTP id qw41-20020a1709066a2900b0072ee716d220mr8674769ejc.82.1658732072425;
        Sun, 24 Jul 2022 23:54:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709060d4200b00722e57fa051sm4967711ejh.90.2022.07.24.23.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:54:32 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add maintainer for the slcan driver
Date:   Mon, 25 Jul 2022 08:54:19 +0200
Message-Id: <20220725065419.3005015-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
References: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At the suggestion of its author Oliver Hartkopp ([1]), I take over the
maintainer-ship and add myself to the authors of the driver.

[1] https://marc.info/?l=linux-can&m=165806705927851&w=2

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add the patch "MAINTAINERS: Add myself as maintainer of the SLCAN driver"
  to the series.

 MAINTAINERS                        | 6 ++++++
 drivers/net/can/slcan/slcan-core.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc7d75c5cdb9..74e42f78e7cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18448,6 +18448,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
 F:	include/linux/sl?b*.h
 F:	mm/sl?b*
 
+SLCAN CAN NETWORK DRIVER
+M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/slcan/
+
 SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 76f20dc1aa90..54f16ebd72bc 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -61,6 +61,7 @@ MODULE_ALIAS_LDISC(N_SLCAN);
 MODULE_DESCRIPTION("serial line CAN interface");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
+MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 
 /* maximum rx buffer len: extended CAN frame with timestamp */
 #define SLCAN_MTU (sizeof("T1111222281122334455667788EA5F\r") + 1)
-- 
2.32.0

