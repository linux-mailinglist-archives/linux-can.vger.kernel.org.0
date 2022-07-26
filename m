Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEC580EE7
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGZI1Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiGZI1Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67E2FFE2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so3010706pjq.0
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRctiSRzyghsETOoaY8xOUq19JW6ltmay8vbwPo17Ik=;
        b=cXI1TZVfLbYd92kERoe4d3dhciDa89LgXci4QubbcxgchSBzVBWbzaOqY+vmj3BZN6
         rB4PI0eFv4UTWH+PTHFwPn+4+L0cE1Vuo70yqatY99aLmhPXkI4/iK7VdKjNSlIf4xK1
         oKvpV7AvmfLmE53JFfxf8ZZm66DNDWUl8Kc9cgowXZFuGAcgwDCxJJHiFYnm2EXvLSjG
         0TOJuxGCjBNUUdcsPpbvs0Z7lVK9sLtRb8buVsepI0PB/D6H94H56lJuyrr+pcUO5rMD
         +qGW4CIP/YSmrn/kZoJ7m5o13t+848MIvrkCy3l6cc6LZKO9Z7osEXloHgqwsZTQCkeN
         YEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eRctiSRzyghsETOoaY8xOUq19JW6ltmay8vbwPo17Ik=;
        b=dull/adSF8mJ6eka4Dn5AxSr514Ub3zSK2CRF19QBeqQZ2DYH6qw5kWtE/Du8P1E+4
         SYe2YDbFuFuk8FE+8BFlkrXLFjVCe/d3FFwewd7siKmIa9vnHwDl/MNOc6AfLh8MKZme
         6niHnpWIKPcEixZaPl0ziGiuxDifph637wt/gGzahBJ/a9uakWAvT/+VGsjLAVBT9SpO
         Z5DcL7b2Zppeq3GgIdrkPiV69cNGTFLjSd3TrC06H1u/ZadaR1hKsRjWzfusSCT8cbdU
         PMW2uv1MiNNFG/MYFsSXGzRzo/nbZfvQdIR6eeE+ZToGiiGulv8uzaFI/JJIW5IJfxaq
         KU6g==
X-Gm-Message-State: AJIora/gIlXpoCZkS7Wl744DxMXm/Ir0xnppv7TDOJ4mXZGN4zN671cA
        MqCergQI8bYhjSNC/db2mBXzXj+hJuxruQ==
X-Google-Smtp-Source: AGRyM1ugbvkgOUSbsLSTtIhmKyUGrObDwQJxm5iG1WkkpXWZ97F6HZO+kTyGy16n4kHTQtbw7HLGZQ==
X-Received: by 2002:a17:90a:a40a:b0:1f2:979:397d with SMTP id y10-20020a17090aa40a00b001f20979397dmr17883330pjp.179.1658824043035;
        Tue, 26 Jul 2022 01:27:23 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:22 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 02/10] can: ems_usb: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:26:59 +0900
Message-Id: <20220726082707.58758-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "ems_usb" to populate usb_driver::name and
can_bittiming_const::name. KBUILD_MODNAME also evaluates to
"ems_ubs". Use KBUILD_MODNAME and get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/ems_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index bbec3311d893..e86a2033db60 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -880,7 +880,7 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 };
 
 static const struct can_bittiming_const ems_usb_bittiming_const = {
-	.name = "ems_usb",
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -1074,7 +1074,7 @@ static void ems_usb_disconnect(struct usb_interface *intf)
 
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver ems_usb_driver = {
-	.name = "ems_usb",
+	.name = KBUILD_MODNAME,
 	.probe = ems_usb_probe,
 	.disconnect = ems_usb_disconnect,
 	.id_table = ems_usb_table,
-- 
2.35.1

