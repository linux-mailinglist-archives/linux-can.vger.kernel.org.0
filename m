Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0CE650A86
	for <lists+linux-can@lfdr.de>; Mon, 19 Dec 2022 12:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiLSLBU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Dec 2022 06:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLSLBQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Dec 2022 06:01:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A797E75
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2022 03:01:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p7DtO-0006xK-Oz
        for linux-can@vger.kernel.org; Mon, 19 Dec 2022 12:01:10 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 22525142F4D
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2022 11:01:10 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 07826142F48;
        Mon, 19 Dec 2022 11:01:09 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7af1da23;
        Mon, 19 Dec 2022 11:01:07 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org, kernel@pengutronix.de
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH] can: kvaser_usb: hydra: help gcc-13 to figure out cmd_len
Date:   Mon, 19 Dec 2022 12:01:04 +0100
Message-Id: <20221219110104.1073881-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Debian's gcc-13 [1] throws the following error in
kvaser_usb_hydra_cmd_size():

[1] gcc version 13.0.0 20221214 (experimental) [master r13-4693-g512098a3316] (Debian 13-20221214-1)

| drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:502:65: error:
| array subscript ‘struct kvaser_cmd_ext[0]’ is partly outside array
| bounds of ‘unsigned char[32]’ [-Werror=array-bounds=]
|   502 |                 ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);

kvaser_usb_hydra_cmd_size() returns the size of given command. It
depends on the command number (cmd->header.cmd_no). For extended
commands (cmd->header.cmd_no == CMD_EXTENDED) the above shown code is
executed.

Help gcc to recognize that this code path is not taken in all cases,
by calling kvaser_usb_hydra_cmd_size() directly after assigning the
command number.

Cc: Jimmy Assarsson <extja@kvaser.com>
Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Hello,

Jimmy, Anssi can you test this patch on real hardware?

regards,
Marc

 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index f688124d6d66..ef341c4254fc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -545,6 +545,7 @@ static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
 					    u8 cmd_no, int channel)
 {
 	struct kvaser_cmd *cmd;
+	size_t cmd_len;
 	int err;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -552,6 +553,7 @@ static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = cmd_no;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	if (channel < 0) {
 		kvaser_usb_hydra_set_cmd_dest_he
 				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ILLEGAL);
@@ -568,7 +570,7 @@ static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
 	kvaser_usb_hydra_set_cmd_transid
 				(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 	if (err)
 		goto end;
 
@@ -584,6 +586,7 @@ kvaser_usb_hydra_send_simple_cmd_async(struct kvaser_usb_net_priv *priv,
 {
 	struct kvaser_cmd *cmd;
 	struct kvaser_usb *dev = priv->dev;
+	size_t cmd_len;
 	int err;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
@@ -591,14 +594,14 @@ kvaser_usb_hydra_send_simple_cmd_async(struct kvaser_usb_net_priv *priv,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = cmd_no;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 
 	kvaser_usb_hydra_set_cmd_dest_he
 		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
 	kvaser_usb_hydra_set_cmd_transid
 				(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
-	err = kvaser_usb_send_cmd_async(priv, cmd,
-					kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd_async(priv, cmd, cmd_len);
 	if (err)
 		kfree(cmd);
 
@@ -742,6 +745,7 @@ static int kvaser_usb_hydra_get_single_capability(struct kvaser_usb *dev,
 {
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 	struct kvaser_cmd *cmd;
+	size_t cmd_len;
 	u32 value = 0;
 	u32 mask = 0;
 	u16 cap_cmd_res;
@@ -753,13 +757,14 @@ static int kvaser_usb_hydra_get_single_capability(struct kvaser_usb *dev,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_GET_CAPABILITIES_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	cmd->cap_req.cap_cmd = cpu_to_le16(cap_cmd_req);
 
 	kvaser_usb_hydra_set_cmd_dest_he(cmd, card_data->hydra.sysdbg_he);
 	kvaser_usb_hydra_set_cmd_transid
 				(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 	if (err)
 		goto end;
 
@@ -1578,6 +1583,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_usb_net_hydra_priv *hydra = priv->sub_priv;
 	struct kvaser_cmd *cmd;
+	size_t cmd_len;
 	int err;
 
 	if (!hydra)
@@ -1588,6 +1594,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_GET_BUSPARAMS_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	kvaser_usb_hydra_set_cmd_dest_he
 		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
 	kvaser_usb_hydra_set_cmd_transid
@@ -1597,7 +1604,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 
 	reinit_completion(&priv->get_busparams_comp);
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 	if (err)
 		return err;
 
@@ -1624,6 +1631,7 @@ static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
 	struct kvaser_cmd *cmd;
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
+	size_t cmd_len;
 	int err;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -1631,6 +1639,7 @@ static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_BUSPARAMS_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	memcpy(&cmd->set_busparams_req.busparams_nominal, busparams,
 	       sizeof(cmd->set_busparams_req.busparams_nominal));
 
@@ -1639,7 +1648,7 @@ static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
 	kvaser_usb_hydra_set_cmd_transid
 				(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 
 	kfree(cmd);
 
@@ -1652,6 +1661,7 @@ static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
 	struct kvaser_cmd *cmd;
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
 	struct kvaser_usb *dev = priv->dev;
+	size_t cmd_len;
 	int err;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -1659,6 +1669,7 @@ static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_BUSPARAMS_FD_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	memcpy(&cmd->set_busparams_req.busparams_data, busparams,
 	       sizeof(cmd->set_busparams_req.busparams_data));
 
@@ -1676,7 +1687,7 @@ static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
 	kvaser_usb_hydra_set_cmd_transid
 				(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 
 	kfree(cmd);
 
@@ -1804,6 +1815,7 @@ static int kvaser_usb_hydra_get_software_info(struct kvaser_usb *dev)
 static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 {
 	struct kvaser_cmd *cmd;
+	size_t cmd_len;
 	int err;
 	u32 flags;
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
@@ -1813,6 +1825,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_GET_SOFTWARE_DETAILS_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	cmd->sw_detail_req.use_ext_cmd = 1;
 	kvaser_usb_hydra_set_cmd_dest_he
 				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ILLEGAL);
@@ -1820,7 +1833,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
 	kvaser_usb_hydra_set_cmd_transid
 				(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 	if (err)
 		goto end;
 
@@ -1938,6 +1951,7 @@ static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 {
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_cmd *cmd;
+	size_t cmd_len;
 	int err;
 
 	if ((priv->can.ctrlmode &
@@ -1953,6 +1967,7 @@ static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_DRIVERMODE_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	kvaser_usb_hydra_set_cmd_dest_he
 		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
 	kvaser_usb_hydra_set_cmd_transid
@@ -1962,7 +1977,7 @@ static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 	else
 		cmd->set_ctrlmode.mode = KVASER_USB_HYDRA_CTRLMODE_NORMAL;
 
-	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 	kfree(cmd);
 
 	return err;
-- 
2.35.1


