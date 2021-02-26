Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B043265A3
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZQgg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 11:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBZQgf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 11:36:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED9C06178B
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 08:35:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u14so9176531wri.3
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 08:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8HTWVAdaFckdNJ1tQ3gEcvYLom0n0d+SUvtlHF9Plc=;
        b=QSHTmmGpuBPoau7pXnAsvSdeXiQbU7eqRPdypBaUGnkMK0yS1ivvBTK+Cw0o+SP51n
         OGjO/jl1PM91udMiTiQRB3xtpESFrZb41iDA2K+OzHA8H+YjTHA7OS9ScHrreyEhkXx0
         OFQNM3Kh/ehVydCgnTtYDhNbsjb7hsbp3dN4t8F7rLre68C4pw6bYGeBeF2915/PYSTR
         FKo+JCunj7/0yb9/QpCQPudplDcEypUOIyRf/2FPpdOEo3c7sep/EjMw5ywA1OimoCe1
         wmIojKQKLQtAG9CnI5jbxqd7EL5H8Kwhc9zlfYdWWG6RsZ5eLanh8EA/6n3qW06IU1EO
         zojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8HTWVAdaFckdNJ1tQ3gEcvYLom0n0d+SUvtlHF9Plc=;
        b=fL0Gp6BOeqI/WtXSWQFdE0rnC0rAzqsLddrwaGti5BjfLNtW70A7Fu7l73+I3U9IA2
         PzvDR6j2K1CqA9q4uR/5wl8Y9pxkOhn/AEI+NFiDd60CpTOAniQlq5kQ1mVXLZ9JmwPR
         TfU9e3mniImidebvOvJDIGoBLxMQ95duRVppcafxQqYYpQu/6b2PLiycqvVJ0H5bCJMI
         7W3ZD8+mqlIj76L1mOafgmzi/0ZSKAVT+7BnzzgRkN7v+u5EOxYeR2DpuDOWs5pnvWiu
         xgxoXLOdXj5Z174DDpPBestUsgta5FCZItvKyff/2O/d34/0i1ji6P0hKC2PwNdy+YzP
         q7eA==
X-Gm-Message-State: AOAM532ceqbGfEd319Y9Q+bHxc1bCZAEHgzkYSbMrIlziA5/AIlcDzNz
        iDVuNcQucsDceArMfv26OLHy8aU1YQF14A==
X-Google-Smtp-Source: ABdhPJx7TnFdPOqexptVhTjThJEnSZkv8oLlSUJgeAcC2PwJd7AtZsd97647k29+j5Dqi+8dXWciIA==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr4150625wrf.181.1614357325719;
        Fri, 26 Feb 2021 08:35:25 -0800 (PST)
Received: from localhost.localdomain (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id g11sm1242487wrw.89.2021.02.26.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:35:25 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     dmurphy@ti.com, mkl@pengutronix.de,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH] tcan4x5x: clear MRAM before entering Normal mode
Date:   Fri, 26 Feb 2021 16:34:41 +0000
Message-Id: <20210226163440.313628-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This prevents a potentially destructive race condition. The device is
fully operational on the bus after entering Normal mode, so zeroing the
MRAM after entering this mode may lead to loss of information, e.g. new
received messages.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index b7caec769ddb..4147cecfbbd6 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -237,14 +237,14 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
+	/* Zero out the MCAN buffers */
+	m_can_init_ram(cdev);
+
 	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
 				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_NORMAL);
 	if (ret)
 		return ret;
 
-	/* Zero out the MCAN buffers */
-	m_can_init_ram(cdev);
-
 	return ret;
 }
 
-- 
2.30.0

