Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3BD46D1B2
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhLHLNe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhLHLNd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:13:33 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8289C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:10:01 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z7so4824349lfi.11
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keRgniak/LbDlkK4peu3rh9bnq3GVVxsAp0KGVxGs90=;
        b=xTVJNviixVjAAn+xcGuTWAf9C6q7ptuVa6QSCu6OGkm3tZjlL3LIS2ge2t70tA/lRA
         pqHYgTYQSMNlqdtCQvW6RHTyZ24yNKkBcZ9ounxwcjmxCdYpAKpW1VMMbSsy3iUJFS2F
         Irx7bSoqclhtd9k4gyAl10llt0bHZhpset2rksR6EfYtbozyCU3xobrr9YSWlWPveR+9
         jr0GaJChDMuyFF3WjNFGzaJtst8ETx+OL5Ra2n4iyAtY2XqzLhlnr3cecVctZqbvdWxu
         BdEg+kPQFvryjCCbvdX+fJ5AfcDfQhD2RqmGBRDA39UDEw1WawkLAj+oJWVSkvqLHSh7
         k6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keRgniak/LbDlkK4peu3rh9bnq3GVVxsAp0KGVxGs90=;
        b=zDUVbPAxvlC5G2yJd57bCAKWt8vZFcSmhcpc5BdZy9/yIT/5DCEKm2WP2f6WwQN7J9
         rhh37giqgfRQEfdz3gPs95hNDgwPtTVCZhvviacsPXjDOR8C3vGlDk1+VorKC7Dt+QMe
         CiA8pdctvA3MK35c/k5fmAkIusfVBAotDSWLEAkWY74/gvzeIiwsxn2bBdI03N+W/EGG
         nTdunyw298r1pO5ySUi1Y7mb38FerAMzsdfMmFZhvIAfDcwMt6MKFUARC0uh3UyAUMmZ
         PBOB5Cv/sVK+w9J3hyfSByb6pJg1zYjw24tZy5qxo1kwy59C1ZZ8eChpu5Jf8g0G5qPR
         IycQ==
X-Gm-Message-State: AOAM5313DWva0w71o1N32aTKYZkAqtUEJwIHV2Pfu/rzFa6UoYJWGNBx
        KecyLDGkKAtGtQbgA2U/+N/Xgv6oGa5JQRC4
X-Google-Smtp-Source: ABdhPJwa5HU1Hah1If2ZKrshtd2MpZqe4v17ey0RXFjcv1h0KfG0Rb+P7vF4jpFuiqrZiVjNhRSrEA==
X-Received: by 2002:a19:6454:: with SMTP id b20mr47017323lfj.469.1638961799964;
        Wed, 08 Dec 2021 03:09:59 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id q6sm223786lfa.133.2021.12.08.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:09:59 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 2/3] can: kvaser_usb: Use CAN_MHZ define in assignment of frequency
Date:   Wed,  8 Dec 2021 12:09:39 +0100
Message-Id: <20211208110940.185629-3-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208110940.185629-1-extja@kvaser.com>
References: <20211208110940.185629-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Use the CAN_MHZ define when assigning frequencies.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
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

