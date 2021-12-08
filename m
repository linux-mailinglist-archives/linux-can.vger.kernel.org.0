Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0746D2D5
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhLHL76 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhLHL76 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:59:58 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52542C0617A1
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:56:26 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id z8so3476441ljz.9
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZfTr4TT36cnojDeIxKkCkI/X32EvecpHr9i3AFkllw=;
        b=XohR/dYIsXmvaMuRciH0bbZv+MizsCPiozvZXrTPutx9mHo/b2MqCuk2a5CtaCWark
         gKtq2yoL4n+cHSYEp479TPYyZ/DNCpq3sZd51fLx0wWr3FPJmoyjfZGYtEMrGRe6aYj0
         tFxjsE414SZCeAC2mJGh0le4ff9OOWTECjX4eUgJgUd+VnVGkNwVaKOmR+wUHK+xsWe8
         j3pg2YfxxK654tcdWeC7aRo1owHsCHKZZ32GnznR4ayCCgvCXq2Uedgw4tOt1FAnxO/P
         fru1b9qxiAoRlk3b0CmERvBDqCAAGwN2Bf3izQ7W5kt6FMat1NMnkw85m3AP/HKXFSAJ
         VfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZfTr4TT36cnojDeIxKkCkI/X32EvecpHr9i3AFkllw=;
        b=r98FwJLzkVs2n4T4MD2JCt/dVv7s742JF0sOAZSwrPtPYTZ7kyteqWH8wr47hss2Ef
         opW9Qzt5QAZQeqwVqfWf3DlXllRgwLYPzKnysjLlt3y7VSa1oEwqaB8XDKKygS068tvZ
         j6YWERWTxtRdWBdZErr53L7A8EhGMzHrbt4JKL5tvZTZ1ZX0acykJPBADk8g+SMzyu9o
         64cFImY8t6MeAHr9AtLgmO1LE0jediv/hHoXcfyT0XJ6XDAdEq5gBzi+U+HS4Q84h77T
         D4LzXSBdTzEPFzPzZCO8jQ3/nRdf0Kj2zi2nWx2jk3EpQr9c7DNNQSCi+xVxonHGE+LK
         PK4Q==
X-Gm-Message-State: AOAM533ySeVYRbBk63Xd5wLdHxuQy4zRajGs7hnx+HULy30P81rJYGh2
        VOQ1xPAcV3yXr4yYGmTJwuopULic9B3d6g1z
X-Google-Smtp-Source: ABdhPJzhkXZGT+8yBu5YKpkSc2Jko44YLA/vRblWwu1XmZbHvUr9dBZWN1nVjAdg0TIZOKdTApI9ow==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr47852364ljd.184.1638964584661;
        Wed, 08 Dec 2021 03:56:24 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id c25sm256977lja.38.2021.12.08.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:56:24 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 2/4] can: kvaser_usb: Use CAN_MHZ define in assignment of frequency
Date:   Wed,  8 Dec 2021 12:56:05 +0100
Message-Id: <20211208115607.202859-3-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208115607.202859-1-extja@kvaser.com>
References: <20211208115607.202859-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Use the CAN_MHZ define when assigning frequencies.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  No changes.

Changes in v2:
  - Rebased on [PATCH v5 0/5] fix statistics and payload issues for
    error [1] series.

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr

 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 7 ++++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 3cbb7f3051f1..48d87758e6d0 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -25,6 +25,7 @@
 #include <linux/usb.h>
 
 #include <linux/can.h>
+#include <linux/can/bittiming.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/netlink.h>
@@ -2039,7 +2040,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
 	.clock = {
-		.freq = 80000000,
+		.freq = 80 * CAN_MHZ,
 	},
 	.timestamp_freq = 80,
 	.bittiming_const = &kvaser_usb_hydra_kcan_bittiming_c,
@@ -2048,7 +2049,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
 
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
 	.clock = {
-		.freq = 24000000,
+		.freq = 24 * CAN_MHZ,
 	},
 	.timestamp_freq = 1,
 	.bittiming_const = &kvaser_usb_hydra_flexc_bittiming_c,
@@ -2056,7 +2057,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
 
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt = {
 	.clock = {
-		.freq = 80000000,
+		.freq = 80 * CAN_MHZ,
 	},
 	.timestamp_freq = 24,
 	.bittiming_const = &kvaser_usb_hydra_rt_bittiming_c,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 47fa7f5a11c6..533e25cb4337 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -22,6 +22,7 @@
 #include <linux/usb.h>
 
 #include <linux/can.h>
+#include <linux/can/bittiming.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/netlink.h>
@@ -31,7 +32,7 @@
 /* Forward declaration */
 static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
 
-#define CAN_USB_CLOCK			8000000
+#define CAN_USB_CLOCK			(8 * CAN_MHZ)
 #define MAX_USBCAN_NET_DEVICES		2
 
 /* Command header size */
-- 
2.34.1

