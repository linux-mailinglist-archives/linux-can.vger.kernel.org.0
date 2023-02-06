Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120168BDD7
	for <lists+linux-can@lfdr.de>; Mon,  6 Feb 2023 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBFNTF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Feb 2023 08:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBFNST (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Feb 2023 08:18:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97824491
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 05:17:35 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pP1NF-00083E-P7
        for linux-can@vger.kernel.org; Mon, 06 Feb 2023 14:17:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 912761714D3
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 13:16:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8AF0D171314;
        Mon,  6 Feb 2023 13:16:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f11b3c81;
        Mon, 6 Feb 2023 13:16:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 37/47] can: netlink: can_validate(): validate sample point for CAN and CAN-FD
Date:   Mon,  6 Feb 2023 14:16:10 +0100
Message-Id: <20230206131620.2758724-38-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206131620.2758724-1-mkl@pengutronix.de>
References: <20230206131620.2758724-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The sample point is a value in tenths of a percent. Meaningful values
are between 0 and 1000. Invalid values are rejected and an error
message is returned to user space via netlink.

Link: https://lore.kernel.org/all/20230202110854.2318594-8-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 8efa22d9f214..02f5c00c521f 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -36,10 +36,24 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
+static int can_validate_bittiming(const struct can_bittiming *bt,
+				  struct netlink_ext_ack *extack)
+{
+	/* sample point is in one-tenth of a percent */
+	if (bt->sample_point >= 1000) {
+		NL_SET_ERR_MSG(extack, "sample point must be between 0 and 100%");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
 	bool is_can_fd = false;
+	int err;
 
 	/* Make sure that valid CAN FD configurations always consist of
 	 * - nominal/arbitration bittiming
@@ -51,6 +65,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err)
+			return err;
+	}
+
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
@@ -71,7 +94,6 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		 */
 		if (data[IFLA_CAN_TDC]) {
 			struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
-			int err;
 
 			err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
 					       data[IFLA_CAN_TDC],
@@ -102,6 +124,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			return -EOPNOTSUPP;
 	}
 
+	if (data[IFLA_CAN_DATA_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.39.1


