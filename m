Return-Path: <linux-can+bounces-6673-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLG/IdCspWmpDgAAu9opvQ
	(envelope-from <linux-can+bounces-6673-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:29:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7281DBD81
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23E6B302D70F
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E03FFAD9;
	Mon,  2 Mar 2026 15:28:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1D3FFAA5
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465284; cv=none; b=ni8/0v7wSReMKv3YxohAnrxvP0A4riO+8A9IavVIvi+oSr7tJhgY+X/t/Nc3hUcoIGY1jFsEqY4uuiY5cTuiHL8ibzi8gsyFR4kfw9mGkYb5OD3DD0R4vG0/L7n14paGD2uD36iYWXojUjG4v6pnBI8nRU10GCuC+dGO+BguIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465284; c=relaxed/simple;
	bh=oqYcm4znyuBVn5r4q35HNh3DKu9LmXNyIkDdANcPCZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCNldYluTbZV3cq4tkvmJSa5WgPWdhuTWF3nG71LIYdPy9QE2xoRcfbyYMX0qLivPiz37FOjBSA+ka3eMytN15kbFm1rMdWBX+9dg2VF5r+uIIqFJWhZhlkgQSqgCuIXdCQkjEZSYP1TnNHmUq9VjC4DzEb6CPDoYXkTr6axnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Be-0004kH-Ki; Mon, 02 Mar 2026 16:27:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0Y-11;
	Mon, 02 Mar 2026 16:27:57 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 674A44F5469;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/12] pull-request: can 2026-03-02
Date: Mon,  2 Mar 2026 16:16:06 +0100
Message-ID: <20260302152755.1700177-1-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: 4C7281DBD81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6673-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,pengutronix.de:mid]
X-Rspamd-Action: no action

Hello netdev-team,

this is a pull request of 12 patches for net/main.

The first 2 patches are by Oliver Hartkopp. The first fixes the
locking for CAN Broadcast Manager op runtime updates, the second fixes
the packet statisctics for the CAN dummy driver.

Alban Bedel's patch fixes a potential problem in the error path of the
mcp251x's ndo_open callback.

A patch by Ziyi Guo add USB endpoint type validation to the esd_usb
driver.

The next 6 patches are by Greg Kroah-Hartman and fix URB data parsing
for the ems_usb and ucan driver, fix URB anchoring in the etas_es58x,
and in the f81604 driver fix URB data parsing, add URB error handling
and fix URB anchoring.

A patch by me targets the gs_usb driver and fixes interoperability
with the CANable-2.5 firmware by always configuring the bit rate
before starting the device.

The last patch is by Frank Li and fixes a CHECK_DTBS warning for the
nxp,sja1000 dt-binding.

regards,
Marc

---

The following changes since commit 9439a661c2e80485406ce2c90b107ca17858382d:

  amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds (2026-02-28 14:22:34 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.0-20260302

for you to fetch changes up to 7e1e6d6845329adb2da75110a061557e9c26d9b7:

  dt-bindings: net: can: nxp,sja1000: add reference to mc-peripheral-props.yaml (2026-03-02 11:23:40 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.0-20260302

----------------------------------------------------------------
Alban Bedel (1):
      can: mcp251x: fix deadlock in error path of mcp251x_open

Frank Li (1):
      dt-bindings: net: can: nxp,sja1000: add reference to mc-peripheral-props.yaml

Greg Kroah-Hartman (6):
      can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      can: ucan: Fix infinite loop from zero-length messages
      can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
      can: usb: f81604: handle short interrupt urb messages properly
      can: usb: f81604: handle bulk write errors properly
      can: usb: f81604: correctly anchor the urb in the read bulk callback

Marc Kleine-Budde (2):
      Merge patch series "can: usb: f81604: handle short interrupt urb messages properly"
      can: gs_usb: gs_can_open(): always configure bitrates before starting device

Oliver Hartkopp (2):
      can: bcm: fix locking for bcm_op runtime updates
      can: dummy_can: dummy_can_init(): fix packet statistics

Ziyi Guo (1):
      can: esd_usb: add endpoint type validation

 .../devicetree/bindings/net/can/nxp,sja1000.yaml   |  1 +
 drivers/net/can/dummy_can.c                        |  1 +
 drivers/net/can/spi/mcp251x.c                      | 15 +++++++-
 drivers/net/can/usb/ems_usb.c                      |  7 +++-
 drivers/net/can/usb/esd_usb.c                      | 30 ++++++++-------
 drivers/net/can/usb/etas_es58x/es58x_core.c        |  8 +++-
 drivers/net/can/usb/f81604.c                       | 45 +++++++++++++++++++---
 drivers/net/can/usb/gs_usb.c                       | 22 ++++++++---
 drivers/net/can/usb/ucan.c                         |  2 +-
 net/can/bcm.c                                      |  1 +
 10 files changed, 104 insertions(+), 28 deletions(-)

