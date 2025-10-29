Return-Path: <linux-can+bounces-5273-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21CC182E9
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 04:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEF51C6152A
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACB2EA737;
	Wed, 29 Oct 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ls3Lksbn"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com [220.197.32.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C627D77D;
	Wed, 29 Oct 2025 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708508; cv=none; b=X+RzG461/NTc9iR4OhsfiO2Zaxfm60uBCCT4zoX72tPgjiBg8bXSJv09TUPumZdCZDXw4ObQJjRqrR/jGWGAxIVR0m//jqSr1RyyFlXSFIIB5ASvnqO9SZb04NLhtr3AOT6paoukxGFNCAoileT7bf0rG7/oKVR9LzHdq9Juofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708508; c=relaxed/simple;
	bh=ous4ekECHCVh+bwS4QqLshbet6cQu7pTxp9rlTcxeGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D8UCUI7r0wptqfbgOIiFEe755fG3yYmwhe0ODB2M7uZXZcANt9w557XAEH037uZDqCcUwV+u6Ed6eQClbfmQO8454MfsXBXFtsyudIZ/4UPH/JAuLu51MQHu2YLGgokdGywrT4YPCRoNPgeMeDXnEtRlCuz//D82SKO4YpvAiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ls3Lksbn; arc=none smtp.client-ip=220.197.32.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 279245ee8;
	Wed, 29 Oct 2025 11:23:04 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v8 0/4] rockchip: add can for RK3576 Soc
Date: Wed, 29 Oct 2025 11:22:58 +0800
Message-Id: <20251029032302.1238973-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2dfd94c903a3kunm7a63a81221fa97
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk4eGFZOGR1NTEMfGk9KTh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ls3LksbnYXmhl9tXfUdaMaCsM+8IBaYUCjoPlX6zN+hOaDQ4ygEmoiSvWKNTD+Z0fQ0786OyWnvAqLGnH4RmD2tR6Wut9VX0ugdox9uDVd3rEX8hJHL4rKLecqe0ZFurvtRBt7ywm+6nZLnf7isyOxSdSFmx5cmBAGMrIHlIm9Q=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=au2n4rrZx8SO4PVuqq8XAKDLJGp5zKXJpUNLmozR0c8=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller,new register layout and Bit position
definition:
Support CAN protocol.
Support Dma.

There are major differences from the previous rk3568.
All errata on the rk3568 have been fixed and redesigned.

RK3576 CANFD requires authorization and permission. The software
code is not open by default and needs to be authorized separately.

Change in V8:
[PATCH v8 1/4]: Drop CANFD, correction format warning.
[PATCH v8 2/4]: Drop fifo_setup of rkcanfd_devtype_data.
[PATCH v8 3/4]: Drop CANFD.
[PATCH v8 4/4]: Drop CANFD.

Change in V7:
[PATCH v7 1/4]: Correction format warning.
[PATCH v7 2/4]: No change.
[PATCH v7 3/4]: Correct the writing of some registers and
                correct the annotations.
[PATCH v7 4/4]: Optimize the structure parameters and
                ensure error handling.

Change in V6:
[PATCH v6 1/4]: Fix dma is support only for rk3576.
[PATCH v6 2/4]: Fix the compilation warning.
[PATCH v6 3/4]: Fix the compilation warning.
[PATCH v6 4/4]: Fix the compilation warning.

Change in V5:
[PATCH v5 1/4]: Add rk3576 canfd to rockchip,rk3568v2-canfd.yaml, remove
                rockchip,rk3576-canfd.yaml
[PATCH v5 2/4]: Encapsulate some hardware operation functions into
                rkcanfd_devtype_data to provide differentiated
                implementations for different models
                (such as RK3568v2/v3)..
[PATCH v5 3/4]: Add rk3576 canfd,fix the register naming rule,
                Delete the variables used by rockchip itself.
[PATCH v5 4/4]: Fix .h sorting.


Change in V4:
[PATCH v4 1/3]: Correct the format and add explanations.
[PATCH v4 2/3]: No change.
[PATCH v4 3/3]: No change.

Change in V3:
[PATCH v3 1/3]: Add documentation for the rk3576 CAN-FD.
[PATCH v3 2/3]: Adjust the differentiated code section and
                add dma function.
[PATCH v3 3/3]: Remove dma, no use dma by default.

Change in V2:
[PATCH v2 1/2]: remove rk3576_canfd.c, use the rockchip_canfd driver
[PATCH v2 2/2]: code style.

Elaine Zhang (4):
  dt-bindings: can: rockchip_canfd: add rk3576 CAN controller
  net: can: rockchip: Refactor the rkcanfd_devtype_data structure
  net: can: rockchip: add can for RK3576 Soc
  net: can: rockchip: support dma for rk3576 rx

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  52 +-
 .../net/can/rockchip/rockchip_canfd-core.c    | 581 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 212 +++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  20 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 277 +++++++++
 5 files changed, 1094 insertions(+), 48 deletions(-)

-- 
2.34.1


