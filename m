Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DA571ABC
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiGLNDi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 09:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGLNDh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 09:03:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA82BD0
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 06:03:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oBFY6-0001ba-Cr
        for linux-can@vger.kernel.org; Tue, 12 Jul 2022 15:03:34 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-2099-0011-e8c0-354d.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:2099:11:e8c0:354d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DF4A8AF0F1
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 13:03:33 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id yLMbLG9FzWJY2wMAs6a69A
        (envelope-from <windhl@126.com>)
        for <mkl-all@blackshift.org>; Tue, 12 Jul 2022 09:57:03 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AE902AE7F3
        for <mkl-all@blackshift.org>; Tue, 12 Jul 2022 09:57:03 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A6197AE7F2
        for <ptx@kleine-budde.de>; Tue, 12 Jul 2022 09:57:03 +0000 (UTC)
Received: from mail-m964.mail.126.com ([123.126.96.4])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <windhl@126.com>)
        id 1oBCdZ-0006mt-Rl; Tue, 12 Jul 2022 11:57:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Qz6FM
        8MFTtvFI+oOsD9UB3a5chgKL38YyF+czNRoOew=; b=dDh9DH+4vzbC1cErfMRHx
        ljNVigrjMjyAwl1Qdtr/q/bd60mGfgZxOY7BgACnmgc+Zl4hlGdk1DqSzC2Dumpp
        0lWVvLtCKatnjW0p3tu0j9zHUf0FGhRwYDKu+R2RXJZlpDgXFB9VCv1SKn9vnBRw
        PVHs0044O+Zh1q8TbCMDww=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgB3nt5HRc1ivtQ9Gg--.62421S2;
        Tue, 12 Jul 2022 17:56:25 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, windhl@126.com
Date:   Tue, 12 Jul 2022 17:56:23 +0800
Message-Id: <20220712095623.364287-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgB3nt5HRc1ivtQ9Gg--.62421S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy8tw4rKF4kWr43Ar43Jrb_yoWDurb_Gr
        nrWF17Kw47Kr1qkwsrtr13Z3yvyr18XFy0qFZ2qr1Svw17ZFWUJr18Z3srX3ykur4xArWf
        CayqyasrC3yYvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRpHqrUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgE8F1-HZfANZAAAsU
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] can: rcar_canfd: Add missing of_node_put() in rcar_canfd_probe()
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We should use of_node_put() for the reference returned by
of_get_child_by_name() which has increased the refcount.

Fixes: 45721c406dcf ("can: rcar_canfd: Add support for r8a779a0 SoC")
Signed-off-by: Liang He <windhl@126.com>
---

45721c406dcf-commit only changed the original multi-times 'of_child'
assignments with 'for' loop. As the original code also forgot to
add of_node_put(), I do not know if this fix tag is right.

 drivers/net/can/rcar/rcar_canfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 40a11445d021..5a49dc243372 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1840,6 +1840,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		of_child = of_get_child_by_name(pdev->dev.of_node, name);
 		if (of_child && of_device_is_available(of_child))
 			channels_mask |= BIT(i);
+		of_node_put(of_child);
 	}
 
 	if (chip_id != RENESAS_RZG2L) {
-- 
2.25.1


