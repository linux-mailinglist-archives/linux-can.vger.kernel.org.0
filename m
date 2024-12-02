Return-Path: <linux-can+bounces-2295-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F09DFC8B
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE47281C5C
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E751F9ECD;
	Mon,  2 Dec 2024 09:00:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD002EAE4
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130049; cv=none; b=m/BOi5rPrezPk3KnhF6TnWOcxbxrTfNcv5+kxdFz34XzlUFEGoyReNyOeKBFrznvTwD+KuwFZnsQS8dZMFA5d0ADNITuJbN/r2c8OdRYolu31jyZ6zlj65NeMTXDK82Q/QWD99zy321r+iTVyKg2vXY+zj/wvm27w9q+4V0gjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130049; c=relaxed/simple;
	bh=X/Jfr+UcVrrfKJZ6+BKicGN8tooHWngW023BWsuf3zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WobPwpoPCklMs3MEC8FPkyHdFn7BIHhE7PwUs/SlexyoiZdme6AR+l3tLLqAsZyVPgzqbYWL4VNtghOprEjiVpaVCk59KUhpBYW1DI3NClDAVWDQqnvu8n3dLWZtyc/I6QpYjiRekAhMiWK5fI6trm6/jDp/z6OffWmDc2oFxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IQ-0007aP-K5
	for linux-can@vger.kernel.org; Mon, 02 Dec 2024 10:00:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IP-001GWn-1F
	for linux-can@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:46 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A9ED5383334
	for <linux-can@vger.kernel.org>; Mon, 02 Dec 2024 09:00:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5409E38331A;
	Mon, 02 Dec 2024 09:00:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e589725b;
	Mon, 2 Dec 2024 09:00:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/15] pull-request: can 2024-12-02
Date: Mon,  2 Dec 2024 09:55:34 +0100
Message-ID: <20241202090040.1110280-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
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

this is a pull request of 14 patches for net/master.

The first patch is by me and allows the use of sleeping GPIOs to set
termination GPIOs.

Alexander Kozhinov fixes the gs_usb driver to use the endpoints
provided by the usb endpoint descriptions instead of hard coded ones.

Dario Binacchi contributes 11 statistics related patches for various
CAN driver. A potential use after free in the hi311x is fixed. The
statistics for the c_can, sun4i_can, hi311x, m_can, ifi_canfd,
sja1000, sun4i_can, ems_usb, f81604 are fixed: update statistics even
if the allocation of the error skb fails and fix the incrementing of
the rx,tx error counters.

A patch by me fixes the workaround for DS80000789E 6 erratum in the
mcp251xfd driver.

The last patch is by Dmitry Antipov, targets the j1939 CAN protocol
and fixes a skb reference counting issue.

regards,
Marc

---

The following changes since commit 9bb88c659673003453fd42e0ddf95c9628409094:

  selftests: net: test extacks in netlink dumps (2024-11-24 17:00:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.13-20241202

for you to fetch changes up to a8c695005bfe6569acd73d777ca298ddddd66105:

  can: j1939: j1939_session_new(): fix skb reference counting (2024-12-02 09:53:39 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.13-20241202

----------------------------------------------------------------
Alexander Kozhinov (1):
      can: gs_usb: add usb endpoint address detection at driver probe step

Dario Binacchi (11):
      can: c_can: c_can_handle_bus_err(): update statistics if skb allocation fails
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL
      can: hi311x: hi3110_can_ist(): fix potential use-after-free
      can: hi311x: hi3110_can_ist(): update state error statistics if skb allocation fails
      can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
      can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statistics
      can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
      can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
      can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
      can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors statistics

Dmitry Antipov (1):
      can: j1939: j1939_session_new(): fix skb reference counting

Marc Kleine-Budde (3):
      can: dev: can_set_termination(): allow sleeping GPIOs
      Merge patch series "Fix {rx,tx}_errors CAN statistics"
      can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.

 drivers/net/can/c_can/c_can_main.c            | 26 +++++++----
 drivers/net/can/dev/dev.c                     |  2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c         | 58 ++++++++++++++++--------
 drivers/net/can/m_can/m_can.c                 | 33 +++++++++-----
 drivers/net/can/sja1000/sja1000.c             | 65 ++++++++++++++++-----------
 drivers/net/can/spi/hi311x.c                  | 53 +++++++++++++---------
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 29 +++++++++++-
 drivers/net/can/sun4i_can.c                   | 22 +++++----
 drivers/net/can/usb/ems_usb.c                 | 58 +++++++++++++-----------
 drivers/net/can/usb/f81604.c                  | 10 +++--
 drivers/net/can/usb/gs_usb.c                  | 25 ++++++++---
 net/can/j1939/transport.c                     |  2 +-
 12 files changed, 251 insertions(+), 132 deletions(-)


