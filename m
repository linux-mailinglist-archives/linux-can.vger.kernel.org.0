Return-Path: <linux-can+bounces-5640-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3083C84FE1
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5786534F36F
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF92DEA67;
	Tue, 25 Nov 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KOiN4Tpx";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NZStqBrY"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4327702D
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074362; cv=pass; b=fPS9H+6WkuPKT76gZgTVprPBc7CaClImxTK8ChSGl+9VquAMXnz5rfq4jih0HkbmLx/57FB5SYqApc7+Gu1VhybA3Z4trT7rTX3EzyEw4tBdwGO0eTd1RHb3epXc5gdDIqCQoOAwLd0xmsbt2cgQ73GH97d4ndBg7XTEWSQ0NEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074362; c=relaxed/simple;
	bh=e48XtaEoZeYmlMSs+sdnduPUig1zY5nUhqMmAarqkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8VdQseLWwJ5pRI2zx8DujN6nrh1fo9Ibm42jAU7xLXUJC6PlF+N/UrNNPMqo3WGNIambfXwy7N1MMNj/olRWVhdlQi/RJu8UERjaL0mcsGdgmBxKkMt/yxtlQD9VQ2TE1exUdV4DBj0gi4UdObQWlfwaY3htbX+1vj2YpImlpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KOiN4Tpx; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NZStqBrY; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074352; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QetrY0mUpirCA97Zpu1WlHozhbM+0S/rkTc/579Zi34ZPEGY9o4oy3usFcQStTlVWS
    dpHfLKT2AyT1X3ej49WsNoZmyi2mtfuqYLLTpPVQ4o7+kVEyr80HwuFd/w9v4X4jlWja
    Auv1lp40nMy1VT7xiXyrQUpJbzdahnvcR9W69EhYEow7dozu48xgtDnc9ZVVXmVGLIdN
    JJNCLGB//4f8QobwfRPbN55ihcRAQsqBFUoXpTIW14om4WgEiWWqJ2KLjPHjh6nWqu27
    C6OCMmHNL/doyUXmiYPLJMkiWxQ/bjwDR5ElOCK86o0YcuZhu2SbnsiLTQ0y6RqkrDFD
    cMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074352;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TSCjoK6cIatK5vL6eeP33lcGiRYLDSmTZ63dlh8Nyhw=;
    b=Fg3swc09X9AWE7XVghbD4lGNcACTf2PfL1e2PhlMHi7uTqRJc63ZKd5L5oukv1uS0h
    MX3ypgj/YK5/lePUps9HW3GcX2CY3SYIFQhzfRFwUsDG+mTR4CWiTTKXxTIkg5awXm78
    i25uAhIxq5CWf9bKLcNQFoxTQ5M/aVgq4Z73GsQEC9D1HTfw6eh7z8PgvCiMVBzf55TP
    8owLcijPrGN5bYfcWDHLehHK3mnhvAQ3/67gQjfuP2j7Qe5hBIV2Khjbc3Fk21qioumt
    Ekhjkl2AUkisCfLWGFUFvLNWEgdVrXM2Dk5a49z2e+UMwx9tNohcsw9iLLWUkGAvvbnj
    mUfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074352;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TSCjoK6cIatK5vL6eeP33lcGiRYLDSmTZ63dlh8Nyhw=;
    b=KOiN4TpxPU76eUtBtTjHKsgDPKOTGda3sF5a8/KOTuWY9DT+YkfdtNayA0UwRjnX9V
    EafYXI3Wb8GIZueaLH26JG2oAymb4qCBnpYCn2YuHQlEhrbaNUsr84Vzvbe9xTD7AuTZ
    ng0oQnpBiWrCM2WE3gytXXROETUnZWn95N/qiPvFu9+vG5alAaEfC8Dtej1Ea2Cwkj20
    koUrP/5SUMtzgKQpmpTkokB6Qmyg+fNR+9FQ4RnQ4W26X5AonUmw6R+jtrOmTQIt2JJa
    s81Bney2iBEm9s0UgMsiqakXjCpU2q1Cz63umQZeIqxMhVfjDtFqoFaAXaiN/RyofBc0
    57lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074352;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=TSCjoK6cIatK5vL6eeP33lcGiRYLDSmTZ63dlh8Nyhw=;
    b=NZStqBrYpNPDmX1bmNTktqzj4tG2HsU5VmHOuM8HgPzAc4xcENL66D7ef7xITK8sON
    AaxvEfEbXIuV7zJTRvBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdCT8K
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:12 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 00/17] can: netlink: add CAN XL support
Date: Tue, 25 Nov 2025 13:38:42 +0100
Message-ID: <20251125123859.3924-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
CAN XL also reuses the entirety of CAN FD features, and, on top of
that, adds new features which are specific to CAN XL.

