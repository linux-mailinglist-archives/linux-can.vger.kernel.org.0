Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91F3F49F7
	for <lists+linux-can@lfdr.de>; Mon, 23 Aug 2021 13:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhHWLnJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Aug 2021 07:43:09 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:20360 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhHWLnI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Aug 2021 07:43:08 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee961238770fd7-04e41; Mon, 23 Aug 2021 19:33:04 +0800 (CST)
X-RM-TRANSID: 2ee961238770fd7-04e41
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee261238767421-c70d3;
        Mon, 23 Aug 2021 19:33:03 +0800 (CST)
X-RM-TRANSID: 2ee261238767421-c70d3
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     davem@davemloft.net, wg@grandegger.com, mkl@pengutronix.de,
        kuba@kernel.org, kevinbrace@bracecomputerlab.com,
        romieu@fr.zoreil.com
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH 2/3] via-velocity: Use of_device_get_match_data to simplify code
Date:   Mon, 23 Aug 2021 19:33:37 +0800
Message-Id: <20210823113338.3568-3-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20210823113338.3568-1-tangbin@cmss.chinamobile.com>
References: <20210823113338.3568-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Retrieve OF match data, it's better and cleaner to use
'of_device_get_match_data' over 'of_match_device'.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/net/ethernet/via/via-velocity.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index 278f49518..6a08ea658 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -2943,14 +2943,12 @@ static void velocity_pci_remove(struct pci_dev *pdev)
 
 static int velocity_platform_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	const struct velocity_info_tbl *info;
 	int irq;
 
-	of_id = of_match_device(velocity_of_ids, &pdev->dev);
-	if (!of_id)
+	info = of_device_get_match_data(&pdev->dev);
+	if (!info)
 		return -EINVAL;
-	info = of_id->data;
 
 	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	if (!irq)
-- 
2.20.1.windows.1



