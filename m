Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7124791599
	for <lists+linux-can@lfdr.de>; Mon,  4 Sep 2023 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348634AbjIDKRx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Sep 2023 06:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjIDKRw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Sep 2023 06:17:52 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 03:17:44 PDT
Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6CCD3;
        Mon,  4 Sep 2023 03:17:44 -0700 (PDT)
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
        by mx-8.mail.web4u.cz (Postfix) with ESMTP id E00411FF76C;
        Mon,  4 Sep 2023 12:00:03 +0200 (CEST)
Received: from baree.pikron.com (unknown [78.102.109.231])
        (Authenticated sender: ppisa@pikron.com)
        by mx-8.mail.web4u.cz (Postfix) with ESMTPA id C96701FF1C9;
        Mon,  4 Sep 2023 12:00:02 +0200 (CEST)
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        Lizhi Hou <lizhi.hou@amd.com>, Rob Herring <robh@kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH] of: overlay: Fix of_overlay_fdt_apply prototype when !CONFIG_OF_OVERLAY
Date:   Mon,  4 Sep 2023 12:00:02 +0200
Message-Id: <20230904100002.7913-1-pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-W4U-Auth: 9133a192d60015118c58877a0c2c4b7bfee0d0a3
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The of_overlay_fdt_apply has been changed but when CONFIG_OF_OVERLAY
support is not configured then old stub prototype is declared
by of.h header.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 include/linux/of.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index ed679819c279..6a9ddf20e79a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1676,8 +1676,8 @@ int of_overlay_notifier_unregister(struct notifier_block *nb);
 
 #else
 
-static inline int of_overlay_fdt_apply(void *overlay_fdt, u32 overlay_fdt_size,
-				       int *ovcs_id)
+static inline int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
+				       int *ovcs_id, struct device_node *target_base)
 {
 	return -ENOTSUPP;
 }
-- 
2.39.2

