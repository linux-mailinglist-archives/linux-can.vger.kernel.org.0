Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E2D51528F
	for <lists+linux-can@lfdr.de>; Fri, 29 Apr 2022 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355320AbiD2RsM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Apr 2022 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiD2RsM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Apr 2022 13:48:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51AD3993
        for <linux-can@vger.kernel.org>; Fri, 29 Apr 2022 10:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8FCCB8371C
        for <linux-can@vger.kernel.org>; Fri, 29 Apr 2022 17:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A560C385A4;
        Fri, 29 Apr 2022 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254290;
        bh=rTFkiDLCDMkzZNbUbrV+azXCpNL6cSTjONKpwpvdSJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=lqszfDbSJcID9uKWrUp+dOTjJoKIfLKV7z1CdKLz9rL2Ybokx49rRssjYVamN0CnA
         SxYgknSKJFoQKBn3RVqQak7TeTqB+EKbWxWvETCUf2CTPgd9KmKdVpZ6BTF2Zo6LsE
         C2k6gENYK1A5i6lrmMl9Do4vO/sRN67LnwENosL/qLDNCZ9TLveljw6dxmsouzSjIM
         c/slOj9VSum1D9QzfvyWSexDulO2EmgVqKkdUVDP9RWvl2qB+H8/Hobf8hK+EDJLEl
         P5BsGb1wXBMV3Z4HqajzQCfNKhz/1qzl+6HXNaw3L/2w94BfgW1tAsSltzRydGfBy/
         HgGtyVhr0HfgA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     mkl@pengutronix.de
Cc:     Jakub Kicinski <kuba@kernel.org>, rcsekar@samsung.com,
        wg@grandegger.com, linux-can@vger.kernel.org
Subject: [PATCH can-next] m_can: remove a copy of the NAPI_POLL_WEIGHT define
Date:   Fri, 29 Apr 2022 10:44:46 -0700
Message-Id: <20220429174446.196655-1-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Defining local versions of NAPI_POLL_WEIGHT with the same
values in the drivers just makes refactoring harder.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: rcsekar@samsung.com
CC: wg@grandegger.com
CC: mkl@pengutronix.de
CC: linux-can@vger.kernel.org
---
 drivers/net/can/m_can/m_can.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2779bba390f2..e6d2da4a9f41 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -77,9 +77,6 @@ enum m_can_reg {
 	M_CAN_TXEFA	= 0xf8,
 };
 
-/* napi related */
-#define M_CAN_NAPI_WEIGHT	64
-
 /* message ram configuration data length */
 #define MRAM_CFG_LEN	8
 
@@ -951,7 +948,7 @@ static int m_can_rx_peripheral(struct net_device *dev)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int work_done;
 
-	work_done = m_can_rx_handler(dev, M_CAN_NAPI_WEIGHT);
+	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT);
 
 	/* Don't re-enable interrupts if the driver had a fatal error
 	 * (e.g., FIFO read failure).
@@ -1474,7 +1471,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 
 	if (!cdev->is_peripheral)
 		netif_napi_add(dev, &cdev->napi,
-			       m_can_poll, M_CAN_NAPI_WEIGHT);
+			       m_can_poll, NAPI_POLL_WEIGHT);
 
 	/* Shared properties of all M_CAN versions */
 	cdev->version = m_can_version;
@@ -1994,7 +1991,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	if (cdev->is_peripheral) {
 		ret = can_rx_offload_add_manual(cdev->net, &cdev->offload,
-						M_CAN_NAPI_WEIGHT);
+						NAPI_POLL_WEIGHT);
 		if (ret)
 			goto clk_disable;
 	}
-- 
2.34.1

