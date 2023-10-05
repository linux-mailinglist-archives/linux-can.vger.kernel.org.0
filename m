Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250587BA55A
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjJEQQA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241476AbjJEQO2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:14:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381FE7ED8
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7h-0001FV-B4
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-00BDLp-7j
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id ECEA822F7BC
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4845322F79E;
        Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7e2a778d;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:38 +0200
Subject: [PATCH v2 10/27] can: at91_can: add more register definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-10-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=u+kdoH7ppdFG0K4tOKFWBt/xtDhUgmsGUwzBtPrGrGg=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqZeDNfayvYDDgGbbJJJiZjeWZzcxgVt59kH
 XIXsYafxLiJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qmQAKCRC+UBxKKooE
 6FkmB/oC8/oeDX77Gqgxhk7hXHELKwnQR0JjhxpYFQaufdsVl392xuBpkE6V9+GmDGDHm02IYWm
 pF6hS3qkCv56B4XqsMnU57XtuvoNkPkKmezXI9RWj4T/kr508Ih5jHroMn1pKJZhArNES15BtZR
 MBerL9O9OyFWbYoLE5iX0x+AruD9lngekso/VFlmxl+g1EiyP/5+DOTf4Nwhauyd2x8dZshTq91
 rTyi613/tzEzBqR4C46O9JaEWVuRJQeEbYhNaQBYjJuntcsERdlyq+6NqBTdpJEmcuu4WlfWd2L
 bJmyBnbV7U3YaqdTmuUHm4aixVj2B67mJ9G6Lv6/5MqM/WuZ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add more register definitions found in the data sheet.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 0269e2a6508a..f23d036d947d 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -64,6 +64,8 @@ enum at91_reg {
 #define AT91_MR_DRPT BIT(7)
 
 #define AT91_SR_RBSY BIT(29)
+#define AT91_SR_TBSY BIT(30)
+#define AT91_SR_OVLSY BIT(31)
 
 #define AT91_BR_PHASE2_MASK GENMASK(2, 0)
 #define AT91_BR_PHASE1_MASK GENMASK(6, 4)
@@ -72,9 +74,13 @@ enum at91_reg {
 #define AT91_BR_BRP_MASK GENMASK(22, 16)
 #define AT91_BR_SMP BIT(24)
 
+#define AT91_TIM_TIMER_MASK GENMASK(15, 0)
+
 #define AT91_ECR_REC_MASK GENMASK(8, 0)
 #define AT91_ECR_TEC_MASK GENMASK(23, 16)
 
+#define AT91_TCR_TIMRST BIT(31)
+
 #define AT91_MMR_MTIMEMARK_MASK GENMASK(15, 0)
 #define AT91_MMR_PRIOR_MASK GENMASK(19, 16)
 #define AT91_MMR_MOT_MASK GENMASK(26, 24)

-- 
2.40.1


