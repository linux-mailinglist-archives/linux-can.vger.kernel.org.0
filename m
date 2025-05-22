Return-Path: <linux-can+bounces-3630-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F44AC0671
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D1B4A4AC1
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132B25C82A;
	Thu, 22 May 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZHgASNrq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DD25A2CA;
	Thu, 22 May 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900909; cv=none; b=CVMBFYLD4oV+VYBFKwGD6SisXcLybyD8CAkezOxXsMEoMED2NcG0nQhKRBzSXfdge3JKYtIr9kXA1oP6y+J9aggPX5vFLfztUS5JHB0dD6UXYkLTcE48BCqUmaNlUo7ZiqnIyHFJStdTgn3UuP3+NOIqNdjkbGjDlbToIDxJqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900909; c=relaxed/simple;
	bh=T061gL6o7OkK/X1Mo1vcCclwUdfWutRgh766GnDxY84=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mXH7ldoQj/HfBaCqPiaAYOPM9zbfr/Bi0C5waX3SbZ9gAUIdjZAwav0tSkTr3uRomZPfR1F5xwcJfmREC7MdynyKNfmSjAebpg8aW0ySftuzu+E233l4GmSkKjFEN1iGQxcG40k0qZsNli2Blwm0DrE7PukHP7COms/oNe8AjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZHgASNrq; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1605e660e;
	Thu, 22 May 2025 15:46:17 +0800 (GMT+08:00)
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
Subject: [PATCH v4 0/3] rockchip: add can for RK3576 Soc
Date: Thu, 22 May 2025 15:46:13 +0800
Message-Id: <20250522074616.3115348-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUseGlYaGBhKHUMYHx1KH0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96f6f50f7903a3kunm9938470210de792
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBg6Izo6ETE0LhIcSTgpDiov
	GDRPCSlVSlVKTE9MQ0JCQkxCSk9NVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKSks3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ZHgASNrqMdf+4b6cLuXsZ1XZEP5++2a9VJU5ozLQi+Y5vCkl5jmy/SzODsHuLCwVANNEto4TcXitwR/kMnZaLfcRXXrL06j2FbOeiZUL4FPlmQXDP0+M4Jwv3HPitH+wsKnczxWwDnUGUScTkRzpiC/fqmZbx5KWpuVH3R5BlE0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=sIsz51ve9WD6EIYt9+H904kIrnIh/0ETD/TqyTo6/IU=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller:
Support CAN and CANFD protocol.
Support Dma.

There are major differences from the previous rk3568. All errata on the
rk3568 have been fixed and redesigned.

Change in V4:
[PATCH v4 1/3]: Correct the format and add explanations.
[PATCH v4 2/3]: No change.
[PATCH v4 3/3]: No change.

Change in V3:
[PATCH v3 1/3]: Add documentation for the rk3576 CAN-FD.
[PATCH v3 2/3]: Adjust the differentiated code section and add dma
function.
[PATCH v3 3/3]: Remove dma, no use dma by default.

Change in V2:
[PATCH v2 1/2]: remove rk3576_canfd.c, use the rockchip_canfd driver
[PATCH v2 2/2]: code style.

Elaine Zhang (3):
  dt-bindings: can: rockchip_canfd: add rk3576 CAN-FD controller
  net: can: rockchip: add can for RK3576 Soc
  arm64: dts: rockchip: rk3576: add can dts nodes

 .../net/can/rockchip,rk3576-canfd.yaml        |  86 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  22 +
 .../net/can/rockchip/rockchip_canfd-core.c    | 637 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 193 ++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  29 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 312 +++++++++
 6 files changed, 1234 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml

-- 
2.34.1


