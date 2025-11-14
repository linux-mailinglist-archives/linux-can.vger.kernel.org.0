Return-Path: <linux-can+bounces-5391-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB80C5C03F
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 09:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8102034BE61
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8C2FFF92;
	Fri, 14 Nov 2025 08:37:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3F2FFF8B
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109426; cv=none; b=kjq6lG8EEnagU2fqM0qRLBEeeyblfpiC70igx3yivkjU9ELkLCCBvaPJvvjWMQ2DTtEMxbzR79pjAST78j1gP9ZB50ij/0Iv+5U1UnY1Lq2ljQ3U2B2gEsg5OVE/e8RtUII8pgtiEqR9xxlyvGbeWke+CS1Fh0c/HP3udwvAQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109426; c=relaxed/simple;
	bh=7fNx/AX63/lcrl0SzWFf1gLEWkW0J5hkOQiArbLfdHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gr+65cdrVqXwm0JZzLmjc4GgtdTLtlUVcE5oGHPtaA1LkIUBAR9F4M+P9xocYY+wtnIyppFoZQtnuSTLWiv1Gbiw0EK06Qyq5ti7xbR+H2Ibdct9G6qbERabiL7Kb5R7p3pPvv7vk9F0EVhH9ii4jHyofq1CmRLRoqJzuiYJGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-0007Pn-NX; Fri, 14 Nov 2025 09:36:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-000OMY-0O;
	Fri, 14 Nov 2025 09:36:56 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9C9B49F2FE;
	Fri, 14 Nov 2025 08:36:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 14 Nov 2025 09:36:44 +0100
Subject: [PATCH can 2/3] can: gs_usb: gs_usb_receive_bulk_callback(): check
 actual_length before accessing header
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-gs_usb-fix-usb-callbacks-v1-2-a29b42eacada@pengutronix.de>
References: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
In-Reply-To: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Maximilian Schneider <max@schneidersoft.net>
Cc: Henrik Brix Andersen <henrik@brixandersen.dk>, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2432; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=7fNx/AX63/lcrl0SzWFf1gLEWkW0J5hkOQiArbLfdHc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpFuojJKCiAgMioiQ/b6FnAZW/5pbIzUl5FEsYz
 cx0eegR7ISJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaRbqIwAKCRAMdGXf+ZCR
 nJ9sB/wJ/sULlZPF0h009+0lssX5XbC652e3i12657gwYZB13+FKOQA7WH6rJU149f7yFPHlxPA
 4rSiTeYj3b2nyqRWc1YJw6CXTtbVl7HungGeK4MyYSna8hAR44aiF1GPm+ylC0ajqQUx7JVpxhI
 xnak7b01E+GicyV2ud/g7bHFjwtCBKGbLFP2ahQ2M7TMMeMuRksaL2EOFZtIvu+CJPbR3sXLYN4
 JHv8EqCZPYAw11x6bxS36FzaJsbAUZOmxmsWrEhqDeKzk/4f38WfSPTP9eQRL+wwtNTy9eR5ING
 0trIAjsmwDS6QY/gV7WGxQj42AsuozV8QZ8Tlp0kI8cM+YX1
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The driver expects to receive a struct gs_host_frame in
gs_usb_receive_bulk_callback().

Use struct_group to describe the header of the struct gs_host_frame and
check that we have at least received the header before accessing any
members of it.

To resubmit the URB, do not dereference the pointer chain
"dev->parent->hf_size_rx" but use "parent->hf_size_rx" instead. Since
"urb->context" contains "parent", it is always defined, while "dev" is not
defined if the URB it too short.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index fa9bab8c89ae..51f8d694104d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -262,13 +262,15 @@ struct canfd_quirk {
 } __packed;
 
 struct gs_host_frame {
-	u32 echo_id;
-	__le32 can_id;
+	struct_group(header,
+		u32 echo_id;
+		__le32 can_id;
 
-	u8 can_dlc;
-	u8 channel;
-	u8 flags;
-	u8 reserved;
+		u8 can_dlc;
+		u8 channel;
+		u8 flags;
+		u8 reserved;
+	);
 
 	union {
 		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
@@ -576,6 +578,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
+	unsigned int minimum_length;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -594,6 +597,15 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		return;
 	}
 
+	minimum_length = sizeof(hf->header);
+	if (urb->actual_length < minimum_length) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "short read (actual_length=%u, minimum_length=%u)\n",
+				    urb->actual_length, minimum_length);
+
+		goto resubmit_urb;
+	}
+
 	/* device reports out of range channel id */
 	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
@@ -687,7 +699,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
 			  parent->pipe_in,
-			  hf, dev->parent->hf_size_rx,
+			  hf, parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
 	rc = usb_submit_urb(urb, GFP_ATOMIC);

-- 
2.51.0


