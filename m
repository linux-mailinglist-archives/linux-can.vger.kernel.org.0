Return-Path: <linux-can+bounces-6094-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253FD0D9D6
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6CF2301B64F
	for <lists+linux-can@lfdr.de>; Sat, 10 Jan 2026 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFC296BDA;
	Sat, 10 Jan 2026 17:29:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68A296BCC
	for <linux-can@vger.kernel.org>; Sat, 10 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066191; cv=none; b=TPNa3+v5CmBcTOzZUROWKiBSFvyEQAv80SA/uAl8UDhp71QDWBvyVUwzp+ytAYZMG6Ikw5AkDzw7krFJOoGPa5ApAJBg5pYkHgmuOOz2BmgTIU6Ijnd7uGS5F40tS0RV8pF5wb0ktdnpc/oRk9+mtAHtzxK5j76CKMH8+SImP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066191; c=relaxed/simple;
	bh=K7V50hRA1g/lopdgH1d8QMKGLZksfgzmzSywgK6VZV4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sdwd6JlHe+qGLB+2vp5qpbOXCNYWyhzqyyJHJSlH/nRAWWQIjFbhy/jxkLcHRrptkbAgKCRzAMxO4g3ezmIxnyyS2lvobdECFe6UQ9fqgsh1iysGuCB9mgA6wF+DmqHcWNEYGKRzdVUEWn/TZfN5la9HTNTET47TmqLXHOoUpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm5-0004Im-Pt; Sat, 10 Jan 2026 18:29:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vecm3-00AEGF-2K;
	Sat, 10 Jan 2026 18:29:15 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BDA734CA203;
	Sat, 10 Jan 2026 17:29:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can 0/5] can: usb: fix URB memory leaks
Date: Sat, 10 Jan 2026 18:28:51 +0100
Message-Id: <20260110-can_usb-fix-memory-leak-v1-0-4a7c082a7081@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOMYmkC/yWM0QqCQBBFf0XmuYFxBWP9lYhY10nHco0djUL89
 6Z6PJd7zgbKWVihKTbI/BSVORmUhwLiEFLPKJ0xOHI1leQxhnRZtcWrvHDiac5vvHO4IXXH2jO
 Rq3wFZj8y2+VXPoFJcP6PurYjx+XbhH3/AI+IVeuAAAAA
X-Change-ID: 20260109-can_usb-fix-memory-leak-0d769e002393
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=K7V50hRA1g/lopdgH1d8QMKGLZksfgzmzSywgK6VZV4=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpYoxf8pN5MKQCaEpOqZBvnhB3FAkuFKcaAu7G4
 0iWwWp0yFyJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWKMXwAKCRAMdGXf+ZCR
 nE7KCACcSA1lTeheeit/7L5j++09fS56urXucRffEMrPuq0OKcBwB4D7roQewnBLlAdBLqM7EHR
 9MvsYAcIzpveb2fuhJBz62AzBMO2XFUlvMeuF46FYSglFj6m60wg11PRrV33CY3C/PNBizQDZak
 QmM9fwfDcoANgBXCqT0lgVlK9sRAXtnMgVoK7ysDv6EkNbUI3KoBBWuFCqbRmvQy6tbRjFGGK2A
 IcabM0Lcbm6c9IBNXc3Ti+FyMMDHcdLHpQvLoY+Lr/IUBNtKrgLXJdSTpI2BdFsnfHrBMIiRh8I
 wqgO19Db5SDlokpNBajzVUAu9lOQMckbFFtd8L2b2xiphK9q
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

An URB memory leak [1] was recently fixed in the gs_usb driver. The driver
did not take into account that completed URBs are no longer anchored,
causing them to be lost during ifdown. The memory leak was fixed by
re-anchoring the URBs in the URB completion callback.

Several USB CAN drivers are affected by the same error. Fix them
accordingly.

[1] https://lore.kernel.org/all/20260109135311.576033-3-mkl@pengutronix.de/

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (5):
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak

 drivers/net/can/usb/ems_usb.c                    | 2 ++
 drivers/net/can/usb/esd_usb.c                    | 2 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 ++
 drivers/net/can/usb/mcba_usb.c                   | 2 ++
 drivers/net/can/usb/usb_8dev.c                   | 2 ++
 5 files changed, 10 insertions(+)
---
base-commit: 7470a7a63dc162f07c26dbf960e41ee1e248d80e
change-id: 20260109-can_usb-fix-memory-leak-0d769e002393

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


