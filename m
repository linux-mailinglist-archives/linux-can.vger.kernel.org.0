Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178E32B363B
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKOQb1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 11:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgKOQb1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 11:31:27 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA0C0613D2
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:27 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r17so16957242ljg.5
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GSsVkPYCE2oXRSPzhmyR7xL2KuHN3qLvl41XmaAEn4=;
        b=e7nirC8igAGWe39nGqu8nylaWZFiuKRLlykWmJU6B6m7A7h0MGsVleq/5Nnvxvqrs9
         u0KjeTCU2PDH30KzEnoOJArYPW+U4m83r9xMck34rXPXgw39xKrr3XGcZz6p4If8tzib
         gbn6WGfe80nGY3e4e7MoxCKkhBj8wSDfpW0OpOPBLsrgWSOxF3B+4roV5zl8v90LCHTq
         WTTTVzvYfK3bSrGamJbWPBS+qxXmfwhRPWXybncLtckllqFw5LY5RGkV+oXzYrXYqEaj
         Q1f881HW3b/PudzDLlj6+zJo+bxQ+fXxc6IGXFOjsdECN8RqjzY8dKSoApNIObpOJ0IR
         eyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GSsVkPYCE2oXRSPzhmyR7xL2KuHN3qLvl41XmaAEn4=;
        b=q9e5USZd93rx8+Q0fsIXCyCXUcvaeosaG9KM0+KJkPvZJvUdpCXdWC904EhUyFscho
         8vRx0xllTacv8tgUPTsryFKgFuVi9706aiXkUWqFLeJGkyUVes7JIcc74/aovoghdSM6
         2LacLW+AYFX9RkD+hDrpPplYB4TS6v2zzi6SbBI0xkSR3JOBNsitC8onK5ZBk9mqI9nT
         OOqI+30gwwo+owizRvkuizJ2zFgPZfY2ndCRHWy4gcO0SRbuJkyF4NWsjlu1hlViDCz1
         5dfmPc7JV7G320Oc8PkIhjuLPoyNxw5EmM7BKchZ+kozgEFGk8Pz2FMRwPfYjAtacIik
         DUIQ==
X-Gm-Message-State: AOAM530RNlkQVZzjKDXkSv2N4/uGiOwZ4tLOggtoqLsXTznbukzYEeQB
        M15SZhMz7poiRC9BR2oG0anf7Tod+oU=
X-Google-Smtp-Source: ABdhPJwRljep8lLbDxeY4NeZpil36l6ExI0yvfCfi0EvaGqIAy6fa1D5UXxxPO37HrlHB6uKO6EH5Q==
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr4894982ljp.226.1605457885330;
        Sun, 15 Nov 2020 08:31:25 -0800 (PST)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b12sm2419462ljj.133.2020.11.15.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:31:24 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 5/6] can: kvaser_usb: kvaser_usb_hydra: Add support for new device variant
Date:   Sun, 15 Nov 2020 17:30:26 +0100
Message-Id: <20201115163027.16851-5-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115163027.16851-1-jimmyassarsson@gmail.com>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Christer Beskow <chbe@kvaser.com>

Add support for a new variant of devices using the hydra platform, based on
NXP i.MX RT (flexcan).

Signed-off-by: Christer Beskow <chbe@kvaser.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 218fadc91155..980ff3acfefd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -34,6 +34,7 @@
 /* Forward declarations */
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan;
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc;
+static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt;
 
 #define KVASER_USB_HYDRA_BULK_EP_IN_ADDR	0x82
 #define KVASER_USB_HYDRA_BULK_EP_OUT_ADDR	0x02
@@ -135,6 +136,7 @@ struct kvaser_cmd_sw_detail_req {
 #define KVASER_USB_HYDRA_SW_FLAG_CANFD		BIT(10)
 #define KVASER_USB_HYDRA_SW_FLAG_NONISO		BIT(11)
 #define KVASER_USB_HYDRA_SW_FLAG_EXT_CAP	BIT(12)
+#define KVASER_USB_HYDRA_SW_FLAG_CAN_FREQ_80M	BIT(13)
 struct kvaser_cmd_sw_detail_res {
 	__le32 sw_flags;
 	__le32 sw_version;
@@ -383,6 +385,30 @@ static const struct can_bittiming_const kvaser_usb_hydra_flexc_bittiming_c = {
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const kvaser_usb_hydra_rt_bittiming_c = {
+	.name = "kvaser_usb_rt",
+	.tseg1_min = 2,
+	.tseg1_max = 96,
+	.tseg2_min = 2,
+	.tseg2_max = 32,
+	.sjw_max = 32,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const kvaser_usb_hydra_rtd_bittiming_c = {
+	.name = "kvaser_usb_rt",
+	.tseg1_min = 2,
+	.tseg1_max = 39,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 8,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
 #define KVASER_USB_HYDRA_TRANSID_BITS		12
 #define KVASER_USB_HYDRA_TRANSID_MASK \
 				GENMASK(KVASER_USB_HYDRA_TRANSID_BITS - 1, 0)
@@ -1727,6 +1753,8 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 
 	if (flags &  KVASER_USB_HYDRA_SW_FLAG_FREQ_80M)
 		dev->cfg = &kvaser_usb_hydra_dev_cfg_kcan;
+	else if (flags & KVASER_USB_HYDRA_SW_FLAG_CAN_FREQ_80M)
+		dev->cfg = &kvaser_usb_hydra_dev_cfg_rt;
 	else
 		dev->cfg = &kvaser_usb_hydra_dev_cfg_flexc;
 
@@ -2026,3 +2054,12 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
 	.timestamp_freq = 1,
 	.bittiming_const = &kvaser_usb_hydra_flexc_bittiming_c,
 };
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt = {
+	.clock = {
+		.freq = 80000000,
+	},
+	.timestamp_freq = 24,
+	.bittiming_const = &kvaser_usb_hydra_rt_bittiming_c,
+	.data_bittiming_const = &kvaser_usb_hydra_rtd_bittiming_c,
+};
-- 
2.29.2

