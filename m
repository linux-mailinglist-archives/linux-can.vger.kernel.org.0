Return-Path: <linux-can+bounces-5937-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B3CDDD73
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 15:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B65C3011F8A
	for <lists+linux-can@lfdr.de>; Thu, 25 Dec 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96B9227BB9;
	Thu, 25 Dec 2025 14:06:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB913777E
	for <linux-can@vger.kernel.org>; Thu, 25 Dec 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766671561; cv=none; b=uC/sjVqruzVHBRNQimzzbf7pV0AXGmBHU969BVmBUjfyFDz6AUdu5TxrsH4XrK7FWgb1RWhCKS0BnpNB8bJnAt+P1RRx3bJe68+d4ZyhoxWctEsO94xH8VDSFeOTFxSkCIeoeqd0Ds7/KQ44XaR87MPdJ+z6wGlF1X3BSI30Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766671561; c=relaxed/simple;
	bh=kb0rcIPhzDRBzdq1lZNCLSjEdWIBdhESTBP5Ck7p1QQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Invqyl7luhRA9x0ttQkNNVCPp7C8lthmIgqllTVxU12lHEtUAVirY2536jrBFmLaffLk5NMhQ6taZWDFT4UI/r3rRLBSiC0gTj8araXH75ienyUSSvbr9+MhGRPXEc24IdiSYvVD8NCgbWJn5Btpsi7P/4pSLwz7nmaj01j6830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vYlyO-0006Xm-TV; Thu, 25 Dec 2025 15:05:48 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vYlyO-007QJs-26;
	Thu, 25 Dec 2025 15:05:48 +0100
Received: from hardanger.blackshift.org (2a02-8206-2427-4700-1e0b-5707-3eab-e71d.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:2427:4700:1e0b:5707:3eab:e71d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C0704BEB2C;
	Thu, 25 Dec 2025 14:05:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 25 Dec 2025 15:05:43 +0100
Subject: [PATCH can] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB
 memory leak
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251225-gs_usb-fix-memory-leak-v1-1-a7b09e70d01d@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALZETWkC/yWM0QqCQBBFf0XucwM6ZGi/EhHrNNlUrrGTUYj/3
 laP53LPmeGaTB3bYkbSp7mNMUO1KiDnEHslO2YGl1xXzDX1fpi8o5O9aNBhTG+6abhSuWHhddM
 2Ii2yfE+aL7/wDhIi9v/Rp+6i8vgmsSwfOjJk+H8AAAA=
X-Change-ID: 20251225-gs_usb-fix-memory-leak-062c24898cc9
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=kb0rcIPhzDRBzdq1lZNCLSjEdWIBdhESTBP5Ck7p1QQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpTUS5lkModWqrW7oHkRp3nVJvwGre3gz/eBFL8
 zfzx+xr7VOJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaU1EuQAKCRAMdGXf+ZCR
 nA1OB/94mjwjqLIigSA9GT90vLnmDo4o3JkhuMaaeUL1hFw0DYz/4EbEkIQol+LReSTqqxhg1Dh
 /uOPVA2F02qozORXz+eqf5IDG7SyD8pJT3NGdrUOaojxkNxXFp/oLGMPVAMbS3y3M8mPhjmHxFI
 woT2l5rdDLgkBr9BPDzoGJWE6V/o7qldlCH8nHBviT/Yg3QJRHHfHHbJBjMGFa31rTjTzdL6Wsf
 VpI58OqVaqJY1zrIOOvqt1fJWx5nM4ERt/6beNq02rpXE64bZt0wkU3BRlNEU/OXHcDaKi2wHLw
 +E4KkvkazA5BQTH6ASehtNwHF7x7rruz1xrvJcFB4m1/xeur
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
parent->rx_submitted anchor and submitted. In the complete callback
gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
gs_can_close() the URBs are freed by calling
usb_kill_anchored_urbs(parent->rx_submitted).

However, this does not take into account that the USB framework
unanchors the URB before the close function is called. This means that
once an in-URB has been completed, it is no longer anchored and is
ultimately not released in gs_can_close().

Fix the memory leak by anchoring the URB in the
gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.

Fixes: f16623a04943 ("can: gs_usb: fix")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a0233e550a5a..d093babbc320 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -751,6 +751,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			  hf, parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
+	usb_anchor_urb(urb, &parent->rx_submitted);
+
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
 	/* USB failure take down all interfaces */

---
base-commit: 6402078bd9d1ed46e79465e1faaa42e3458f8a33
change-id: 20251225-gs_usb-fix-memory-leak-062c24898cc9

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


