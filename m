Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C786755C9B
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGQHTE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 03:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGQHS4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 03:18:56 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0CC67E2;
        Mon, 17 Jul 2023 00:18:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3865C604D34EE;
        Mon, 17 Jul 2023 15:18:45 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     uttenthaler@ems-wuensche.com, yunchuan@nfschina.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next v4 8/9] can: ems_pci: Remove unnecessary (void*) conversions
Date:   Mon, 17 Jul 2023 15:18:01 +0800
Message-Id: <20230717071800.144129-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

No need cast (void*) to (struct ems_pci_card *).

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/can/sja1000/ems_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index c56e27223e5f..ac86640998a8 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -148,7 +148,7 @@ static void ems_pci_v1_write_reg(const struct sja1000_priv *priv,
 
 static void ems_pci_v1_post_irq(const struct sja1000_priv *priv)
 {
-	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+	struct ems_pci_card *card = priv->priv;
 
 	/* reset int flag of pita */
 	writel(PITA2_ICR_INT0_EN | PITA2_ICR_INT0,
@@ -168,7 +168,7 @@ static void ems_pci_v2_write_reg(const struct sja1000_priv *priv,
 
 static void ems_pci_v2_post_irq(const struct sja1000_priv *priv)
 {
-	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+	struct ems_pci_card *card = priv->priv;
 
 	writel(PLX_ICSR_ENA_CLR, card->conf_addr + PLX_ICSR);
 }
@@ -186,7 +186,7 @@ static void ems_pci_v3_write_reg(const struct sja1000_priv *priv,
 
 static void ems_pci_v3_post_irq(const struct sja1000_priv *priv)
 {
-	struct ems_pci_card *card = (struct ems_pci_card *)priv->priv;
+	struct ems_pci_card *card = priv->priv;
 
 	writel(ASIX_LINTSR_INT0AC, card->conf_addr + ASIX_LINTSR);
 }
-- 
2.30.2

