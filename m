Return-Path: <linux-can+bounces-2458-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FFC9F74FA
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 07:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32931618A4
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4F11FAC42;
	Thu, 19 Dec 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gGN/NZG1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284F86352;
	Thu, 19 Dec 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591300; cv=none; b=QLeGpIHhPrvtx4FUREfTZSF83z/Pq5g4QEhefE4blqHCafCd4NtDmMeY4PjVsuTsswCjWiMe7bTwXYMtVPhjgeTk6nWkuCPtw//4jxoUlA96a3ov48DoC/2PRuVj6fJpEwVyIlD7BY7/Z2JyePZxGwdQ2RJgOyLgmYenTGJSFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591300; c=relaxed/simple;
	bh=XpdbOgM3VnwEfVTg0cYEtg/scfSTdvgpNEaEK+PLQPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJYk42YhJkkS6D7aXAsrv0yrfzl6neNOm6E+O8xq/v+Y3n8ukOpaqd/xeCI4jWNsFYPBiTs7nJcHdEMa6tWD+ZJ/bGUBa8sdO6b2btfn3lpuE8hZ6ELJNWZAqINY+5P71OHM08GX17ZUwyyxaw5a3Z1qi+KkBW9c3U0tkXMEznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gGN/NZG1; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 626be198;
	Thu, 19 Dec 2024 09:12:00 +0800 (GMT+08:00)
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
Subject: [PATCH v2 0/2] rockchip: add can for RK3576 Soc
Date: Thu, 19 Dec 2024 09:11:57 +0800
Message-Id: <20241219011159.3357530-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx9JTFZCS0gdSU0eHUoaTRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93dc78bc2903a3kunm626be198
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Fhw6SDIVIhcNFB1RMEkM
	ViMwCjlVSlVKTEhPTkxLTElKT05LVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUNLSzcG
DKIM-Signature:a=rsa-sha256;
	b=gGN/NZG1w4r3Fb4NPDY4FOzxiUj1JzyUyN52IJ13obm4b3yAL1yjWlVw2JtPuZcbb1VSEmwFZSreUcTTTsPiMFQB/rN9ilK0duH3Ou2rw8am3hx5f9yJ55z80av7c7bpEDcJInVP9eOqQcOMw70e6IAIZaD7zitPQoPd6M+qwf4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=v5KQiPBEK7te3XVLhGwOItVgj11ELHSc7Ns4KFJJ4sk=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller:
Support CAN and CANFD protocol.

There are major differences from the previous rk3568. All errata on the
rk3568 have been fixed and redesigned.

Change in V2:
[PATCH v2 1/2]: remove rk3576_canfd.c, use the rockchip_canfd driver
[PATCH v2 2/2]: code style.

Elaine Zhang (2):
  net: can: rockchip: add can for RK3576 Soc
  arm64: dts: rockchip: rk3576: add can dts nodes

 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  26 +
 .../net/can/rockchip/rockchip_canfd-core.c    | 453 +++++++++++++++---
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 111 ++++-
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  29 ++
 drivers/net/can/rockchip/rockchip_canfd.h     | 285 +++++++++++
 5 files changed, 846 insertions(+), 58 deletions(-)

-- 
2.34.1


