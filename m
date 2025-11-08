Return-Path: <linux-can+bounces-5318-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E7C429DF
	for <lists+linux-can@lfdr.de>; Sat, 08 Nov 2025 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336F7188D505
	for <lists+linux-can@lfdr.de>; Sat,  8 Nov 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC632877D2;
	Sat,  8 Nov 2025 09:01:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51C265CCD
	for <linux-can@vger.kernel.org>; Sat,  8 Nov 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762592481; cv=none; b=nX6CXf6ngHTh0f0+0jEfEkuVtBB1rc7UuQXkDXKVWRC7skn1zSNdp92FvQrdOqgx8YlgbV9mWRHtt16feZt9TzvWTzAlqvzj6LNDpnJFdVML80rpIVton/s3K+BMbQmSdL8HlvD3Vz+lPobPkoF7jwM3H3eemT/fcc6AqIEOGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762592481; c=relaxed/simple;
	bh=ISveydnAGqHXLegHAkh7CeD6kEHV3cPFgoiC794xNh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BpfJzhRsKttGQoU8yyuT41j5e44SLW/l9++y0KJA4iO3lAr/LyXpWYtjTgNDnlyfzzaPYlx3+T46Q+03F5fZy521MuufjMSz5XynkMaRQECXBhMQJzYZbwjUSX/M2N9BwQs7CRhLfXBUHNpVS8necSX7R5JMB/8C7RyJIIphSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vHeos-0004we-Oe; Sat, 08 Nov 2025 10:01:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vHeos-007fMJ-1Q;
	Sat, 08 Nov 2025 10:01:14 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BBB5549A89E;
	Sat, 08 Nov 2025 09:01:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 08 Nov 2025 10:01:03 +0100
Subject: [PATCH can 3/3] can: gs_usb: gs_usb_receive_bulk_callback(): check
 actual_length before accessing data
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-gs_usb-fix-usb-callbacks-v1-3-8a2534a7ea05@pengutronix.de>
References: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
In-Reply-To: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4422; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ISveydnAGqHXLegHAkh7CeD6kEHV3cPFgoiC794xNh8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpDwbVLGDGqr9V0Eqb2S/9HvthfmGZE/9pa0TSn
 KPTMiz2rGGJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaQ8G1QAKCRAMdGXf+ZCR
 nORnB/4k+jvB/xk12G2tYFI3x7bYBLm1V3NEEg8+7v/R18dw8JMXt/laazet4pBjVYTMRxkQyPH
 hoTNo7jZIKR53j41tpKUZOGotdZRYOqlXwNTzvpsXBvwwEwWj5W51470Mo/v6+LdIke1PCXi9vl
 3Tv95s+tcNWmnhqy36FhfGLGs53WCjLN61NTOdp5v6ZPDMNkoF3Om+Mh6/uJVWYv7leOWezBRqM
 JLwyuvh8WQ297dCGcqNCXAaQvA4byNx/VfN3de3LI7fs+tCedB4szmWFfrSsaUq626hmsMN0xXE
 EqrPsEBg+YwrqU0ypVwblqNNo7k+qJkAvrQjxSZ0j+YkdHIP
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The URB received in gs_usb_receive_bulk_callback() contains a struct
gs_host_frame. The length of the data after the header depends on the
gs_host_frame hf::flags and the active device features (e.g. time
stamping).

Introduce a new function gs_usb_get_minimum_length() and check that we have
at least received the required amount of data before accessing it. Only
copy the data to that skb that has actually been received.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 51f8d694104d..8524d423b029 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -261,6 +261,11 @@ struct canfd_quirk {
 	u8 quirk;
 } __packed;
 
+/* struct gs_host_frame::echo_id == GS_HOST_FRAME_ECHO_ID_RX indicates
+ * a regular RX'ed CAN frame
+ */
+#define GS_HOST_FRAME_ECHO_ID_RX 0xffffffff
+
 struct gs_host_frame {
 	struct_group(header,
 		u32 echo_id;
@@ -570,6 +575,43 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
 	return len;
 }
 
+static unsigned int
+gs_usb_get_minimum_length(const struct gs_can *dev, const struct gs_host_frame *hf,
+			  unsigned int *data_length_p)
+{
+	unsigned int minimum_length, data_length;
+
+	/* TX echo only uses the header */
+	if (hf->echo_id != GS_HOST_FRAME_ECHO_ID_RX) {
+		*data_length_p = 0;
+		return sizeof(hf->header);
+	}
+
+	if (hf->flags & GS_CAN_FLAG_FD) {
+		data_length = can_fd_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, canfd_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	} else {
+		if (hf->can_id & cpu_to_le32(CAN_RTR_FLAG))
+			data_length = 0;
+		else
+			data_length = can_cc_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, classic_can_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	}
+
+	*data_length_p = data_length;
+	return minimum_length;
+}
+
 static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
@@ -578,7 +620,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
-	unsigned int minimum_length;
+	unsigned int minimum_length, data_length;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -621,20 +663,33 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (!netif_running(netdev))
 		goto resubmit_urb;
 
-	if (hf->echo_id == -1) { /* normal rx */
+	minimum_length = gs_usb_get_minimum_length(dev, hf, &data_length);
+	if (urb->actual_length < minimum_length) {
+		stats->rx_errors++;
+		stats->rx_length_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "short read (actual_length=%u, minimum_length=%u)\n",
+				   urb->actual_length, minimum_length);
+
+		goto resubmit_urb;
+	}
+
+	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				return;
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
-			cfd->len = can_fd_dlc2len(hf->can_dlc);
+			cfd->len = data_length;
 			if (hf->flags & GS_CAN_FLAG_BRS)
 				cfd->flags |= CANFD_BRS;
 			if (hf->flags & GS_CAN_FLAG_ESI)
 				cfd->flags |= CANFD_ESI;
 
-			memcpy(cfd->data, hf->canfd->data, cfd->len);
+			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
@@ -643,7 +698,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
 
-			memcpy(cf->data, hf->classic_can->data, 8);
+			memcpy(cf->data, hf->classic_can->data, data_length);
 
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)

-- 
2.51.0


