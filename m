Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628383B40C6
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYJrf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 05:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJrf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 05:47:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A36C061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:45:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u190so7138619pgd.8
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ef74WCQcoNPuOJZdJdrC7QS0++vM5J/kljlMH1uu8Y=;
        b=GwoHnQPuq7wHvqxJKNJFhLyA2fhk9GNPqYkS7Ji7SNrDebBTV/szg0tmDAnAUABUR4
         pmhLr6IMkBSCxTFQiY3JQ7x1q5v+uc0o8d//UsAOXmiEEn5hKVw3gn95S9cuNDGPevay
         a6ud5/kOWwaTG8eDEzfx2qKjuVnpf1/JbXXkG0s8XPtOLss9MLk4gi2q5dmYneAQCO+M
         rmQpIu8iFutw6Ah4mcmY5nHokX+5GnKhRXkXph023fzwsYZww2PqIm334EAYpgavSOR3
         aPZ21aaFGTR0HwXoCgP7sa8yPHIWNp3HqMbpoVxw029eCoKUy7PUOp51AAuj5Aj4HOoP
         6gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Ef74WCQcoNPuOJZdJdrC7QS0++vM5J/kljlMH1uu8Y=;
        b=HVKh1sOab0fJjAyv3y7Y9QqhuyhECMTN0KvbJGtf4Z+VWJMVJSYV3EuUBM/fnnfLY7
         y/b3z4NqWx3VPiXKI2Jod2OkXZKk32SbVdjiu97jzDDd0tEf+hUwNFxWGmBQHE6qkp1N
         9lElKRU8/bh6MAObRe5QAbvuMq+WbfyFtsDNKhmhQZioo/mqfnoD4M+O3w7CodZiMQr2
         a1BwVcU5fkpnfKlKfvtyzndQx5MQmztik5bwBkleh9dtd6V/p2DyoRpALiYkr66CRGGL
         gWb3RwgyWtN5WfjNuvyL5fgmoZe3f1S4Vs6PGfG+hkgyCtRfxMy/KpEj3ibKd0N9uO40
         RkJg==
X-Gm-Message-State: AOAM5328HzgABYNPdYzb9YoieterRTBI0SaBs0S/hpzhcPWc9CbREftl
        KmGkY9fGuuciq0EekAAaWwI=
X-Google-Smtp-Source: ABdhPJxJHi1itbvsto33Verjj8P3EKM9J1YWps+rmB3plRZGhyZRRbZYq1JEgTLKBrihEqCQ5GeRng==
X-Received: by 2002:a65:5542:: with SMTP id t2mr8850441pgr.358.1624614313350;
        Fri, 25 Jun 2021 02:45:13 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id h9sm5027280pgn.57.2021.06.25.02.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:45:12 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     wg@grandegger.com
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC CAN controller driver
Date:   Fri, 25 Jun 2021 17:45:00 +0800
Message-Id: <20210625094500.13234-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC CAN controller

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Kconfig b/Kconfig
index 1c28ead..6b2175c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -167,6 +167,12 @@ config PCH_CAN
 	  is an IOH for x86 embedded processor (Intel Atom E6xx series).
 	  This driver can access CAN bus.
 
+config CAN_SX2010
+	tristate "SUNIX SDC CAN controller support"
+	depends on MFD_SUNIX_SDC && HAS_IOMEM
+	help
+	  Support for SUNIX SDC CAN controller.
+
 source "drivers/net/can/c_can/Kconfig"
 source "drivers/net/can/cc770/Kconfig"
 source "drivers/net/can/ifi_canfd/Kconfig"
-- 
2.20.1

