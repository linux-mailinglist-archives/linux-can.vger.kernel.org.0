Return-Path: <linux-can+bounces-6155-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A65D235C0
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BDD530D6140
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CB344023;
	Thu, 15 Jan 2026 09:06:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A7344021
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467974; cv=none; b=dnNhFjZH//YTE3z2A6fwytYKpYdcX68zD3iAqfJGEE/fWAj/k+g9kriIvl8otWPNeKEPHUk3nn9F4kKEdpKzr999pM6eOwHt+8PnxMDwCXANQAzLxySoDcMi69IW1+UEVm8P3worL68AtMrMvCmHygcuzs/qYt1vf3wsc1Yk0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467974; c=relaxed/simple;
	bh=v6HrDI9cHjNgf34ugiRGvSLeT0iHi/rraxnkXrDSAmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXKwhrjVGqZNxYlY8LqgPemJ+pNaB9bevFY5Vnf4BKry409mP23GD09E3XH0CuY4W9yxb/qX4r+7H/AjY6ifQHipRV6M5fQCwD9QTZflHKpdk4v1iIXlp8tAaVcqHGzmpdWBZJ/BC/QdkkTkWOOr7I4b68W0WCgw6LsaKmK/BHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIu-0004cP-TW; Thu, 15 Jan 2026 10:06:08 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIv-000jGP-1B;
	Thu, 15 Jan 2026 10:06:08 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 70DB74CD6AF;
	Thu, 15 Jan 2026 09:06:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2026-01-15
Date: Thu, 15 Jan 2026 09:57:07 +0100
Message-ID: <20260115090603.1124860-1-mkl@pengutronix.de>
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

Hello netdev-team,

this is a pull request of 4 patches for net/main, it super-seeds the
"can 2026-01-14" pull request. The dev refcount leak in patch #3 is
fixed.

The first 3 patches are by Oliver Hartkopp and revert the approach to
instantly reject unsupported CAN frames introduced in
net-next-for-v6.19 and replace it by placing the needed data into the
CAN specific ml_priv.

The last patch is by Tetsuo Handa and fixes a J1939 refcount leak for
j1939_session in session deactivation upon receiving the second RTS.

regards,
Marc

---

The following changes since commit 3879cffd9d07aa0377c4b8835c4f64b4fb24ac78:

  net/sched: sch_qfq: do not free existing class in qfq_change_class() (2026-01-13 19:36:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20260115

for you to fetch changes up to 1809c82aa073a11b7d335ae932d81ce51a588a4a:

  net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts (2026-01-15 09:52:39 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20260115

----------------------------------------------------------------
Marc Kleine-Budde (1):
      Merge patch series "can: raw: better approach to instantly reject unsupported CAN frames"

Oliver Hartkopp (3):
      Revert "can: raw: instantly reject unsupported CAN frames"
      can: propagate CAN device capabilities via ml_priv
      can: raw: instantly reject disabled CAN frames

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

 drivers/net/can/Kconfig       |  7 ++++--
 drivers/net/can/Makefile      |  2 +-
 drivers/net/can/dev/Makefile  |  5 +++--
 drivers/net/can/dev/dev.c     | 27 +++++++++++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 +++++++++++++
 drivers/net/can/vxcan.c       | 15 +++++++++++++
 include/linux/can/can-ml.h    | 24 ++++++++++++++++++++
 include/linux/can/dev.h       |  8 +------
 net/can/j1939/transport.c     | 10 ++++++++-
 net/can/raw.c                 | 51 +++++++++----------------------------------
 11 files changed, 111 insertions(+), 54 deletions(-)

