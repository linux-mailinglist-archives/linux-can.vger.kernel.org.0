Return-Path: <linux-can+bounces-6232-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLvUGalocGkVXwAAu9opvQ
	(envelope-from <linux-can+bounces-6232-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 06:48:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F451AFD
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 06:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11FFE68461A
	for <lists+linux-can@lfdr.de>; Tue, 20 Jan 2026 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9943DA32;
	Tue, 20 Jan 2026 12:52:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2E43CEDC
	for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913573; cv=none; b=Ntgv815DZzEbi+xXbV5Kixh2Ej53YtxkMBDeXboSjL0bf1x8kzftUBv+sQTReU3x+umpG6Fi5T48Atz6Df97tPOQkCwSQxjb70rCZ6hZYggN/wWsHbluXRTo8saLyrOsRkbcAM7HO/0y5lueBydzyDL0aYlxH0cudhZF1z1m3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913573; c=relaxed/simple;
	bh=NMjz6QW82APUPZl8CmhkRZvslMCCC/6N8F6HTClBBj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AOfd9gX//aau4P0CQy/HukqyRNaIX6duGxRc6rGgJxjrsWa44jXj7U2ZylZPrmOF1OV4iKVU2MEs8E4TeVTMWEmCe+9m//6RNvck3/1YFdXBP7oSlhQ5VI/j4B/ZaoYJkutxEp5Lm9IB7u0gvQreObh2BFEEgrVQBeKUsI04zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1viBDt-0000q7-E1; Tue, 20 Jan 2026 13:52:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1viBDt-001aQW-2t;
	Tue, 20 Jan 2026 13:52:41 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E77F34D3399;
	Tue, 20 Jan 2026 12:52:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 20 Jan 2026 13:52:30 +0100
Subject: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): fix error
 message
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-gs_usb-fix-error-message-v1-1-6be04de572bc@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAI56b2kC/yWM0QqCQBAAf0X2uYW9OxDrVyLCO1fdII3dDEH8d
 7d6HJiZDYxV2OBSbaD8EZN5cginCsrYTgOjdM4QKdYUIuFg98Uy9rIiq86KTzZr3aNMnPompXM
 o4PlL2aXf+nr7sy35weX9/cG+HyXMzVt8AAAA
X-Change-ID: 20260120-gs_usb-fix-error-message-0b0e3f83391c
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NMjz6QW82APUPZl8CmhkRZvslMCCC/6N8F6HTClBBj0=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpb3qQrOd5okeMSn/3Vv5n9cVU0L3AXHdftHhJO
 TKzWchJxkCJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaW96kAAKCRAMdGXf+ZCR
 nMHKB/98djy9/lvCgiLDe8btY0W8DaEB/D5Mh2+aeP1eJjAi6VjFT8imS3mGKN/MBoxpKcV6QaH
 xvBo92LFBtACurJEZQh7buPmcKV37Xwa/CISshSXmrbCA3cgVPFcCwp+bNKmBhurtmW1L5xRh7A
 UxndPn1exUe55gIaU+7DarFhTDID5njxtDRjVTLWiblx8KH0UC0GZMDCzutJfz3ghs22wORENgE
 MCDT+uxzhzP1dbn8trPqtumdGf0to6B/KmuAnhLuajRggKMGXSgyKIgSRTpYzQCrLIAhyorY5u1
 oDtHwvqVELEDVt6yda/wz96LPdHJEY4Xdr3z4CfXIH69WZuJ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-6232-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: 074F451AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sinc commit 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback():
unanchor URL on usb_submit_urb() error") a failing resubmit URB will print
an info message.

In the case of a short read where netdev has not yet been assigned,
initialize as NULL to avoid dereferencing an undefined value. Also report
the error value of the failed resubmit.

Fixes: 79a6d1bfe114 ("can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260119181904.1209979-1-kuba@kernel.org/
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 192338b481f2..d8b2dd74b3a1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -610,7 +610,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 {
 	struct gs_usb *parent = urb->context;
 	struct gs_can *dev;
-	struct net_device *netdev;
+	struct net_device *netdev = NULL;
 	int rc;
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
@@ -768,7 +768,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		}
 	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
 		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
-			    ERR_PTR(urb->status));
+			    ERR_PTR(rc));
 	}
 }
 

---
base-commit: 58bae918d73e3b6cd57d1e39fcf7c75c7dd1a8fe
change-id: 20260120-gs_usb-fix-error-message-0b0e3f83391c

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


