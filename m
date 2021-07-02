Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925493B9E87
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhGBJwg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBJwg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:52:36 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC441C061762;
        Fri,  2 Jul 2021 02:50:03 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id b48a2acb;
        Fri, 2 Jul 2021 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=default; bh=pa6CBY5/YcgVJmnW9MPb9T
        z8fbk=; b=Zn/ytsAmvmlU89+n2p4Ml/UfvoQ1chhMKpiZwgZ1NELepnJw6OYShp
        Ii4dcQNgw9EN9X/0VewO4DHHlQM8lBEC3zCz+fsTAZHu4L/4X2gBxyCyvDTkWCvK
        dyAJoRpnz6UKCNmgma1vW3UljPtcbEnDjpUxB+kkDasYNQYd3N3dg=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=default; b=L1h3BQkhxviL1hWk
        tyaqvpuE3XlH/rhVOVtRJhbMSpBH+SnRH1Cr7wcTl110RCWiCLMhIe69e6PDbDew
        RzTTUSEaV7tZSukpmfNEwK0Q2qI6VVxtpKREKupVbsaoa/eS40Vd3w2CkAk8FSR5
        QUUDYZ3sah9Fu88c+6HEAEJQl8o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1625219401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnJFLlGss1lfXkGDcGNqw4TgipYfWgM/ojSTHnOj6fE=;
        b=sAqxlwWQF5ndxGkvsjNOyFEpdfXEJXpkk4YBmj3LLnDpfvsh5a+40bza3gRHajEk2KSJJ5
        l1piFzTF+8vJzISMcAIWkhQXwYWc01dTlKLv5eOuxJxdtmt6unk+kq6s0W6knqeKBq/ro1
        a8VEPClyeyFwTUbtNx0MZm1abypd/Fg=
Received: from dfj.bfc.timesys.com (<unknown> [95.236.232.230])
        by ziongate (OpenSMTPD) with ESMTPSA id d663e414 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jul 2021 09:50:01 +0000 (UTC)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     gerg@linux-m68k.org, wg@grandegger.com, mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com,
        Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v5 4/5] can: flexcan: update Kconfig to enable coldfire
Date:   Fri,  2 Jul 2021 11:48:40 +0200
Message-Id: <20210702094841.327679-4-angelo@kernel-space.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210702094841.327679-1-angelo@kernel-space.org>
References: <20210702094841.327679-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Update flexcan to support coldfire architecture.

Any new platform should use OF, but coldfire architecture is
actually not supporting devicetrees.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
Changes for v2:
none
Changes for v3:
- change to just remove OF
Changes for v4:
- readjust options with coldfire and compile test additions
Changes for v5:
- remove trailing space
---
 drivers/net/can/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e355d3974977..fff259247d52 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -97,7 +97,8 @@ config CAN_AT91
 
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
-	depends on OF && HAS_IOMEM
+	depends on OF || COLDFIRE || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want to support for Freescale FlexCAN.
 
-- 
2.31.1

