Return-Path: <linux-can+bounces-6422-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RcMnFEfWfWn/TwIAu9opvQ
	(envelope-from <linux-can+bounces-6422-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:15:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED8C1823
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411BD30086C8
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30EA33DEFA;
	Sat, 31 Jan 2026 10:15:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9B30AD0D
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854532; cv=none; b=RVAcuXOIQG4nfH/PpQfQdsaeAI9EMNTp04hCn9VyL0t1rM4PYHEEFDF9n2rIqsHLGZ7OTQPytHfZLJPVfsnxmHyQfl33ny/zxI2f4R9SI4FljwBr0FeG3CY/WpnhcsTgN4sAHDt8MWiA5NYYY7JMO3hU/DPqq1RsP5d+xnFRnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854532; c=relaxed/simple;
	bh=YmbOhiK6GjcEGD/K0EU/sAh8QYSSjYPqGtAYy75SJ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHpqguSuFg172EZ19PctBnV0c2cFoIft7yoVmfaILJ7MhzQ5T2/4CieaneShU3kF87ortBSa3NlRxYnWcFFlfce0DvYRwFZg1YwmF2xPxPAetXvBtt+7awLvkxSuDc1nIXrcXOgASrTG+F5VZ+u3zN+M20ng0VmHOYBDmIJ06xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80b-0002Py-VE; Sat, 31 Jan 2026 11:15:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vm80b-003OWE-1x;
	Sat, 31 Jan 2026 11:15:16 +0100
Received: from blackshift.org (unknown [IPv6:2001:67c:1810:f051:d04a:1c63:e2:421c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5A8344DC56B;
	Sat, 31 Jan 2026 10:15:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/8] pull-request: can-next 2026-01-31
Date: Sat, 31 Jan 2026 11:11:41 +0100
Message-ID: <20260131101512.1958907-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6422-lists,linux-can=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9DED8C1823
X-Rspamd-Action: no action

Hello netdev-team,

this is a pull request of 8 patches for net-next/main.

This first 2 patches are by Biju Das, target the rcar_canfd driver and
add support for FD-only mode.

Lad Prabhakar's patches, also for the rcar_canfd driver add support
for the RZ/T2H SoC.

The last 2 patches are by Michael Tretter and me, target the sja1000
driver and clean up the CAN state handling.

regards,
Marc
---

The following changes since commit 74ecff77dace0f9aead6aac852b57af5d4ad3b85:

  xgbe: Use netlink extack to report errors to ethtool (2026-01-15 20:02:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.20-20260131

for you to fetch changes up to 173eb9a902d1d9ce6d0d6a88546f0f7a07bfbdf4:

  Merge patch series "can: sja1000: clean up CAN state handling" (2026-01-23 14:37:27 +0100)

----------------------------------------------------------------
linux-can-next-for-6.20-20260131

----------------------------------------------------------------
Biju Das (2):
      dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
      can: rcar_canfd: Add support for FD-Only mode

Lad Prabhakar (4):
      dt-bindings: can: renesas,rcar-canfd: Specify reset-names
      dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
      dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
      can: rcar_canfd: Add RZ/T2H support

Marc Kleine-Budde (4):
      Merge patch series "Add FD-Only mode support for R-Car CANFD"
      Merge patch series "Add CANFD support to R9A09G056/057/077/087 SoCs"
      can: sja1000: sja1000_err(): make use of sja1000_get_berr_counter() to read error counters
      Merge patch series "can: sja1000: clean up CAN state handling"

Michael Tretter (1):
      can: sja1000: sja1000_err(): use error counter for error state

 .../bindings/net/can/renesas,rcar-canfd.yaml       | 117 ++++++++++++++++++---
 drivers/net/can/rcar/rcar_canfd.c                  |  32 +++++-
 drivers/net/can/sja1000/sja1000.c                  |  42 ++------
 3 files changed, 142 insertions(+), 49 deletions(-)

