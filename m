Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD79B7B7BEF
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjJDJY0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjJDJYV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF428BD
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny75-0005Pg-WE
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-00AzlD-MF
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5EFDA22EB6F
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9A10922EB50;
        Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7fda0c53;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:32 +0200
Subject: [PATCH 13/27] can: at91_can: at91_set_bittiming(): demote register
 output to debug level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-13-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=IxnP+JbX3X7x8zAlCN1Gdw+5d/+0HctZK2nmmCH9Orc=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8khmjRXTK4Ky1BJMX6fVKsvnDAGNelAwcJW
 FCbGQFY+DOJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vJAAKCRC+UBxKKooE
 6BsgB/0ak1hkynk+6mrf/dW0q5IqYzIkMPu0ZercHo+kqKIIIK+StddMZhKXboqxOWEwWqZhK0e
 anKrwAl34ZRK71Nf1CO86+NKNIQG1sStcoZV01oTS2vvg1EmxjLcdme1JBFmVV5JWiWpINtFQB1
 U+W58AUirjFJi/vHWBExpdCtgGG7yN3NqdXWPLnNOmaREzjQMA1xERC/zs5DlHJLtqVkfTwN6C/
 i3+1OlMH7cHhUrbyQ9g70AB6FVkTWPFQibsW3TC0XUtQ/85cjDhQ1oE0DH9eoyzmHQjh/oN1ioN
 aJ7hN/xCT2x1yct8X3PfULHynmULecBSUtd2b44GYb40I02v
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

This message isn't really helpful for the general reader of the kernel
logs, so should not be printed with info level.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 092652fd7352..f92d8a75d1b1 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -393,7 +393,7 @@ static int at91_set_bittiming(struct net_device *dev)
 		FIELD_PREP(AT91_BR_PHASE1_MASK, bt->phase_seg1 - 1) |
 		FIELD_PREP(AT91_BR_PHASE2_MASK, bt->phase_seg2 - 1);
 
-	netdev_info(dev, "writing AT91_BR: 0x%08x\n", reg_br);
+	netdev_dbg(dev, "writing AT91_BR: 0x%08x\n", reg_br);
 
 	at91_write(priv, AT91_BR, reg_br);
 

-- 
2.40.1


