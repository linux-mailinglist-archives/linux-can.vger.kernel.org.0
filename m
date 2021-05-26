Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7470D3917FA
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhEZMxO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhEZMv1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 08:51:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E71C061352
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 16so638033wmj.5
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUrl4fnvvNKLa1rPCktyHZZm6yh4mY7qJMWTsOc5obw=;
        b=dxzupDYhfTk8UBmddpaVE4wr/pEtVwjSEWD44QwpISp79QWalcLizHUfPTjoKPeT4C
         MpncS+GMRpf8V5kNLYydQ7uL5WmbwxNvJ4Dpv8oMP25zS5nvYFPaKksDFoyow/YLserg
         KM3Pnva93blnksGWmlP8BgNZagOesmZowBIjjd3kLg1/OrGOu8A+E0tD/d4NR648UV9K
         f/MJ10oH7wPP+bKCAOvxetqZYWQrIq3+ugNoSls+uJBi7GoMgMNAFv8znKlZaBkEuLsi
         AF1UbymmuIhwvhr6ZBU9mP7e4G9dMFELMJLzeU65L4FJMMH5dwO0z9Tw2+4lVX1Chhbp
         ozKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUrl4fnvvNKLa1rPCktyHZZm6yh4mY7qJMWTsOc5obw=;
        b=Fb4Sj7huvO4cMa88iz8eV1cpHcFff3WcdyE62nAutirjUY8EsEl6AA4jLwP4VFZ8eG
         BvOCuNXvunZmtcKI+6RNwIDACcBWBoUcMdcU7y/2L3JBm8Bubg9cKzgldiIjJzgmD4Im
         bH4OtkhYob1Fle2jpnbOQdUk9NANJ4SOLpLmlrdoV7TK4LLWWnF/JBrEvzrF26UbQZ7p
         uhSnRebWgUkE7asszkhaO5bNh34LH4CuHyeJbWf6zO3739ZmDIFcMC1o21zvcUkrjQ4h
         2ZSIcpXJ74pxiLeCjm6s1oNizmHKL4Vt72fV5iVV1NWcy4kG9M3Kez7uPi/ZRNUBXt9R
         EQPw==
X-Gm-Message-State: AOAM532hsO+QVBbluXbgaSEWc73ZFuUKcUPct0aG/3IkjiumWcIUtmyM
        9wZLJLZPJS40XvdOYejTTSXSQA==
X-Google-Smtp-Source: ABdhPJxRsLCa8FjRX5aLZ/h9+NjGasQKsyNoweaYjIDboANBL7E++Z+tuE/R1+Z4EkXzjtvIVZ+/jg==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr29353326wmh.115.1622033320572;
        Wed, 26 May 2021 05:48:40 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.155.threembb.co.uk. [92.41.10.155])
        by smtp.gmail.com with ESMTPSA id a4sm1864100wme.45.2021.05.26.05.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:40 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH can-next 4/5] can: tcan4x5x: only enable useful device interrupts
Date:   Wed, 26 May 2021 13:47:46 +0100
Message-Id: <20210526124747.674055-5-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Aside from TCAN4X5X_CANINT_INT_EN, the masks used to write to the IE
register (0x0830) were all reserved fields. Remove these. Remove CANINT
also: it indicates a CAN wake event, which is not processed by the
driver.

Instead, enable optional interrupts that indicate power and transceiver
failures. We are able to shut down the device if these interrupts are
handled.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index a938dbc617e3..a300a14dc5de 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -40,8 +40,8 @@
 #define TCAN4X5X_BUS_FAULT BIT(4)
 #define TCAN4X5X_MCAN_INT BIT(1)
 #define TCAN4X5X_ENABLE_TCAN_INT \
-	(TCAN4X5X_MCAN_INT | TCAN4X5X_BUS_FAULT | \
-	 TCAN4X5X_CANBUS_ERR_INT_EN | TCAN4X5X_CANINT_INT_EN)
+	(TCAN4X5X_UVSUP_INT_EN | TCAN4X5X_UVIO_INT_EN | TCAN4X5X_TSD_INT_EN | \
+	 TCAN4X5X_ECCERR_INT_EN | TCAN4X5X_CANDOM_INT_EN)
 
 /* MCAN Interrupt bits */
 #define TCAN4X5X_MCAN_IR_ARA BIT(29)
-- 
2.30.2

