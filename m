Return-Path: <linux-can+bounces-5476-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF9C66E53
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 02:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7D24E131A
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 01:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63B30FC00;
	Tue, 18 Nov 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="d95Esqwj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0E1862A;
	Tue, 18 Nov 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430897; cv=none; b=IWw0GhNqmYhsofgl4Xui5DAH1Jkk8E4wLYgQt0bNHexMqSiil3cIEZNbZJedD5STmW2imBcUoq2NpMOFrdB2uMDYrypzPZkxdCRH5YE14NRtBp0o7CpWF1KN/HeapXDmukfOHmVl3RRLGPRSHp4a2htP7Aqpnsrs1wyI2kG1URQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430897; c=relaxed/simple;
	bh=F0odjzwhaVYFKIHL4BiePeQi3Ip1aPlv+NZ9ZDu/Pz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2uyGFmt6oYmCliX+Mfu4ExKlVvRIT3Ih2po1uEcX/iYYc3UCCfJ+ruYXOyvHbXNMAwoMxKqT+Dxl8eNEjy9Lva81BszGIsK2rfAFkpvdZ4KAVosdX1cmNwS8IO96dGj2Sw6rIrPweSrIEqmxmMw8Mz1K9584oCvrjt4Su8Fk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=d95Esqwj; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29e9c3744;
	Tue, 18 Nov 2025 09:39:30 +0800 (GMT+08:00)
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
Subject: [PATCH v10 0/3] rockchip: add can for RK3576 Soc
Date: Tue, 18 Nov 2025 09:39:26 +0800
Message-Id: <20251118013929.2697132-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a949df36403a3kunm07a8ba9e476a7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1JSVZNQhkeSR8eHk8fTRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d95EsqwjGLzRTOUj/OyJtYu/8aGbohZlmGLCXmgNZ3IEbb1dOlTtwFe9hiOiJenrr4Glet22Dmj1AV4fN4JS9nqNNmgt/kFem93V4ZV3r7rKz4FTuhgU/pSHihamP6xELW5wjkJI0a6u4f3+Iaadru5wVTHRIr/6aOGx8feVMCQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VQDe0qd4BJs1skNAK8EBE03leCXmi2MVma2kr6Rm7Lw=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new CAN controller:
new register layout and Bit position definition:
There are major differences from the previous rk3568.
All errata on the rk3568 have been fixed and redesigned.

RK3576 TRM update: CANFD is replaced with RKCAN.

Change in V10:
[PATCH v10 1/3]: Add ACK for commit message.
[PATCH v10 2/3]: No change.
[PATCH v10 3/3]: Update commit message, fix get_berr_counter.
		 Add log for errata, drop RKCANFD_QUIRK_CANFD_BROKEN.

Change in V9(Drop dma):
[PATCH v9 1/3]: Drop dma, fix "allOf:"
[PATCH v9 2/3]: No change.
[PATCH v9 3/3]: Drop dma for commit message.

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

Elaine Zhang (3):
  dt-bindings: can: rockchip_canfd: add rk3576 CAN controller
  net: can: rockchip: Refactor the rkcanfd_devtype_data structure
  net: can: rockchip: add can for RK3576 Soc

 .../net/can/rockchip,rk3568v2-canfd.yaml      |   4 +-
 .../net/can/rockchip/rockchip_canfd-core.c    | 505 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 103 ++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  20 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 268 ++++++++++
 5 files changed, 857 insertions(+), 43 deletions(-)

-- 
2.34.1


