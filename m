Return-Path: <linux-can+bounces-5675-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF017C8937E
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E033B1725
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AD1E5207;
	Wed, 26 Nov 2025 10:17:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBF1A23B9
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152221; cv=none; b=hrDQkTOOLs525NiHo6xEw0YWsd/q3W6hgpygCGKFAuD/DY+j5h0ST54/NgGHJVq4pmLJh/RRcR/wMISHAD0hC0VM46x+Inf/FCEFe3P+6iFRW9mS6Ipjx4ItmFGxhg/BLRM7BbX2OK5BYFast+LInxrcSKmPlh9QGLT+5/rPds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152221; c=relaxed/simple;
	bh=fv1PdRvNzNtst2OM4hFfofHiKGzoV1M4cTBqXW9IlPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A52AqH7D3bTlBCBy3Z6aQb6maxPW9SOZzhnUt8/CzBacSlqfnrcN0cqua3OyURSZEEmYLV93DksYqY3Cm33Hf06AYn0SdQPCfmBFeiVBlFDBKC6l9R3L8UeAAJRKethrAMEne2Ei9523cICNWwP58cqHMWhk0YHmTal+JVGmOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-0000Qf-7Z; Wed, 26 Nov 2025 11:16:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZu-002aSZ-2h;
	Wed, 26 Nov 2025 11:16:50 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 912FE4A88D1;
	Wed, 26 Nov 2025 10:16:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v8 00/17] can: netlink: add CAN XL support
Date: Wed, 26 Nov 2025 11:16:01 +0100
Message-Id: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHTJmkC/02MwQoCIRRFf2V4696Qmua06j+ihdgzZUpFJYRh/
 j1p1fJwzz0bVCqBKlymDQp9Qg0pDtCHCaw38UkYHoOBH7lkjCu0JvYXKnF2RmhtF6ZguLmQC/3
 XucFQMFJvcB+LK+mNzRcy/x3JuNBymcXCT8iwJrtSG7+rN6WtKec5UoN9/wI5ybv+oAAAAA==
X-Change-ID: 20251126-canxl-637fa388c916
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5078; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=fv1PdRvNzNtst2OM4hFfofHiKGzoV1M4cTBqXW9IlPs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtNxp1kuvCFFpFjhLuHf4NGeN+R/ce4KvkN3F
 YjwDdwD4A6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTcQAKCRAMdGXf+ZCR
 nBZiB/9jGx1qMQRIGwYM4pxb4Zq23//7hxIuaNX7Yo+mpc6McyXpi6IGGcPF8YL+D5GyGL68ymD
 XmryoRUVyB73MPAiCIDptPN/NfgG+lqcatLisb324+7NN2tiSGdmbgYx+Sqh99JQbtDiFlMGQnc
 1oZlZy/NVf2d3g53wC9jaVo9oogIned0h/L/rqiGQ08TJpf8Wy3uw/bR1XG37jLwiCu/8P8zLwT
 RKgcYUEYKZMyqAXCH8LQ5BRwMrUtrYXo2sxdIY3uyO/EXQErrm/YpUiCe8/K6hNxALU0kVsD2qn
 wWTPINToSG2fRB79AcPZ4ElGCIdLWq98dqFbmqRF4ViH/rnC
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Similarly to how CAN FD reuses the bittiming logic of Classical CAN, CAN XL
also reuses the entirety of CAN FD features, and, on top of that, adds new
features which are specific to CAN XL.

A so-called 'mixed-mode' is intended to have (XL-tolerant) CAN FD nodes and
CAN XL nodes on one CAN segment, where the FD-controllers can talk CC/FD
and the XL-controllers can talk CC/FD/XL. This mixed-mode utilizes the
known error-signalling (ES) for sending CC/FD/XL frames. For CAN FD and CAN
XL the tranceiver delay compensation (TDC) is supported to use common CAN
and CAN-SIG transceivers.

The CANXL-only mode disables the error-signalling in the CAN XL controller.
This mode does not allow CC/FD frames to be sent but additionally offers a
CAN XL transceiver mode switching (TMS) to send CAN XL frames with up to
20Mbit/s data rate. The TMS utilizes a PWM configuration which is added to
the netlink interface.

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
CAN_CTRL_MODE_XL_* that are introduced in the later patches, this control
mode is not specific to CAN XL. The nuance is that because this restricted
mode was only added in ISO 11898-1:2024, it is made mandatory for CAN XL
devices but optional for other protocols. This is why this patch is added
as a preparation before introducing the core CAN XL logic.

Patch #5 adds all the CAN XL features which are inherited from CAN FD: the
nominal bittiming, the data bittiming and the TDC.

Patch #6 add a new CAN_CTRLMODE_XL_TMS control mode which is specific to
CAN XL to enable the transceiver mode switching (TMS) in XL-only mode.

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

---
Changes in v8:
- Patch #12: replace "nominal" by "reference" instead of removing "nominal"

---
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
      can: calc_bittiming: replace misleading "nominal" by "reference"
      can: calc_bittiming: add can_calc_sample_point_nrz()
      can: calc_bittiming: add can_calc_sample_point_pwm()
      can: add dummy_can driver

 drivers/net/can/Kconfig              |  17 ++
 drivers/net/can/Makefile             |   1 +
 drivers/net/can/dev/bittiming.c      |  63 +++++++
 drivers/net/can/dev/calc_bittiming.c | 114 ++++++++++---
 drivers/net/can/dev/dev.c            |  42 +++--
 drivers/net/can/dev/netlink.c        | 319 ++++++++++++++++++++++++++++++++---
 drivers/net/can/dummy_can.c          | 285 +++++++++++++++++++++++++++++++
 include/linux/can/bittiming.h        |  81 ++++++++-
 include/linux/can/dev.h              |  68 ++++++--
 include/uapi/linux/can/netlink.h     |  34 ++++
 net/can/raw.c                        |  54 +++++-
 11 files changed, 990 insertions(+), 88 deletions(-)
---
base-commit: ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
change-id: 20251126-canxl-637fa388c916

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


