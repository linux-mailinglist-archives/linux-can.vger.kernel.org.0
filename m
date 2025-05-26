Return-Path: <linux-can+bounces-3685-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893A2AC3A4A
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 09:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F44172A4A
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743A1ADC7E;
	Mon, 26 May 2025 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Uwr3msEK"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C54C9F;
	Mon, 26 May 2025 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242897; cv=none; b=DwMVJyIsTNqJhcrZElnU2Jp8RJ5IsfLTjrofKVhK+Cjs8UbRDLPYL7wTI2coB7pPVULdcdLiSW43BuJuTo+ok+YTPNuRh5v48C4eswyBd65iEJR6I+5sWQO94Gk23C3eKzCKvPCOWtKgtZGj/27WWc3KTlDeg2NdgemCVm47AY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242897; c=relaxed/simple;
	bh=vUTy9fgiQM1M9OXGFsdExlNkdH738vTuRpj/XUexG2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bZ2Ew9SxUDiEju3wh03RssJWvsmIZ6MPHTyaxVD9mCTzld/cpYatVOfnyvVEtXogc+MTP0IcGtKij+UfnQyzHGVkOzfSvR4+CdGtbJ/qnow6ooZJ2ni7e4+RgKklw9G56yCHvBpMMfmeo8cnI3K4vuCAGO25cEdtM+K+95pfPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Uwr3msEK; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1660c015a;
	Mon, 26 May 2025 14:26:00 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	cl@rock-chips.com,
	kever.yang@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v6 0/4] rockchip: add can for RK3576 Soc
Date: Mon, 26 May 2025 14:25:55 +0800
Message-Id: <20250526062559.2061311-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlLSlYZHk1NTEtIGkhOHk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a970b44ff8b03a3kunm902b49ed4a332d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6Hgw6MDE0Og40ViENKiMR
	HigwFCtVSlVKTE9DSU9LTE1JSU5KVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlDSU43Bg++
DKIM-Signature:a=rsa-sha256;
	b=Uwr3msEKJ8hrOXUNf0OS1lAQsZf/fqwM9a+9WoTz6+M6zGwCZalkAUXq1Xl2Uw+qvsxpHtSyiAJYL1svVhTiFf4k8u2aIruSbsZs+/KmS9U5GWP13z/3zzIL3oXar2sr3rw5eITYQ3C2h0m9R2IALsXO3ezqYTe+P3ZSaUfF8wE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PLZ0qwoosUUE5XwgBZkpDsN7ujf59+z2ZeMIful5s1Q=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller,new register layout and Bit position
definition:
Support CAN and CANFD protocol.
Support Dma.

There are major differences from the previous rk3568.
All errata on the rk3568 have been fixed and redesigned.

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
  dt-bindings: can: rockchip_canfd: add rk3576 CAN-FD controller
  net: can: rockchip: Refactor the rkcanfd_devtype_data structure
  net: can: rockchip: add can for RK3576 Soc
  net: can: rockchip: support dma for rk3576 rx

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  41 ++
 .../net/can/rockchip/rockchip_canfd-core.c    | 596 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 198 ++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  27 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 289 +++++++++
 5 files changed, 1108 insertions(+), 43 deletions(-)

-- 
2.34.1


