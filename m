Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFF456F7D
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhKSNXl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKSNXj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:23:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20843C061574
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id n12so43489188lfe.1
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpXm2VWU6AtyzJ08zEwdDWdDBS8kXn2fehV4Zn34V6E=;
        b=jj/H3A3gJLe4xI2han+RtuiJNdzewzMHfekMoUIt0prPsDBs6hCanK8loWL08C3uB+
         scLSahZNP9/WQDJBnqgm+xAbzsNTzkf63232gxVTuZXd0vst2TxvVI2MBx9b3b/5EzMT
         CZuM2cNKq1ffX+KkDg3Oz3OytLCadJJD667OXvy4CSOeO5qzSrOii+7ez7gIyeHuh8A6
         TvFxM92nJxCxcFayZJJNO0SYfpJ2kX2czsXmrh9vo79Wnh+f3vh+8JbHYhgiZa+QSvjz
         hw0XO95Le8oAxjbR4AcavxUIdUVcEPbcv9GTLyIR3FAavS+I5OUIcSErb+cTx2eICBR4
         yMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpXm2VWU6AtyzJ08zEwdDWdDBS8kXn2fehV4Zn34V6E=;
        b=pUpuNjFiQtLfNjkRd1K3q53xkrDvkOOXiNZ6k4Q0iUeKwJt8jU2oozbfJklEwJ7Yoc
         okhPEbcpXC3bIcZRwhdXxGGRAtxz6hbDFjtf3dkzU4g5kCG1Ns9OddmISQb1zphsPtq8
         tyQWqnpVwyI87NV3Jps6/feLR0QvmnGPwFQSgoIH/lOwHnkUXGgnzwMrRVplC8H1P4dt
         wO41ZIUR8KLkg6irGzDh3JlowADS6+FwH+FFztp1asJTPoG8Mevr/iE7mPBBnGX9yObY
         ecI5VgcrTFcX6Sadt8NoTKY/YNio8QMLvuI5epP1OABuAJhxwHLKXAP8I0vxY6wkmQmQ
         p1VA==
X-Gm-Message-State: AOAM530XdPiM51vT6FZJCZmZ8i8BwWvvopp8Ek0nLMibf1NcLRC68RVU
        aV1NowTwGI0e2rII1pDEEQesmhR+FvZav3P0
X-Google-Smtp-Source: ABdhPJy9QNI/G+13PCYYRXlRJepNbSnm4pMd+qhn2fwkVoOcQb2/VAP4pCrfc/U877MJkUfT+0F5+A==
X-Received: by 2002:a2e:a78e:: with SMTP id c14mr26249024ljf.162.1637328036401;
        Fri, 19 Nov 2021 05:20:36 -0800 (PST)
Received: from localhost (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with UTF8SMTPSA id b9sm286864ljd.122.2021.11.19.05.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:20:35 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 4/5] can: kvaser_usb: Use CAN_MHZ define in assignment of frequency
Date:   Fri, 19 Nov 2021 14:19:14 +0100
Message-Id: <20211119131915.2033234-5-extja@kvaser.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119131915.2033234-1-extja@kvaser.com>
References: <20211119131915.2033234-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Use the CAN_MHZ define when assigning frequencies.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 7 ++++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index aa81b92237ca..221339338414 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -25,6 +25,7 @@
 #include <linux/usb.h>
 
 #include <linux/can.h>
+#include <linux/can/bittiming.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/netlink.h>
@@ -2034,7 +2035,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
 	.clock = {
-		.freq = 80000000,
+		.freq = 80 * CAN_MHZ,
 	},
 	.timestamp_freq = 80,
 	.bittiming_const = &kvaser_usb_hydra_kcan_bittiming_c,
@@ -2043,7 +2044,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
 
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
 	.clock = {
-		.freq = 24000000,
+		.freq = 24 * CAN_MHZ,
 	},
 	.timestamp_freq = 1,
 	.bittiming_const = &kvaser_usb_hydra_flexc_bittiming_c,
@@ -2051,7 +2052,7 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc = {
 
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt = {
 	.clock = {
-		.freq = 80000000,
+		.freq = 80 * CAN_MHZ,
 	},
 	.timestamp_freq = 24,
 	.bittiming_const = &kvaser_usb_hydra_rt_bittiming_c,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 59ba7c7beec0..506e4b76d119 100644
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
2.31.1

