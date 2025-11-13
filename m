Return-Path: <linux-can+bounces-5383-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95786C561EE
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 08:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 442214E2548
	for <lists+linux-can@lfdr.de>; Thu, 13 Nov 2025 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118D32ED28;
	Thu, 13 Nov 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Dip9QkvO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B12A1BA;
	Thu, 13 Nov 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020474; cv=none; b=ZDr7KPRY7p4FMIskMNulGG55HADe/fTpsdKy3OyQYsbK5bpVVRAm5zOQTyTKlZIPr51OGFYocdPd0S1I88V+EyB/8GABE/B2/SUmm+bj6hTGKbkAEGuKm4+4yqkCTaY0pcakj0oPm2bZLEVLzQxboMHFGsp6vM68kKLip+rqF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020474; c=relaxed/simple;
	bh=T+DUVXZ40Z9uf1iCfEw3pHkfUASgzo+0eAW+fLEXfkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CQxgwG5BOWRV5dR+6IQhlAjswn7J8KQjc2R2b8pqOBzqHoDGqw1GeM2sSU5vJxEjfVNvcSTgGQc/yAfPeb9BrWWCOyZ9BQDg4pgkoxSKl9GSMHqEB/tvR+rY2VDOiVTens/uBvpucbwcXNy7Hn/R4IUW7l1uCVom/KFXEpEc27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Dip9QkvO; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29728bffe;
	Thu, 13 Nov 2025 15:54:21 +0800 (GMT+08:00)
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
Subject: [PATCH v9 0/3] rockchip: add can for RK3576 Soc
Date: Thu, 13 Nov 2025 15:54:16 +0800
Message-Id: <20251113075419.482940-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7c35556403a3kunm5789752bf0378
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkdTVZNTUNKSRgdGUIZGR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Dip9QkvOElxkBwC77at5DxAWoc5iunjif9lVGcp/SzZqPFvKLW+6gPWNf2Ln1lHbgp32FFPnTvfZP5GsoV4vMPBbUDPhynwFxriggwKZxasqmtifUibF1eEovkvZxP8PE8f5Ah/2ydtXB1FNmXqsLTpKQFVxlEv7vjI6iq9gT4M=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=mLn1qTC0+J6drb6NhowLv8jMHz5cIv2dJzxpd8B5HBk=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller,new register layout and Bit position
definition:
Support CAN protocol.

There are major differences from the previous rk3568.
All errata on the rk3568 have been fixed and redesigned.

RK3576 CANFD requires authorization and permission. The software
code is not open by default and needs to be authorized separately.

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
 .../net/can/rockchip/rockchip_canfd-core.c    | 519 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 103 ++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  20 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 268 +++++++++
 5 files changed, 871 insertions(+), 43 deletions(-)

-- 
2.34.1


