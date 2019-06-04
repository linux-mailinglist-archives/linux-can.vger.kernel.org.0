Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC35834FFC
	for <lists+linux-can@lfdr.de>; Tue,  4 Jun 2019 20:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFDStu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Jun 2019 14:49:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34047 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfFDStu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2019 14:49:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so9797134qtu.1
        for <linux-can@vger.kernel.org>; Tue, 04 Jun 2019 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kPGz3PL4NcuihogsAqKWQP21CtWJ3BVUnUOFtNrtgaw=;
        b=p5IB9/SzJVzevFf0txTxdNFiQmb9iW4dxCzE8Rj9+kdcTB5o7qJDebTfXSSosCYwVo
         J0kzgszbf28osO4ITcu1+hJHzx4srz60TOhv4h/sSiBma7xi4/6vSFQuGozmRKljMVkh
         ethHnypjUP/LwXBT+83R6sFrUxjwOWtYaHgjGENiJh8kQZdUdzBxpWnD2oz+EtUMB/Uc
         021cHX9UpnGWj1V8aKCytZLEEFE/xdEMXY12oitR1sRv8P2DzJOZ62HMhqlsWDJkZAkL
         Q5Im2RQRbMoR8N+M+AgBtcaYeMUDuuyH/Il6jwa3FYSiRdc/T5TX2fx7E6VDkRPF2TWN
         n+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kPGz3PL4NcuihogsAqKWQP21CtWJ3BVUnUOFtNrtgaw=;
        b=k63fZCos+gT8uYcILw40BpW7EUHBsG4+sJkDoq3P2tRRsWDRLRBLSehSSRGaGoWx5L
         Z+E3J96iAPH3eZ9qPDiG4vVIfAEaG6G815PvNsYxG6uJzb2+ij5BRagb0UxQQaX4QEPH
         aXroJgY2G2gO0/aifaTazXHmknW3Xqjq+DPKaKO42k6j9Edl4zj+UzNngKYn6Ag+DnP3
         zFSmQw/stUhBVRjIuyQ6wBNB7cqIppEazP2DtvD5vvyd1WtrIeH17+24wHcVPBYS9t/Q
         rX7GDqDJNOlYjZsIeVLI14xtm7xaQz9c8N/zp7ot2N+1fnFgjJvpbmx/acntpxA0fRN1
         C2rw==
X-Gm-Message-State: APjAAAUkphaIesVRC69yMghmmpq7ebktXnebnYrby3H+yhsXpYuL2KKl
        cspsMmeSW9ynNpbuS+LcQkj7vJO5
X-Google-Smtp-Source: APXvYqyEF2kIDjMqQ1Bh3I4kmsx55ZCLnfgg6JJ23JqyDSTviBeYbNTVEEMo40YZ4jO0emXOfzUWjw==
X-Received: by 2002:aed:20ec:: with SMTP id 99mr4967788qtb.51.1559674189228;
        Tue, 04 Jun 2019 11:49:49 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id 100sm10191906qtb.53.2019.06.04.11.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 11:49:48 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     mkl@pengutronix.de
Cc:     wg@grandegger.com, linux-can@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] can: flexcan: Remove unneeded registration message
Date:   Tue,  4 Jun 2019 15:49:42 -0300
Message-Id: <20190604184942.22530-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently the following message is observed when the flexcan
driver is probed:

flexcan 2090000.flexcan: device registered (reg_base=(ptrval), irq=23)

The reason for printing 'ptrval' is explained at
Documentation/core-api/printk-formats.rst:

"Pointers printed without a specifier extension (i.e unadorned %p) are
hashed to prevent leaking information about the kernel memory layout. This
has the added benefit of providing a unique identifier. On 64-bit machines
the first 32 bits are zeroed. The kernel will print ``(ptrval)`` until it
gathers enough entropy."

Instead of passing %pK, which can print the correct address, simply
remove the entire message as it is not really that useful.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/net/can/flexcan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1c66fb2ad76b..05e5609f87f8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1583,9 +1583,6 @@ static int flexcan_probe(struct platform_device *pdev)
 			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
 	}
 
-	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
-		 priv->regs, dev->irq);
-
 	return 0;
 
  failed_register:
-- 
2.17.1

