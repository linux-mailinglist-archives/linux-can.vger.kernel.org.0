Return-Path: <linux-can+bounces-6095-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F418BD0D9D3
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 762DF300CF02
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9736B29993D;
	Sat, 10 Jan 2026 17:29:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0E28D850
	for <linux-can@vger.kernel.org>; Sat, 10 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066191; cv=none; b=HwZgikwHkd5ICRN3boNO4VxvGww+z51zJcIwxGRiDeUVL9ygNPb/P91BCssB51F/gfWcgzgDwzg1q/X4LqTtFdgFENjmWKnWdp1tebcSpcfoWN3wH1ZE2XN8y9OTREDQcYwNlaQA1PdxuzH8QoIsbgeYeG1i/iIU80LIJLwg4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066191; c=relaxed/simple;
	bh=bugZjGGJr0BTLoSY0RX9evgMGVU7+BDACt3oLqrmfiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwhnAjrhbMXY8A6B6U+EoOz8qZPKkSl3kjIYqXWmNjSnzZ7KROepCkXdOWhrz1Nzr6KKXIHD5pX0bCvFlhL1dzEcuqb3nwHk9KCk/HPLwZxP1gVt04uf57O6Xu2mIu+QdTswjuDYGmWi2o6GgybVFE7YyWjvzlT21HMqeLTTjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm5-0004J6-Pt; Sat, 10 Jan 2026 18:29:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm4-00AEGI-1L;
	Sat, 10 Jan 2026 18:29:16 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8A3FE4CA204;
	Sat, 10 Jan 2026 17:29:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 10 Jan 2026 18:28:52 +0100
Subject: [PATCH can 1/5] can: ems_usb: ems_usb_read_bulk_callback(): fix
 URB memory leak
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-can_usb-fix-memory-leak-v1-1-4a7c082a7081@pengutronix.de>
References: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
In-Reply-To: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Sebastian Haas <haas@ems-wuensche.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, 
 Yasushi SHOJI <yashi@spacecubics.com>, Daniel Berglund <db@kvaser.com>, 
 Olivier Sobrie <olivier@sobrie.be>, 
 =?utf-8?q?Remigiusz_Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, 
 Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=bugZjGGJr0BTLoSY0RX9evgMGVU7+BDACt3oLqrmfiE=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpYoxh1RY/m8CCCrdFH6QsE8NVCan9otwjYlA5h
 knVVEoFJfaJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWKMYQAKCRAMdGXf+ZCR
 nF9xCACGyOVKURclPrLDsexUe/n/a1x8NkErpAFdtu6GkJWryqcUpa2J9wVNcJmHmUvqzS6Tuqa
 EV2nl8ol0oFVN/s6kRvhEV2pp6/LKlvRP8+Jz+w9TmhJjdS9E1vvFDfwGvGJ9KQZwFwTaXjpj77
 hQmXvany86cnKi110PGNVFgEEUlGzMuU3/CtD8U0mX8FTQo4NLmUFBfGtY+H7Z/6e0r9PQjE0zr
 neQac4OgDyw/CKxoQE4Ls/t9bxzxYh25f5z47dq9CadhEI/mt8USCN1CwhvmUcZtxAqRn88++V7
 hkLOUIrAa5picHc30yylDyAjFDBp5qV4D6rkOkxvEML59+cU
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Fix similar memory leak as in commit 7352e1d5932a ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak").

In ems_usb_open(), the URBs for USB-in transfers are allocated, added to
the dev->rx_submitted anchor and submitted. In the complete callback
ems_usb_read_bulk_callback(), the URBs are processed and resubmitted. In
ems_usb_close() the URBs are freed by calling
usb_kill_anchored_urbs(&dev->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in ems_usb_close().

Fix the memory leak by anchoring the URB in the
ems_usb_read_bulk_callback() to the dev->rx_submitted anchor.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index de8e212a1366..f44737312b04 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -486,6 +486,8 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, RX_BUFFER_SIZE,
 			  ems_usb_read_bulk_callback, dev);
 
+	usb_anchor_urb(urb, &dev->rx_submitted);
+
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 
 	if (retval == -ENODEV)

-- 
2.51.0


