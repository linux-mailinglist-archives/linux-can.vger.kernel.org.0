Return-Path: <linux-can+bounces-356-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8086FD15
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8511F25640
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9EB20DDC;
	Mon,  4 Mar 2024 09:21:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B71B7F1
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544067; cv=none; b=vGDCwMcRLzV3YnmuRBew+u0RqUEiuT9gDkO5iZDQKEIh7cHZ3lpF2tShiK0+WE85JdrV1OYTET3XUdikqOeitpIi2JXVk7oCnsJIQtJgccZoVLsdhwFL5JnxKbLRlVHtdLiuB3LGMG1rafpOeddSSuTbB8whnJ5ma0qtJ/pcU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544067; c=relaxed/simple;
	bh=ZLlgLz8iG3ktAmQeBt/Mg0Zc7CmvdNz+SZXpGHgk4kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTTA2pbEdGui0apRR6KtNPiwCnn2eGyM17jpcR7+wyuT4O8z2xKURIuOumcBmlXN/7ladih2Kp9jGXXjPHOHVKzYdTJ/U9TQuDTSJjKsu9avirHkUHuMZ/xO3OloI4GsX3RAcGs8ZQtqkjIjkfT62PD1DChK3jV4BpkUHB+qLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VM-00053i-48
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 10:21:04 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VL-004K3m-I4
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 10:21:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3FF4429CB44
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 09:21:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0C70829CB2C;
	Mon,  4 Mar 2024 09:21:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b437eeb5;
	Mon, 4 Mar 2024 09:21:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/4] can: gs_usb: gs_cmd_reset(): use cpu_to_le32() to assign mode
Date: Mon,  4 Mar 2024 10:13:57 +0100
Message-ID: <20240304092051.3631481-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304092051.3631481-1-mkl@pengutronix.de>
References: <20240304092051.3631481-1-mkl@pengutronix.de>
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

The structure gs_device_mode dm::mode is a __le32, use cpu_to_le32()
to assign GS_CAN_MODE_RESET.

As GS_CAN_MODE_RESET is 0x0, this is basically a no-op.

Link: https://lore.kernel.org/all/20240304074540.3584842-1-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 95b0fdb602c8..65c962f76898 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -385,7 +385,7 @@ static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev,
 static int gs_cmd_reset(struct gs_can *dev)
 {
 	struct gs_device_mode dm = {
-		.mode = GS_CAN_MODE_RESET,
+		.mode = cpu_to_le32(GS_CAN_MODE_RESET),
 	};
 
 	return usb_control_msg_send(dev->udev, 0, GS_USB_BREQ_MODE,
-- 
2.43.0



