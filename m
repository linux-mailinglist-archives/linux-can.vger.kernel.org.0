Return-Path: <linux-can+bounces-5607-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12DC7CC0C
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26DB4E1C54
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A8D1D5160;
	Sat, 22 Nov 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XBV/l2lJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tGGvKyaB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1F1519AC
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804898; cv=pass; b=qtnoREqjJP2Y505jf/EzZ+y+Ei6G0AdpJdg/sgVd/xCsQME4dGdHSgLIxjPinZsTKjYVp6yu1w0+fczgOgUPlbwJ9EQRgfYG8rNyyeFHiy3D/zggfWjrbU4MSWBoByi6mLRj/c9ruzZwARew26BkxewWvrn974Sz3GEKldzfUSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804898; c=relaxed/simple;
	bh=eAnPxD3c9KVRMB0heBnPcKNK9gmijDKohTkftxrDZtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUmYVbWOvENtQ6LCPPm1ciCn1JKKoZFKn33DNFoeMe4YIRvcpz5LbQbM5JSj5efRXgf3E7knqasv7FnixkIGa+vAfnKVNIWALM84ScktjpPFWSowSKhj9PJ1FD/Mvsy7lfFJphEFYAdNGSC5W0z1HKtqTPligW/leilpIRc7SHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XBV/l2lJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tGGvKyaB; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804168; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YOt1xMwRp2SKED/vXvYaIKmwQRX0tUKdQ9lsXZw64EFyw1M3OBMDfM7wmypYW+TbPp
    6yE3lULt5R/Bx2pC1uOUKCmqCejasugIy7Z8agaMqLWffT4bwxUpGvhK4MHXmL/rzRep
    o4gbWo1vjZR6+b4rU2L5/wAVllwe3MofPdTxuVMPR2aKdeaoHzQAu8lrIhZchEgjwwU3
    ZtyWrWtlhaqKbn7CC0QO6E6LB5O4SzRJAJH0Xxdkc3gotaHJ8bBfEYMmsOQjNWBdMmoT
    vQJXyZO+lxpEgoCg/zBZbO/zoS5d01sSSKxwG/HELp2gnTkRq9IWvNZZyQzjSds/52hx
    2nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804168;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=18+doArjgZxk0kXcLCtbFyNK19Ms3q/oD1cdnBydgGc=;
    b=RzydUv1T5oMqFvYlTnkoJRUqjs3TddNaAmElGIGwECDgGM7uc8qNfl0/fBii5CCeFv
    N9AiTcFHJ5rCC6aib5J7A+3xhffvL0ykbqz+0Za7iYj11eK93w0VDfTKnwD0AgQlccHm
    tvzDvsuj1y6IDR5MrcBVE8MBYPoJamiS0Fs7Yq9qBbfA9qV8z3xQBaNoc5at0NEEhlcK
    Bf+7koBiRVNVP1rMjGRKcm94a1p3NPVXFy1C9qBRluOnKfRWmWW9XIOdYh4I1mXAxyuO
    t/hcRJEUlF2lKE9xycmA0C8EDyTa8t0N308XJp/6atxdNUBXoTRPZnUSGom8JCINna3A
    dRog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804168;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=18+doArjgZxk0kXcLCtbFyNK19Ms3q/oD1cdnBydgGc=;
    b=XBV/l2lJiklcl+IkI9lJbFofc6LHypJLZz1vdiYUfbTdw+hgAycyUcuPSD5tKf//l6
    FwBUPtUdEizOOmZ3qklukr7LSA4btTUxc2sLs18zFSNq0X2ESwjz7zesRSTUij2eUVNr
    8QgE9OxqE3DRH6yifckfODXO96FpnX1T1oPGep111RqcfoIsF/XjvPITGsxxWc/2Je9t
    lnrDrfSPoGNV4rkWIcKbVBEyMRdnQxJkx2l3z8VTlSof8/owUjH4QO1LzqmDtuDw8VV3
    /D4c5N9yAactG1p7jZMic+ztxyplFKT1f4EqgJTD5s7IOcBzZPf/OqhC2yaw8V70Vf3W
    RF/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804168;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=18+doArjgZxk0kXcLCtbFyNK19Ms3q/oD1cdnBydgGc=;
    b=tGGvKyaBAJRxFtLR1dP48rb+L7yR9jBfYCTBZPRdDcKMrkyXg8S3wk4wCLzSfWAZZO
    jAtcAV6uNynyUIjkvABQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9a8Fdk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:08 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 00/17] CAN XL support for review (full series)
Date: Sat, 22 Nov 2025 10:35:44 +0100
Message-ID: <20251122093602.1660-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changed wording in patch can: dev: print bitrate error with two decimal digits

/* print at least 0.01% [when -> if] the error is smaller */

Oliver Hartkopp (4):
  can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
  can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
  can: raw: instantly reject unsupported CAN frames
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
 drivers/net/can/dummy_can.c          | 285 ++++++++++++++++++++++++
 include/linux/can/bittiming.h        |  81 ++++++-
 include/linux/can/dev.h              |  68 ++++--
 include/uapi/linux/can/netlink.h     |  34 +++
 net/can/raw.c                        |  54 ++++-
 11 files changed, 991 insertions(+), 91 deletions(-)
 create mode 100644 drivers/net/can/dummy_can.c

-- 
2.47.3


