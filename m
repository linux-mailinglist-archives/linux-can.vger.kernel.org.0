Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D858E57703F
	for <lists+linux-can@lfdr.de>; Sat, 16 Jul 2022 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiGPRAg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 16 Jul 2022 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiGPRAZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Jul 2022 13:00:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280381FCF5
        for <linux-can@vger.kernel.org>; Sat, 16 Jul 2022 10:00:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l23so14071978ejr.5
        for <linux-can@vger.kernel.org>; Sat, 16 Jul 2022 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHx3+JjARcVqLchAq3IBsPDCyyKS9HCXdr7RVf+WDMo=;
        b=mGoolG7fvxZVYt4/cOxod+dCqrOJ8LVz2j/jFt4HPC6fRE4doXmY2PMHp7wEwzmXpF
         Njm/1kC8mhEmuFQ80OpE+7FDElhEELWtuK8WntfnFda/c27FwckO5ngy2VPCZLzck1lf
         iyQuAu7VgiTKj1ldNuqE7UbT1Y5/avPsiv4ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHx3+JjARcVqLchAq3IBsPDCyyKS9HCXdr7RVf+WDMo=;
        b=T1GpP9aoq/UzeiHtpTj2/UlsTCScEoylI+aNLOy5Yj54fsyPi/JvD4TLJOOdStNWpN
         H8dHCizEVjAFWplgoUpuoxU3lPZ7hh91OwY/SQ6rewADnqqVfDdXcOo3ABnHna/IO8QS
         hXUWOaoKuwVZFJJDblmzbDz3J3smrPt43Y8HlptMNOop1B5+JwhuGQEFaqe+pI82Bn10
         r6RrS4pLDg+0ZIPFoLmOA1+YlxWfbbgIuoncskYgo+mOcW6cTnOhF75x52HX4Fz1X6DH
         kmzaXHa1Hzdcv1zQGcP7qBoNbDujanvPeXEIj+3bB+igZbSwVvdrN1I1RKTs0KXelQ+p
         5EHA==
X-Gm-Message-State: AJIora8jfz5Cmrv0qSpr9ZSYVoKaZwIqaeWEjNQS/7VkfEhzj6C6/W+y
        S4mTqrdHvnA+kLNGSUZnA/50Bg==
X-Google-Smtp-Source: AGRyM1uF88RQH57CRh5vVpqwIC3K2c4oCtDjWaX27PtCv7WQqDeB376TmsjSDwXoYH10UWprZZS6yw==
X-Received: by 2002:a17:907:7294:b0:72b:1ae:9c47 with SMTP id dt20-20020a170907729400b0072b01ae9c47mr18608911ejc.253.1657990817736;
        Sat, 16 Jul 2022 10:00:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm3363135ejo.103.2022.07.16.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 10:00:17 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 4/5] can: slcan: use the generic can_change_mtu()
Date:   Sat, 16 Jul 2022 19:00:06 +0200
Message-Id: <20220716170007.2020037-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
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

It is useless to define a custom function that does nothing but always
return the same error code. Better to use the generic can_change_mtu()
function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan/slcan-core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 093d232c13dd..7a1540507ecd 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -727,16 +727,11 @@ static int slcan_netdev_open(struct net_device *dev)
 	return err;
 }
 
-static int slcan_netdev_change_mtu(struct net_device *dev, int new_mtu)
-{
-	return -EINVAL;
-}
-
 static const struct net_device_ops slcan_netdev_ops = {
 	.ndo_open               = slcan_netdev_open,
 	.ndo_stop               = slcan_netdev_close,
 	.ndo_start_xmit         = slcan_netdev_xmit,
-	.ndo_change_mtu         = slcan_netdev_change_mtu,
+	.ndo_change_mtu         = can_change_mtu,
 };
 
 /******************************************
-- 
2.32.0

