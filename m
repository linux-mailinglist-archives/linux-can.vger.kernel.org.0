Return-Path: <linux-can+bounces-7065-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOb/FBT0r2nkdAIAu9opvQ
	(envelope-from <linux-can+bounces-7065-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 11:36:04 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A624970C
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ADEE30D72CD
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A193314D2;
	Tue, 10 Mar 2026 10:36:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE55255F28
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138961; cv=none; b=Hn48BVi8+W0ZpXtxbasdibcv71b+ZvpEVHwObJ048tww08WAoc+dBmSWvNH8jGJ7adD/qSTboC1M1jFywqZTarXZzqmnWN30SJTxtpz9bVPbvCutWYMi86c3wN0mqb4wTJ3DS4LD1R4+fZOk3Tsp1oyNUJmjyJPW8SHEF3+ORfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138961; c=relaxed/simple;
	bh=zrWMNn/NnSmL4C1as0kAxNg4jV7/eQEEWkOOrniMVbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFHOFulzq03JZf+xSN58wIEx7LBYxSQIfqup4Zza887o9M9qeIbVbZZaTwBWzT4BbWs4YmZsdl2t0RV1aJD+BER4Um0ZXus7GEyl8xGJXp5eMrQfJPm/jyYSWB5SlWvNEpMKELmCsT1fR+L2VGZqzscvGFabb3C5UL742VPyO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRO-0001Kn-Ik; Tue, 10 Mar 2026 11:35:54 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRM-004gN1-0P;
	Tue, 10 Mar 2026 11:35:53 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 306DB4FD2B0;
	Tue, 10 Mar 2026 10:35:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2026-03-10
Date: Tue, 10 Mar 2026 11:30:33 +0100
Message-ID: <20260310103547.2299403-1-mkl@pengutronix.de>
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
X-Rspamd-Queue-Id: A52A624970C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7065-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello netdev-team,

this is a pull request of 2 patches for net/main.

Haibo Chen's patch fixes the maximum allowed bit rate error, which was
broken in v6.19.

Wenyuan Li contributes a patch for the hi311x driver that adds missing
error checking in the caller of the hi3110_power_enable() function,
hi3110_open().

regards,
Marc

---

The following changes since commit e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69:

  mctp: i2c: fix skb memory leak in receive path (2026-03-10 11:10:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.0-20260310

for you to fetch changes up to 47bba09b14fa21712398febf36cb14fd4fc3bded:

  can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value (2026-03-10 11:12:52 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.0-20260310

----------------------------------------------------------------
Haibo Chen (1):
      can: dev: keep the max bitrate error at 5%

Wenyuan Li (1):
      can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value

 drivers/net/can/dev/calc_bittiming.c | 2 +-
 drivers/net/can/spi/hi311x.c         | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

