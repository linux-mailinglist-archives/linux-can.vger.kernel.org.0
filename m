Return-Path: <linux-can+bounces-1130-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD5A948A68
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDDD1F2531A
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC31BD00D;
	Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85216A95B
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930466; cv=none; b=Pie8eDH3QG5YqGDUF72VRde/WlqVVFV6SHGS8INCBADc69XcN6+9DngKmmqt6/Uwa9udcgYHI/WvQtnUkKcnXVqJ9Bb5cvVM6EmCJ3lwZ+I/oD3ayE65q6XIu09IFFOfRKhtr3iaTSjpeOIr3BPXuUQgE9IvZHQ8/uvSJUVFI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930466; c=relaxed/simple;
	bh=o5cI+E1L3egtSBwRzAjrKbPnWbftzVvQy7z707upBYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ1ILclQRPO9i+cnKweWPlJss2/rnwseKbBaqgJoA59QHUgtWkLiHVrQYexLtz0QKawDXjX4j41m4W7YDzFEV6640vO61ZNs9XbrXpUOMtteCpDGsQ3ezaeaGfzVXwQ9nl5PbQ5npFKlVTHbtPt326yooyI5IV9u9bczDQmxFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuz-00046b-2i
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuv-004tsq-E5
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 169553179DE
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4F848317981;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 054fb56b;
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
Subject: [PATCH net-next 10/20] can: kvaser_usb: leaf: Add struct for Tx ACK commands
Date: Tue,  6 Aug 2024 09:42:01 +0200
Message-ID: <20240806074731.1905378-11-mkl@pengutronix.de>
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

Add, struct leaf_cmd_tx_acknowledge, for Tx ACK commands received from leaf
devices (M32C and leafimx28).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-6-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 23bd7574b1c7..70511e151a3b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -235,6 +235,13 @@ struct kvaser_cmd_tx_acknowledge_header {
 	u8 tid;
 } __packed;
 
+struct leaf_cmd_tx_acknowledge {
+	u8 channel;
+	u8 tid;
+	__le16 time[3];
+	u8 padding[2];
+} __packed;
+
 struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
@@ -347,6 +354,7 @@ struct kvaser_cmd {
 			struct leaf_cmd_error_event error_event;
 			struct kvaser_cmd_cap_req cap_req;
 			struct kvaser_cmd_cap_res cap_res;
+			struct leaf_cmd_tx_acknowledge tx_ack;
 		} __packed leaf;
 
 		union {
@@ -370,7 +378,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
 	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
-	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
+	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.leaf.tx_ack),
 	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.leaf.softinfo),
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
-- 
2.43.0



