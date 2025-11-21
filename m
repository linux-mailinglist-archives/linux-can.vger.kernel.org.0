Return-Path: <linux-can+bounces-5529-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A357FC77EF7
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95BB54E8901
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD9A2F60CB;
	Fri, 21 Nov 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LSw+cnEK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Z1EgdN8p"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3CD277818
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714076; cv=pass; b=SN/048OA97p3E4Ki/5psOnO0+9IoZWxKVt2y9jfUqlejUYnPhDQi0XPn/P8kG4RHDERx3/HtwmUnzyRixfST2j9t3MXORd6VQOWeJrUdMX/iSTbFhtx2+F7Yl95cTIOAx3QhjP999hHqQyFaqb0kO1uvxI+12O7jto4ecTLW/Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714076; c=relaxed/simple;
	bh=/cb/pXCXbls6g0rxdF02+r63BQi1Wo7AxY0g03IYT3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=liip52S+woPc3p0OS1cCGZFaDfPfIR8E7nSszWElLrHeyOO+lhzUSlbWscKugwc/kBfPWSnbacKL1EBeML9mPFvB7AwGqs47k+KCgjL4H7jTEEcborqoTJ2udk4qUrZsb+Gi07LESc8yg94OTv0rBQq0xnOPe760q5bjrYLNI7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LSw+cnEK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Z1EgdN8p; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714066; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iBdgQ6Gz1D0YCLbFZO+f0kjtU4XGMQcKWfFMbBDqa6OocIXFv+jJHCn9sCEMBqcc4H
    kzF48eyCgW99q3FKB4GsqbmY6PdFsssJpGKoqlZ8QrQ3zH8WYhqfMxdivitQzqk0vOc5
    VNmhVnqb8HTpHczbIc5NsjtjwuyRVV0EtYeQDZXpPUq3nI1ZwAzyO+suaK7R/gZxkETS
    8EqkXFBaYwZMYk+7N66ixchSM3dEdQQHJG8SHkvpE/sxUmkdQFELKm1609gGkzgFPb4e
    Hk2rmAiqZ6A5iVJ53GBbbzuSHAK3U6KCdtzqJfFiYgYykXTEX6OuOh+Ki9HogRAz4sbd
    8VJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714066;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8H0BxfgbYnmTVgX9h7J/l7vGCUATKc1fyKbyrsjydRc=;
    b=f7GfhBMPHU2waAed3aQURd9PnBEmeorQE0nyDJozuqgfXH91Uc8zcVX2jk/que9oEg
    ct/xnIpb4nrMmr9YKuoTs8Zs2SJgrXVxzWbLhCtFbygEtqP0aAye78NegmGEW2FzZK54
    pK7FIZQmG/EsqqvG27rxH6A9yp7GdVkUW32elohKFNRY0ZSiC1lpl0s47AcfgL38NkeI
    cz0APpguYaMmnWxpoDxcn+fBEi/t4Q9wc2Kdp7ChmL6RTZDNDBgG6gxz2hfTHkt3Hj6M
    tiyWu5/MevpGjOGelwlAgkqlLD1QEBGcTrEcVYCRUSMy2jNK35K1FSax0fby5gIsgUuc
    sffg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714066;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8H0BxfgbYnmTVgX9h7J/l7vGCUATKc1fyKbyrsjydRc=;
    b=LSw+cnEKCExE94DKhYuI2Z+a2jXl40/RMuw+5uWnegJCrqFgdQj5CspepqzQTpyYL3
    yWpLMzlVivBwpdnZXrS/jhpB4SMLh92wGQD+9loJj/GVKBlUHqfr3figfDlDoefp4pBp
    uKK1ca+peu+N8kqPlZSJA7roYdn35d1bXJoZ/Cz1cvby5FE8kNMd1LCFDMeK2geJdb02
    5/TR9kol9EoJfdM5VrL2fH6Jg8aNy7dYZncskuUbrnv189Pcycke32XwWzrP2ZKxfcw0
    ZmUwnBZ/2bxA18IsriC8syZBkCiXQglSKi+78KqMd/q1PhTbpnY9BSshsTG3Qbs3NVOz
    8rmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714066;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=8H0BxfgbYnmTVgX9h7J/l7vGCUATKc1fyKbyrsjydRc=;
    b=Z1EgdN8pjWmCDHhhoCc7WdL+CedKMwkyFaKWUQa4WVIWzCLKgnkM8W+86A8/GO368f
    yIVsKspOGwRemUoHvcCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YQAfm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 00/17] CAN XL support for review (full series)
Date: Fri, 21 Nov 2025 09:33:57 +0100
Message-ID: <20251121083414.3642-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Same patch set as v3 but I removed an empty line in v3 patch
"can: calc_bittiming: add can_calc_sample_point_pwm()"

        if (bt->sample_point)
                sample_point = bt->sample_point;
+
+       else if (btc == priv->xl.data_bittiming_const &&
+                (priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+               sample_point = can_calc_sample_point_pwm(bt);
        else
                sample_point = can_calc_sample_point_nrz(bt);


Oliver Hartkopp (4):
  can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
  can: raw: instantly reject unsupported CAN frames
  can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
  can: dev: print bitrate error with two decimal digits

Vincent Mailhol (13):
  can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
  can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
  can: netlink: add CAN_CTRLMODE_RESTRICTED
  can: netlink: add initial CAN XL support
  can: netlink: add CAN_CTRLMODE_XL_TMS flag
  can: bittiming: add PWM parameters
  can: bittiming: add PWM validation
  can: calc_bittiming: add PWM calculation
  can: netlink: add PWM netlink interface
  can: calc_bittiming: get rid of the incorrect "nominal" word
  can: calc_bittiming: add can_calc_sample_point_nrz()
  can: calc_bittiming: add can_calc_sample_point_pwm()
  can: add dummy_can driver

 drivers/net/can/Kconfig              |  17 ++
 drivers/net/can/Makefile             |   1 +
 drivers/net/can/dev/bittiming.c      |  63 ++++++
 drivers/net/can/dev/calc_bittiming.c | 118 +++++++---
 drivers/net/can/dev/dev.c            |  42 ++--
 drivers/net/can/dev/netlink.c        | 319 +++++++++++++++++++++++++--
 drivers/net/can/dummy_can.c          | 284 ++++++++++++++++++++++++
 include/linux/can/bittiming.h        |  81 ++++++-
 include/linux/can/dev.h              |  68 ++++--
 include/uapi/linux/can/netlink.h     |  34 +++
 net/can/raw.c                        |  54 ++++-
 11 files changed, 990 insertions(+), 91 deletions(-)
 create mode 100644 drivers/net/can/dummy_can.c

-- 
2.47.3


