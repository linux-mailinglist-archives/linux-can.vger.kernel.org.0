Return-Path: <linux-can+bounces-7312-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKmDEJTLzGlFWwYAu9opvQ
	(envelope-from <linux-can+bounces-7312-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Apr 2026 09:39:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E255F376128
	for <lists+linux-can@lfdr.de>; Wed, 01 Apr 2026 09:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408893126BBC
	for <lists+linux-can@lfdr.de>; Wed,  1 Apr 2026 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AE385523;
	Wed,  1 Apr 2026 07:33:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6937F745
	for <linux-can@vger.kernel.org>; Wed,  1 Apr 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028838; cv=none; b=rK2HLm8ge2z9I9KgsZCI7ARiOIkHIGpu8nqVsbMxSXisFhbuZ8eeNT7s/3qc1QKH6pR3TYJYJXePGHOTA+ok3jtdTb1RPIGo0O02dInSIzSJhLRQ6pRHu/xNpmsxFRWGvPQX4bMg5iVq+hxn+cD48S7862WxIFS7pJVCbFUhs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028838; c=relaxed/simple;
	bh=/Bl1O4sytSPWbTDLt0UZg3ZvSglhwogCfG8r6+fa9mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmhHKxgp7O+358R/JdVOGHOwJ7UTyJKOnPeiWNTaLmQcdZkkJ4Q/TA4ATRz3iSCntYdFxtDp1O3xranUgVVOnpl188snB9So0nqsD1LfQcFucoI4sVdhaWhqiG7i7meQlv/S+Zzd6v4S8+NoIR6m9xD0ousauFxUJ2sgTXyJ8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-00077B-T8; Wed, 01 Apr 2026 09:33:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-003Ahh-2C;
	Wed, 01 Apr 2026 09:33:41 +0200
Received: from blackshift.org (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 52B39513379;
	Wed, 01 Apr 2026 07:33:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Johan Hovold <johan@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 6/6] can: ucan: refactor endpoint lookup
Date: Wed,  1 Apr 2026 09:30:14 +0200
Message-ID: <20260401073338.5592-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401073338.5592-1-mkl@pengutronix.de>
References: <20260401073338.5592-1-mkl@pengutronix.de>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-7312-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.616];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: E255F376128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining endpoint numbers and max packet sizes) instead of open
coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260330101817.1664787-3-johan@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 40 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0ea0ac75e42f..506d9e74aa79 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1302,13 +1302,12 @@ static int ucan_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	int ret;
-	int i;
 	u32 protocol_version;
 	struct usb_device *udev;
 	struct net_device *netdev;
 	struct usb_host_interface *iface_desc;
 	struct ucan_priv *up;
-	struct usb_endpoint_descriptor *ep;
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	u16 in_ep_size;
 	u16 out_ep_size;
 	u8 in_ep_addr;
@@ -1343,37 +1342,20 @@ static int ucan_probe(struct usb_interface *intf,
 	}
 
 	/* check interface endpoints */
-	in_ep_addr = 0;
-	out_ep_addr = 0;
-	in_ep_size = 0;
-	out_ep_size = 0;
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		ep = &iface_desc->endpoint[i].desc;
-
-		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
-		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
-		     USB_ENDPOINT_XFER_BULK)) {
-			/* In Endpoint */
-			in_ep_addr = ep->bEndpointAddress;
-			in_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
-			in_ep_size = le16_to_cpu(ep->wMaxPacketSize);
-		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
-			    0) &&
-			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
-			    USB_ENDPOINT_XFER_BULK)) {
-			/* Out Endpoint */
-			out_ep_addr = ep->bEndpointAddress;
-			out_ep_addr &= USB_ENDPOINT_NUMBER_MASK;
-			out_ep_size = le16_to_cpu(ep->wMaxPacketSize);
-		}
-	}
-
-	/* check if interface is sane */
-	if (!in_ep_addr || !out_ep_addr) {
+	ret = usb_find_common_endpoints_reverse(iface_desc, &ep_in, &ep_out,
+						NULL, NULL);
+	if (ret) {
 		dev_err(&udev->dev, "%s: invalid endpoint configuration\n",
 			UCAN_DRIVER_NAME);
 		goto err_firmware_needs_update;
 	}
+
+	in_ep_addr = usb_endpoint_num(ep_in);
+	out_ep_addr = usb_endpoint_num(ep_out);
+	in_ep_size = usb_endpoint_maxp(ep_in);
+	out_ep_size = usb_endpoint_maxp(ep_out);
+
+	/* check if interface is sane */
 	if (in_ep_size < sizeof(struct ucan_message_in)) {
 		dev_err(&udev->dev, "%s: invalid in_ep MaxPacketSize\n",
 			UCAN_DRIVER_NAME);
-- 
2.53.0


