Return-Path: <linux-can+bounces-3677-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7412CAC1F64
	for <lists+linux-can@lfdr.de>; Fri, 23 May 2025 11:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C7F1C01863
	for <lists+linux-can@lfdr.de>; Fri, 23 May 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A77224B12;
	Fri, 23 May 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TuTYB+tN"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6B224AEE;
	Fri, 23 May 2025 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991414; cv=none; b=HPZp+yPF5+O4G2wZ17u6zGpeSsrTaCKidJmNHr5b/NmG9NRGteqevYx0S5rn/QdRLvHxpsaYUC0tl15rTpb5e5CFi6S8VmJ7mBJsKu15pkDIu3wA+f6Z1wwlv126k1bpPTLlDKu7p5UWBs2pjaro8EyZmCyQnGS97YpsI08tXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991414; c=relaxed/simple;
	bh=18/hM79gzTEgc0mz2u3OK3o+sDHBlcvn//5vlPWLGCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aPLW4UtNBP0raW+UclOiWg57WmyD4oicY6NTefsQzC8/LRV+1KM95CzQtmD09pryU87Psn7yQF9Kve8LRmCLPjq3ho/y7JV3FudMedXlfMRq1hil0AoZ/IP7ZqZPdHT22tv4jX4R5DEF9zBxFCn5UD5WzZj9j774jE2t6qlPjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TuTYB+tN; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1628045c1;
	Fri, 23 May 2025 15:54:24 +0800 (GMT+08:00)
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
Subject: [PATCH v5 0/4] rockchip: add can for RK3576 Soc
Date: Fri, 23 May 2025 15:54:18 +0800
Message-Id: <20250523075422.4010083-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lNGVZLGEIfS0tPGk0aTE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96fc22d8c403a3kunm893a9d4d11da94
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Azo4TzE#PhU0Eh0MDilC
	Gk5PC1ZVSlVKTE9MQkNNQ01OQ0JDVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOQ0k3Bg++
DKIM-Signature:a=rsa-sha256;
	b=TuTYB+tNs6YN+eiPJLqJ2uWrCNgSxZB0rA2IYnuXg9orTfEXIxGwULJgVfF/0haHB6UFERW9Fg3J5O1Z1C15e6dFduSVBeM5p84PEx0UznIjZhUoUqW/Yxee6vNTWh0gUSTRC2YTV5i2+jm7+bUZevIdESFVEIvWTdEKZtbqDBs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=K5jaFTCngbPDKPi3ZqCN9u0J+a6SzDpijkmm4gsP0Co=;
	h=date:mime-version:subject:message-id:from;

rk3576 can is a new controller,new register layout and Bit position definition:
Support CAN and CANFD protocol.
Support Dma.

There are major differences from the previous rk3568.
All errata on the rk3568 have been fixed and redesigned.

Change in V5:
[PATCH v5 1/4]: Add rk3576 canfd to rockchip,rk3568v2-canfd.yaml, remove
                rockchip,rk3576-canfd.yaml
[PATCH v5 2/4]: Encapsulate some hardware operation functions into
                rkcanfd_devtype_data to provide differentiated implementations
                for different models (such as RK3568v2/v3)..
[PATCH v5 3/4]: Add rk3576 canfd,fix the register naming rule,
                Delete the variables used by rockchip itself.
[PATCH v5 4/4]: Fix .h sorting.


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

Elaine Zhang (4):
  dt-bindings: can: rockchip_canfd: add rk3576 CAN-FD controller
  net: can: rockchip: Refactor the rkcanfd_devtype_data structure
  net: can: rockchip: add can for RK3576 Soc
  net: can: rockchip: support dma for rk3576 rx

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  24 +
 .../net/can/rockchip/rockchip_canfd-core.c    | 596 ++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 197 ++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  |  29 +
 drivers/net/can/rockchip/rockchip_canfd.h     | 289 +++++++++
 5 files changed, 1092 insertions(+), 43 deletions(-)

-- 
2.34.1


