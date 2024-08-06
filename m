Return-Path: <linux-can+bounces-1133-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E88CF948A6F
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86007B22847
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B591BCA11;
	Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E316A95F
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930467; cv=none; b=UdYWchKGZ5LO+pDYxoU0PjyhiVw29EL7iODTHlTjNHHYv3Z+enY+CnNskLh4WzcECDlwBmG5BfmeyJ7ixydQChgJJJ9DOFGdbc2H6MCbPzbXWhZ+Nib3zaNvqPMM/dSQxk/E17VCCkU2nYasPBWQTUyxcRIVYPkRfItWY2O4/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930467; c=relaxed/simple;
	bh=Xl8L1A+Io853XBdQS0p+W7orlcacQ3c/seOqzpZ5fGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNyBCPWWs41lgYa3jmdzo1XV6u6K0CRhAp47ULRPeXSimutbapmH7YffmqvlfvWaQelqjnKmYWTmSHuOtmX1zi3hbPR6rGAtxvkVfSePeYH98x0PE9KyEvgufYNOO8CnPRtxYtZ4DhtULoWarMzziMB0+zlGQ3DyBSfxFUkRKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuz-00046h-4b
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuv-004tsT-Dz
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EF0F93179D6
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0830A317978;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 32071db1;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/20] can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_} in function name
Date: Tue,  6 Aug 2024 09:41:58 +0200
Message-ID: <20240806074731.1905378-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Rename function, since this function will be used for more than just the
rx commands.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-3-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index ad1c6101a0cd..84f1f1f9c107 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -522,9 +522,8 @@ kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 	return priv;
 }
 
-static ktime_t
-kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
-				   const struct kvaser_cmd *cmd)
+static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *cfg,
+					       const struct kvaser_cmd *cmd)
 {
 	ktime_t hwtstamp = 0;
 
@@ -1232,7 +1231,7 @@ static void kvaser_usb_hydra_rx_msg_std(const struct kvaser_usb *dev,
 	stats = &priv->netdev->stats;
 
 	flags = cmd->rx_can.flags;
-	hwtstamp = kvaser_usb_hydra_ktime_from_rx_cmd(dev->cfg, cmd);
+	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
@@ -1300,7 +1299,7 @@ static void kvaser_usb_hydra_rx_msg_ext(const struct kvaser_usb *dev,
 		KVASER_USB_KCAN_DATA_DLC_SHIFT;
 
 	flags = le32_to_cpu(cmd->rx_can.flags);
-	hwtstamp = kvaser_usb_hydra_ktime_from_rx_cmd(dev->cfg, std_cmd);
+	hwtstamp = kvaser_usb_hydra_ktime_from_cmd(dev->cfg, std_cmd);
 
 	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
 		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
-- 
2.43.0



