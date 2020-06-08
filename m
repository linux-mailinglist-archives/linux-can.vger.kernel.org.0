Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1DA1F15BF
	for <lists+linux-can@lfdr.de>; Mon,  8 Jun 2020 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFHJoW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Jun 2020 05:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgFHJoV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2020 05:44:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F94C08C5C3;
        Mon,  8 Jun 2020 02:44:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so14651714wme.3;
        Mon, 08 Jun 2020 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXI0Z0J/4ooSNFN2GwSVlyNdAvGywcRXeFQ5674Mtzc=;
        b=r4puKIU7t9t/z+Akeod8D0rhFdVAmL/DY1c4jq8ct0lJu6WcDcmDglH2T3nsaLueoh
         FYqSCosvbu7c0507caUgc8lPWCxfNOJBR1NNb+E9V2372WvWAqBrSfgKH0+uRFP59I6m
         OrY4syPydx3wueiiSOjsaeEfC8VD0l57zSAuCbHlyOpVnB5qrvDsl1rrS0yc3xht9Q98
         eqqxs8zSHCyrU4X2e3+7YJKeCai2Ux6gFUS2KzsfjiPFzapXmPMBixsnWTXtKGSTMWwq
         8NjaS5aZSDjHwq+j+4zWD/pj/BUNzIthnKixB0NCrgvuy7u2NoSrqk/UBmGnsZcWOV3W
         P4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXI0Z0J/4ooSNFN2GwSVlyNdAvGywcRXeFQ5674Mtzc=;
        b=BOuc6YuXwAAX4zEx0DPo3tmH5jGNt3/rNMMJzBqOWccFl8Hlm4KLidfQ/rcQoCNQV8
         s6lwpz44PVqAd23mEcS9tocwccSeSE3ZnHOyLQ6CTPiD8Om3P902eJfDrRqGOeL0fEYn
         thhYOeYqW5yzyOrtmgKHxGgDDhJDeXMqW24SgiQMEdftMRy0hgl+Xxofttfv0zYpqxJL
         ZOSM9UsaChTOV7YfTNmPEQTvNhgTtB0DNTX0mqGZyeTIO5rs3Ti0zYEv8pSiJTH3zByJ
         PSjgIaLx1YDhKgY3JvJ2KUlrdhRui9fwvxJt8iYah4Wg22tE+LvLHxFzz7cymphGFhwk
         FxAw==
X-Gm-Message-State: AOAM533Mu4nBgrHyW9GZ2um3twRshOX+eWYVEN9u44r9NJXtW/OieW6t
        e3iMp9YnkOg/wgzMnGvUU7k=
X-Google-Smtp-Source: ABdhPJyhhWTEMpHKx5xQFfbXhw9ERansrUFCr10VFQiatRUTj4yVSTkoPUwZkwxzRuhA6tnFNbtzhw==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr2312826wmj.84.1591609460016;
        Mon, 08 Jun 2020 02:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:181:90d0:6ce1:d6aa:6a23:353b])
        by smtp.gmail.com with ESMTPSA id y37sm26415505wrd.55.2020.06.08.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:44:19 -0700 (PDT)
From:   Richard Genoud <richard.genoud@gmail.com>
To:     Dan Murphy <dmurphy@ti.com>, Sriram Dash <sriram.dash@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH] can: m_can_platform: fix m_can_runtime_suspend()
Date:   Mon,  8 Jun 2020 11:43:48 +0200
Message-Id: <20200608094348.12650-1-richard.genoud@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since commit f524f829b75a ("can: m_can: Create a m_can platform
framework"), the can peripheral on STM32MP1 wasn't working anymore.

The reason was a bad copy/paste maneuver that added a call to
m_can_class_suspend() in m_can_runtime_suspend().

Tested on STM32MP157C-DK2 and emSBC-Argon

Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/net/can/m_can/m_can_platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..e6d0cb9ee02f 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -144,8 +144,6 @@ static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_classdev *mcan_class = netdev_priv(ndev);
 
-	m_can_class_suspend(dev);
-
 	clk_disable_unprepare(mcan_class->cclk);
 	clk_disable_unprepare(mcan_class->hclk);
 
