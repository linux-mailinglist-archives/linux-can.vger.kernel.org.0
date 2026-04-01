Return-Path: <linux-can+bounces-7306-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDvbFKPNzGlFWwYAu9opvQ
	(envelope-from <linux-can+bounces-7306-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Apr 2026 09:47:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D273763F9
	for <lists+linux-can@lfdr.de>; Wed, 01 Apr 2026 09:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 594D730C7B8E
	for <lists+linux-can@lfdr.de>; Wed,  1 Apr 2026 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E537E30A;
	Wed,  1 Apr 2026 07:33:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEDA2E542C
	for <linux-can@vger.kernel.org>; Wed,  1 Apr 2026 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028835; cv=none; b=iaZ0vF53UsgvVJdyoD8rXQufoH6NJQ9oMCUJRYiGQc16yxc4Y3g5F7RY+2oyMXpYKIZ4euh1Cj1oi9+wCQbb0jXGu5x85Ozdvy47ihIfIUdWe3BYsrFUSelVvVmj0gqWiP1nrGt41mgTbShwgzq1Yst/XgaFmCSyvJMO532phR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028835; c=relaxed/simple;
	bh=hdflUWalle47wvavTKoBbyFh0m5OhsZ3UXRrYZLUEFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfwQjLrZMAHc9M2vwdmjXTXyhB6mUneXY2MFUftmALGQ4pxuJU+vOGzxqpXIMoeJ0FL9xAz9tEVRCAgEA3AegvWkaKJ5A5y8to3JJ85vYIDGqYPVUnyqtNEuf+rEFfZdtjfjwoc8Uxdxs4kD7xYaC7NtP8nzcS1warnMRKHYFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q57-000765-JP; Wed, 01 Apr 2026 09:33:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7q56-003AhQ-1b;
	Wed, 01 Apr 2026 09:33:40 +0200
Received: from blackshift.org (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1BFAE513373;
	Wed, 01 Apr 2026 07:33:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/6] pull-request: can-next 2026-04-01
Date: Wed,  1 Apr 2026 09:30:08 +0200
Message-ID: <20260401073338.5592-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7306-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56D273763F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello netdev-team,

this is a pull request of 6 patches for net-next/main.

The first patch is by Ethan Nelson-Moore and removes a useless copy of
PCI_DEVICE_DATA from the ctucanfd driver.

Geert Uytterhoeven's patch for the rcar_can converts the driver to use
the FIELD_MODIFY macro.

Viken Dadhaniya contributes 2 patches for the mcp251xfd driver that
add transceiver standby control.

The last 2 aptches are by Johan Hovold and refactor the usb endpoint
lookup of the kvaser_usb and ucan driver.

regards,
Marc

---

The following changes since commit f1359c240191e686614847905fc861cbda480b47:

  net/iucv: Add missing kernel-doc return value descriptions (2026-03-31 20:14:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.1-20260401

for you to fetch changes up to 50b4927288144fbd2f947b0e4c0ef32949587e67:

  Merge patch series "can: refactor USB endpoint lookups" (2026-04-01 09:27:58 +0200)

----------------------------------------------------------------
linux-can-next-for-7.1-20260401

----------------------------------------------------------------
Ethan Nelson-Moore (1):
      net: can: ctucanfd: remove useless copy of PCI_DEVICE_DATA macro

Geert Uytterhoeven (1):
      can: rcar_can: Convert to FIELD_MODIFY()

Johan Hovold (2):
      can: kvaser_usb: leaf: refactor endpoint lookup
      can: ucan: refactor endpoint lookup

Marc Kleine-Budde (2):
      Merge patch series "can: mcp251xfd: add XSTBYEN transceiver standby control"
      Merge patch series "can: refactor USB endpoint lookups"

Viken Dadhaniya (2):
      dt-bindings: can: mcp251xfd: add microchip,xstbyen property
      can: mcp251xfd: add support for XSTBYEN transceiver standby control

 .../bindings/net/can/microchip,mcp251xfd.yaml      |  8 +++++
 drivers/net/can/ctucanfd/ctucanfd_pci.c            |  8 -----
 drivers/net/can/rcar/rcar_can.c                    |  3 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 37 ++++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |  1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   | 25 +++++---------
 drivers/net/can/usb/ucan.c                         | 40 ++++++----------------
 7 files changed, 66 insertions(+), 56 deletions(-)

