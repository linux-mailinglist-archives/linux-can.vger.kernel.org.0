Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9F5439D2
	for <lists+linux-can@lfdr.de>; Wed,  8 Jun 2022 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiFHQ4W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jun 2022 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343813AbiFHQyQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2022 12:54:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7413C882C
        for <linux-can@vger.kernel.org>; Wed,  8 Jun 2022 09:51:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q1so42639238ejz.9
        for <linux-can@vger.kernel.org>; Wed, 08 Jun 2022 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tzR7s1CZMuNvxGPj/IhGD4aqO3yLek4cvJPPvYidL8=;
        b=nl01/m/isEBb2/WNGaE5pGOzAFS/toNd1+LgNOGNZiEkDpKuikHikABfUn9ZLLFPOL
         Gx97Wxzgo2utKjJ6X8raUKMZ81A7Is2ahwrwoU25iEOTU31KJ44ByK4r7BZwibqIoGKI
         Kv6camtC5L5z3yyn4hEue1FIxVwz9NM2rl6nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tzR7s1CZMuNvxGPj/IhGD4aqO3yLek4cvJPPvYidL8=;
        b=r955ZZQx/g7G1GZ/mWI7asPOmQXZnYNy61Hzigyxy19lbbr5W/X7eLNlOo1ns+Ay/+
         gQJjwh2NJim+xSS7eJbf5pUz2jStBuP0Yo7rD7fCgu2xLjENVmbwIvxC3Kud+WAm/FMZ
         lhf3mhRuiklJxM81ZnhvCv/d0cGtbBlDNIdefwunoyUftmqwrrWEN0qHAWLimKIf4I8N
         ittVt+A+XZVbtKqSyt+KBXxWtXFRofvtaXF0WUC0hitB0zQd9MyNCc5ACWimRlj9zo9p
         TJoqxO3Zk06j8Ulmpo7MLVHJeTwGuQCcsd3YIRKGX6gIOPiNfVZa/Zz3KrTHeqeB+OAY
         4d6w==
X-Gm-Message-State: AOAM532zOZ0Q9MsJ22Y4X3xICpXJRTlF2VrLRqonUCP+Uk2nk/tS/Y3k
        8fFbwF9QGpA7ZqafZaJblzaa+Q==
X-Google-Smtp-Source: ABdhPJwgGIMnqb4IUHl6OCZQla++DSzXUH1qm1ke5AQ6QOBqDujMj5QQe1ZbiuE8xIZN1AD0+RMe9Q==
X-Received: by 2002:a17:906:79ca:b0:705:111f:12dc with SMTP id m10-20020a17090679ca00b00705111f12dcmr32096475ejo.602.1654707096469;
        Wed, 08 Jun 2022 09:51:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:36 -0700 (PDT)
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
Subject: [PATCH v2 09/13] can: slcan: send the close command to the adapter
Date:   Wed,  8 Jun 2022 18:51:12 +0200
Message-Id: <20220608165116.1575390-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes in v2:
- Improve the commit message.

 drivers/net/can/slcan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index ec682715ce99..0722e7820564 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -430,9 +430,20 @@ static int slcan_transmit_cmd(struct slcan *sl, const unsigned char *cmd)
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

