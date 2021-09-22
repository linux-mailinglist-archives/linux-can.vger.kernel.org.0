Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F172841467D
	for <lists+linux-can@lfdr.de>; Wed, 22 Sep 2021 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhIVKfn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Sep 2021 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhIVKfm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Sep 2021 06:35:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0969C061574
        for <linux-can@vger.kernel.org>; Wed, 22 Sep 2021 03:34:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c22so7906832edn.12
        for <linux-can@vger.kernel.org>; Wed, 22 Sep 2021 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gy0hrvdrKMgs3UEYzYRMohXK94Pj4pVimU+FE4pAVRU=;
        b=brR113COaSfE01TrK28JHxCamHzOVUudCwPRt2YqGGJq016mkqAMoj+de6gAQh1gu4
         gtWzh59w7vE4jr5kuVH+YyGify/JKSyWbCmzU7CvGPU36V09PG/LUroYtuM0ShpOVnKy
         iOoN83/hs3B6l9zQwW/Q2lfqBk1RV58/t6E00bgfg8B1mMJH5XCwjmtCxFuxC7lAs8e9
         CGsu89RU/0owOVKqcXznbGNYp3iKaaCdPwDxkIeVKYS/gcymbsFAnr/ElWeypImOu1uL
         KzC2SgMM5YRAGULwwcZAr4wZJ6jCb9+sq7uw7XiOCCMw3yYdT4Hsmea4tNVcmmXxR68k
         Dz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gy0hrvdrKMgs3UEYzYRMohXK94Pj4pVimU+FE4pAVRU=;
        b=kCM1VQRDueHae2XlQYtZdeLz63kfFNrdG1i/V/CYUuZAjVqLKVLyjhIK7hXsqTIfXk
         TZCrwZ7tZdS+5ezCHxqEviFzT/SqSd9BSpgHrnbTjYEuVT11C8aE+xCSOXzIu+3LaRUu
         yeRLP+1CCPXnOKxliwhwNNLclywuP41jn9++Up5JG2+OChgmHrqGcsqsquTRaSqdrgsA
         EsIlkaiBWNFlwpx9kL6PU0p0H59veL4jOQMQPsqS06JlswDeuZVKfUeKdNI/C/f6Noqh
         /tY6TL2nGqZhvKOkyAkCzdkjswv0noEal6tCpS+gClbUouH/1cc5JYHehfzQWzDRSwVY
         NxmA==
X-Gm-Message-State: AOAM532Zp2UsDbXSRcqb0o5GyfEjxQ1OyjEoL4t7Y/tpCL8NVl6M4zUv
        tkH3bzDZMQmPo8gaDBQGF2fTUA==
X-Google-Smtp-Source: ABdhPJwGxeEISLOmFzWsmhonVLuiAisH5eQkUrBNFztck0LTg9TV6uzNdfR/LpfLLSa/RWOujkPnVg==
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr41028468eds.320.1632306851422;
        Wed, 22 Sep 2021 03:34:11 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id c21sm844628ejz.69.2021.09.22.03.34.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Sep 2021 03:34:11 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] can: xilinx_can: Remove repeated work the from kernel-doc
Date:   Wed, 22 Sep 2021 12:34:04 +0200
Message-Id: <267c11097c90debbb5b1efebbeabc98161177def.1632306843.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Trivial patch. Issue is reported by checkpatch.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/can/xilinx_can.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3b883e607d8b..85c2ed5df4c7 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -516,8 +516,7 @@ static int xcan_chip_start(struct net_device *ndev)
  * @ndev:	Pointer to net_device structure
  * @mode:	Tells the mode of the driver
  *
- * This check the drivers state and calls the
- * the corresponding modes to set.
+ * This check the drivers state and calls the corresponding modes to set.
  *
  * Return: 0 on success and failure value on error
  */
@@ -982,7 +981,7 @@ static void xcan_update_error_state_after_rxtx(struct net_device *ndev)
  * @isr:	interrupt status register value
  *
  * This is the CAN error interrupt and it will
- * check the the type of error and forward the error
+ * check the type of error and forward the error
  * frame to upper layers.
  */
 static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
-- 
2.33.0