A so-called 'mixed-mode' is intended to have (XL-tolerant) CAN FD nodes
and CAN XL nodes on one CAN segment, where the FD-controllers can talk
CC/FD and the XL-controllers can talk CC/FD/XL. This mixed-mode
utilizes the known error-signalling (ES) for sending CC/FD/XL frames.
For CAN FD and CAN XL the tranceiver delay compensation (TDC) is
supported to use common CAN and CAN-SIG transceivers.

The CANXL-only mode disables the error-signalling in the CAN XL
controller. This mode does not allow CC/FD frames to be sent but
additionally offers a CAN XL transceiver mode switching (TMS) to send
CAN XL frames with up to 20Mbit/s data rate. The TMS utilizes a PWM
configuration which is added to the netlink interface.

Configured with CAN_CTRLMODE_FD and CAN_CTRLMODE_XL this leads to:

FD=0 XL=0 CC-only mode         (ES=1)
FD=1 XL=0 FD/CC mixed-mode     (ES=1)
FD=1 XL=1 XL/FD/CC mixed-mode  (ES=1)
FD=0 XL=1 XL-only mode         (ES=0, TMS optional)

Patch #1 print defined ctrlmode strings capitalized to increase the
readability and to be in line with the 'ip' tool (iproute2).

Patch #2 is a small clean-up which makes can_calc_bittiming() use
NL_SET_ERR_MSG() instead of netdev_err().

Patch #3 adds a check in can_dev_dropped_skb() to drop CAN FD frames
when CAN FD is turned off.

Patch #4 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
control mode is not specific to CAN XL. The nuance is that because
this restricted mode was only added in ISO 11898-1:2024, it is made
mandatory for CAN XL devices but optional for other protocols. This is
why this patch is added as a preparation before introducing the core
CAN XL logic.

Patch #5 adds all the CAN XL features which are inherited from CAN FD:
the nominal bittiming, the data bittiming and the TDC.

Patch #6 add a new CAN_CTRLMODE_XL_TMS control mode which is specific
to CAN XL to enable the transceiver mode switching (TMS) in XL-only mode.

Patch #7 adds a check in can_dev_dropped_skb() to drop CAN CC/FD frames
when the CAN XL controller is in CAN XL-only mode. The introduced
can_dev_in_xl_only_mode() function also determines the error-signalling
configuration for the CAN XL controllers.

Patch #8 to #11 add the PWM logic for the CAN XL TMS mode.

Patch #12 to #14 add different default sample-points for standard CAN and
CAN SIG transceivers (with TDC) and CAN XL transceivers using PWM in the
CAN XL TMS mode.

Patch #15 add a dummy_can driver for netlink testing and debugging.

Patch #16 check CAN frame type (CC/FD/XL) when writing those frames to the
CAN_RAW socket and reject them if it's not supported by the CAN interface.

Patch #17 increase the resolution when printing the bitrate error and
round-up the value to 0.01% in the case the resolution would still provide
values which would lead to 0.00%.

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


