Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC057FFEA
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiGYNct (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiGYNcq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CF13EBF
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p8so10372106plq.13
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxh8NIn7rEkySjE7yYsznT2BkKzwISLwPSxvkW2bKk4=;
        b=WsorcXJC5t/ZkMcwpGKF1+84X8JOcVT76+7VsX/XzTR4lVRDUmFGvdIlklpc6qQddb
         rviSUS3CyM1xlHKoTnIJbZRvXc3pP5s4YBKsFc1tYTCVnrNL612txZEyYUP+DAkVuSya
         lfZCb0Q8gH6I5lOL24qD6pzgjfX8dV7he/Sia51kLMag7OWvYgEAjK7jyiFzhoG3tFeO
         LOryKGD5R6+zh1CbWLRM5XLN3FFlb7ipUomOuFSlactZUxRcevh0WUNbGk6lQ1lpzhfA
         RBVdesNTAew5lN9eBpDsvVjUi/TEnQJcpUft3LaWD/MJRRNHby/OcZk6O7PprgkRLK3e
         93IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rxh8NIn7rEkySjE7yYsznT2BkKzwISLwPSxvkW2bKk4=;
        b=GFXeWmbq6EGDFEbB+YlyXzme94J23DWw5WLApyEOA3GZ0ieHNE6LW/O7YWCp173Hpo
         OhIBrN66M0GxXnjveiH4hWcOQzNDD0KsgX5dwkxyW1pZ+hmkh8yzhtABdCZu1XCDdtQQ
         siFQByy5WVtZ+nfSDB/RGaZsPLO9us1przL6WWB4fzO8WX6MStvfGoaLVNa1L6HPuI6A
         YpNjws+6JVc0M/y/Rf0r0C7+3/GTHT45t/7iHYkiUIwgvQz1rTXxDqIJqIM+wDjuV8sl
         peG1g+jp/4tSy5pWTfUxvOKNlA+oZCqu8/CEwL9BgUGjGQ4cfls2tEuYZyiFyXlmHwBo
         ru9A==
X-Gm-Message-State: AJIora/24GBwlYk/eiCGxT+1DG/Fnjdh3aP7yhkVGvLmvPsMn9q0cHMV
        d07eJLwbofb27/9GdHvnVWN3xKoNERZg6A==
X-Google-Smtp-Source: AGRyM1sgeQcYCJmKyDYzgRXVbBq0dZU1jyJKzbE2w5qAJyL6FJUavjTrg8u7rgeZCfyQfD3KD3L8og==
X-Received: by 2002:a17:902:d491:b0:16c:509a:ac3b with SMTP id c17-20020a170902d49100b0016c509aac3bmr12758719plg.103.1658755961577;
        Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:41 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 06/24] can: gs_ubs: use KBUILD_MODNAME instead of hard coded name
Date:   Mon, 25 Jul 2022 22:31:50 +0900
Message-Id: <20220725133208.432176-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "gs_usb" to populate usb_driver::name,
can_bittiming_const::name and
can_data_bittiming_const::name. KBUILD_MODNAME evaluates to
"gs_ubs". Use KBUILD_MODNAME and get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/gs_usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d3a658b444b5..fd239b523c42 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -993,7 +993,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 
 	/* dev setup */
-	strcpy(dev->bt_const.name, "gs_usb");
+	strcpy(dev->bt_const.name, KBUILD_MODNAME);
 	dev->bt_const.tseg1_min = le32_to_cpu(bt_const->tseg1_min);
 	dev->bt_const.tseg1_max = le32_to_cpu(bt_const->tseg1_max);
 	dev->bt_const.tseg2_min = le32_to_cpu(bt_const->tseg2_min);
@@ -1100,7 +1100,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 			return ERR_PTR(rc);
 		}
 
-		strcpy(dev->data_bt_const.name, "gs_usb");
+		strcpy(dev->data_bt_const.name, KBUILD_MODNAME);
 		dev->data_bt_const.tseg1_min = le32_to_cpu(bt_const_extended->dtseg1_min);
 		dev->data_bt_const.tseg1_max = le32_to_cpu(bt_const_extended->dtseg1_max);
 		dev->data_bt_const.tseg2_min = le32_to_cpu(bt_const_extended->dtseg2_min);
@@ -1270,7 +1270,7 @@ static const struct usb_device_id gs_usb_table[] = {
 MODULE_DEVICE_TABLE(usb, gs_usb_table);
 
 static struct usb_driver gs_usb_driver = {
-	.name = "gs_usb",
+	.name = KBUILD_MODNAME,
 	.probe = gs_usb_probe,
 	.disconnect = gs_usb_disconnect,
 	.id_table = gs_usb_table,
-- 
2.35.1

