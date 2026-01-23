Return-Path: <linux-can+bounces-6288-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDb+M86wc2nOxwAAu9opvQ
	(envelope-from <linux-can+bounces-6288-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:33:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60A790CF
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7551E30072A3
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DE21D3DC;
	Fri, 23 Jan 2026 17:32:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1217BEBF
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189572; cv=none; b=TmsLDSzRjsFlV4ltWFe3UWXsqSaphLhzFVlDw41vF4FrkjIi9byfmnM+hNYAuaDtH1SI9qHqM/J46KrIxa7uXZ08v7dG+IeMSUUVCz3YuHs1npFr9hZXIs3IVjj6gy/IjRKEQ5Pk+BzXSpB7mnPuyGI7wleDE3ch/K7j9s84RPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189572; c=relaxed/simple;
	bh=djbyUr2y8KkEBqL8lc3n1igmZv83fb14ai3mmjxWBoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qm490MN0PWZf7WUPMLNeIWMoYwNtnVnB/htaT7c02E1a87CS8Jr838CzDeImEqLPNdzd6RCPt8RIewX+malcy4gPGLz7/JSj5rnQazpZLUxy2c+gyBkyM7nWmtpDKxAhlIfJQk0v/6URV91AZVBH/MAZaaLq4gvH6106Tmi5xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL1a-0008Rr-Hq; Fri, 23 Jan 2026 18:32:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjL1Z-0028Ag-3B;
	Fri, 23 Jan 2026 18:32:45 +0100
Received: from blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9DF044D713C;
	Fri, 23 Jan 2026 17:32:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2026-01-23
Date: Fri, 23 Jan 2026 18:30:05 +0100
Message-ID: <20260123173241.1026226-1-mkl@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6288-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: EE60A790CF
X-Rspamd-Action: no action

Hello netdev-team,

this is a pull request of 2 patches for net/main.

The first patch is by Zilin Guan and fixes a memory leak in the error
path of the at91_can driver's probe function.

The last patch is by me and fixes yet another error in the gs_usb's
gs_usb_receive_bulk_callback() function.

regards,
Marc

---

The following changes since commit 5778d65d4b85d4929d30998863e08e20af4b6113:

  Merge branch 'vsock-virtio-fix-tx-credit-handling' (2026-01-22 15:41:36 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20260123

for you to fetch changes up to 494fc029f662c331e06b7c2031deff3c64200eed:

  can: gs_usb: gs_usb_receive_bulk_callback(): fix error message (2026-01-23 18:16:37 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20260123

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix error message

Zilin Guan (1):
      can: at91_can: Fix memory leak in at91_can_probe()

 drivers/net/can/at91_can.c   | 2 +-
 drivers/net/can/usb/gs_usb.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

