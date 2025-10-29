Return-Path: <linux-can+bounces-5284-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC82C1DAC8
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 00:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB21D4E499D
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE692F659C;
	Wed, 29 Oct 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YHIcVqvY"
X-Original-To: linux-can@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7303126DB
	for <linux-can@vger.kernel.org>; Wed, 29 Oct 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779824; cv=none; b=GwEqREGdEvq+bEr8/wxonXkHCA4xLryv9CK21deN7+QHDYbDTtVL/XCAIGkD1ee/tT6wpPvOLtFG+1Ct7p/rbLjOjR1ldNE88OX/rEAFkF2sIxZR/mrjNxj+5jMLAuf+7HiqEE08uYFa8rJLs4TQjOPl571PhiRk7Jsmz+m7MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779824; c=relaxed/simple;
	bh=cP/E0UtTvLT5kA+y+5AJ18XhQ9ID9hIrisjBFl98hS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poKBO4WSQcherUnqIgn+0Pk5RlfuPTfPFZ5QZRDU6pdCvFLVA0bmdy2qq+Ko1Ig9c7UPAYliFF2lYSwuVHO49IlOVzu6y0WeHLThzwCX3uHdPE8yop3dX3KZ/uofHJ5PYOnOZHI7O7WwLFhNDxFJugdqwW0eJMTvRgY3BjbKBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YHIcVqvY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761779810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7GRMsgY5PXoW9VIB8TwvQXxaspHY0XUl81B7+M13ZE8=;
	b=YHIcVqvYLd6udIjcpeIwb1c2pniuN/1lai3BCqPzvCiJft44SoI8yapz4rG6QpPbjVRm5r
	OrCRwaCiDv1S8Q61QAWsv1B6Zbdtc2f4Me0+nnoH6rFUhWML88NMoo349Ka4x5oBZNOof0
	rGj8hYw1YgN9HOxpBjeqRTxiQ8KeH7w=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	socketcan@esd.eu,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/3] convert can drivers to use ndo_hwtstamp callbacks
Date: Wed, 29 Oct 2025 23:16:17 +0000
Message-ID: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The patchset converts generic ioctl implementation into a pair of
ndo_hwtstamp_get/ndo_hwtstamp_set generic callbacks and replaces
callbacks in drivers.

Vadim Fedorenko (3):
  can: convert generic HW timestamp ioctl to ndo_hwtstamp callbacks
  can: peak_canfd: convert to use ndo_hwtstamp callbacks
  can: peak_usb: convert to use ndo_hwtstamp callbacks

 drivers/net/can/dev/dev.c                     | 45 +++++++++----------
 drivers/net/can/esd/esd_402_pci-core.c        |  3 +-
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  3 +-
 drivers/net/can/peak_canfd/peak_canfd.c       | 35 +++++++--------
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  3 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  3 +-
 drivers/net/can/usb/gs_usb.c                  | 20 +++++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  | 39 ++++++++--------
 include/linux/can/dev.h                       |  6 ++-
 10 files changed, 88 insertions(+), 72 deletions(-)

-- 
2.47.3


