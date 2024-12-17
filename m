Return-Path: <linux-can+bounces-2419-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F919F40E7
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 03:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CB216828E
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2024 02:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DF85260;
	Tue, 17 Dec 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aL4pvOGS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m3291.qiye.163.com (mail-m3291.qiye.163.com [220.197.32.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7C18035;
	Tue, 17 Dec 2024 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403168; cv=none; b=GkzOBdPAWkTNrzNoQ8BEMgBHaiiadLRryU4Npyh+2HWXZ5moqz3IC3swTy+PpAH3rJSt+MEbphrZ8gn7o8lrnB1aFRDZ5cSiPVmMI3mkBgkSUBTCHueLCy49C9lYuBz+J4J+piZXl/rO2SzBZAju1ybD0PDHTZ7IVs1G8lyi3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403168; c=relaxed/simple;
	bh=7Z1rzrMFadOizHkcZUqu6m7cBBkquQnHLYwXh7Si1II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDAniuhNCH4D7ihfxKU+Gpcux0DCmv6JVDXWzu/ZDRuU0+Pw1NVxzrif8KFBRSBN4nIPbUpbPj6K/yWnlOme9O4xpanHGiZydorr+3w1XEf3clQ2/o11Dfu8oefCSRkcgpBSHVBjyWAJLeUF7oR38128H9PL0TEkzZXFArq40KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aL4pvOGS; arc=none smtp.client-ip=220.197.32.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5ec156ac;
	Tue, 17 Dec 2024 10:39:19 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: zhangqing@rock-chips.com,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	heiko@sntech.de,
	cl@rock-chips.com,
	kever.yang@rock-chips.com
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] rockchip: add can for RK3576 Soc
Date: Tue, 17 Dec 2024 10:39:06 +0800
Message-Id: <20241217023908.1292999-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4dS1YfHx4ZQkNPTxkYGh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93d27bf65d03a3kunm5ec156ac
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06USo4TjITMh8pMxQwUToz
	NhQKCTFVSlVKTEhPT0tISk1LQkpNVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU1OQjcG
DKIM-Signature:a=rsa-sha256;
	b=aL4pvOGSxiFjl4B6jeyKZcqI556GawLS581DTEvWp/TuqRuq7g3oGKkq13u6ZV3odE06UcuDcJmakIZ81F++iQfuJB+wCj474AB0pLkhvapfg3JiQMhB9uquFNK4M9aa524bIas/qVbT33cm5sk7I1tHX3vwJSzSEwpIMqvOiUk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=m5s9TN6ZWc54FoiYxfoL/NSqqUE+6gh+7n7jZr6kRGE=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller:
Support CAN and CANFD protocol.
Support DMA

There are major differences from the previous rk3568. All errata on the
rk3568 have been fixed and redesigned.

Elaine Zhang (2):
  net: can: rockchip: add can for RK3576 Soc
  arm64: dts: rockchip: rk3576: add can dts nodes

 arch/arm64/boot/dts/rockchip/rk3576.dtsi |   26 +
 drivers/net/can/rockchip/Kconfig         |   10 +
 drivers/net/can/rockchip/Makefile        |    1 +
 drivers/net/can/rockchip/rk3576_canfd.c  | 1349 ++++++++++++++++++++++
 4 files changed, 1386 insertions(+)
 create mode 100644 drivers/net/can/rockchip/rk3576_canfd.c

-- 
2.34.1


