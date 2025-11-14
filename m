Return-Path: <linux-can+bounces-5392-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F8BC5C042
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96CD634251B
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E82FD69D;
	Fri, 14 Nov 2025 08:37:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA62FFF90
	for <linux-can@vger.kernel.org>; Fri, 14 Nov 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109427; cv=none; b=t0MKYRBm5mjIeIKfbS2wNRS4kEM06DJta2T6paNJPoqGYrXUDHFGhlvvNYOTHKPJ4jOGRlb3s251nK1YHtzuO8FqIxFw24KYAdWAkkFE0tCVAR6iX/tMLZaGraaMhhlJB1tO2/IMH8TdChmyJc4Yn2gYkPN1I0g40PwvFvycZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109427; c=relaxed/simple;
	bh=NYE6AEyRqGQz4uSbT5PFqkL5x4h1YeOY7nv4uHYtXxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgXk/DBZE+4Rc0zHWvvSzSUNQ8d4RsTp8RCAOyRE/mQL8NPxmHmQ4tgV2JTfZvv7nLmj4GURpVuYTkX1EMs3xlYPvXx1yB8f5u1Mr0dJC3rk0EsE/ei1E02NiNm2cAgdg14cnrloPEPdeoXKBVHqU6lEd/wdZda1vvIiKNl1OlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-0007Po-NX; Fri, 14 Nov 2025 09:36:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJpIe-000OMb-0h;
	Fri, 14 Nov 2025 09:36:56 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C696249F2FF;
	Fri, 14 Nov 2025 08:36:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 14 Nov 2025 09:36:45 +0100
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
Message-Id: <20251114-gs_usb-fix-usb-callbacks-v1-3-a29b42eacada@pengutronix.de>
References: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
In-Reply-To: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Maximilian Schneider <max@schneidersoft.net>
Cc: Henrik Brix Andersen <henrik@brixandersen.dk>, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-509f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4348; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NYE6AEyRqGQz4uSbT5PFqkL5x4h1YeOY7nv4uHYtXxc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpFuolc/eTrFze5YpBHnh+1XFSWUfLdKC2dK3nn
 EXbPvR2VsyJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaRbqJQAKCRAMdGXf+ZCR
 nAaWCACAJMKDmvN3PazKIpMs5vmNGCY5n73o8CbZBaUmfBQ7pBCImpxi6dCnghge8oJTj0qkEvY
 abs/lU6aHmo2aYOly1kdo07OOPXd8g9BQJVb1yRx9An/qpT5ckb1JzN5/X3tEmqBu6ATQAl8VVG
 5qGI9GCqzTRaSNgdkLdN0Cn5k8+PxSVEUPU4KFV47TCyBP/gZOYnWMbRfk5vV+HtMB6M9/jWIOt
 SQEGvzFJPxuNnU8wXIJO+0yKJZ2Ev+E8+T7+Wp15xET85xmQ35S1o6eHoeRV2wV+2kx0V+/212y
 diiyZeyn9ezJD+ZxF8TnCOKgq7uXuLCtwrsc30rG7D39VF9C
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
 drivers/net/can/usb/gs_usb.c | 59 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 51f8d694104d..ac84857b89e6 100644
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
@@ -570,6 +575,37 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
 	return len;
 }
 
+static unsigned int
+gs_usb_get_minimum_length(const struct gs_can *dev, const struct gs_host_frame *hf,
+			  unsigned int *data_length_p)
+{
+	unsigned int minimum_length, data_length = 0;
+
+	if (hf->flags & GS_CAN_FLAG_FD) {
+		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX)
+			data_length = can_fd_dlc2len(hf->can_dlc);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			/* timestamp follows data field of max size */
+			minimum_length = struct_size(hf, canfd_ts, 1);
+		else
+			minimum_length = sizeof(hf->header) + data_length;
+	} else {
+		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX &&
+		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG)))
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
@@ -578,7 +614,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
-	unsigned int minimum_length;
+	unsigned int minimum_length, data_length;
 	struct gs_tx_context *txc;
 	struct can_frame *cf;
 	struct canfd_frame *cfd;
@@ -621,20 +657,33 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
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
@@ -643,7 +692,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
 
-			memcpy(cf->data, hf->classic_can->data, 8);
+			memcpy(cf->data, hf->classic_can->data, data_length);
 
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)

-- 
2.51.0


