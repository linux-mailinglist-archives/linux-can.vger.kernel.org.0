Return-Path: <linux-can+bounces-5586-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747D2C7B8FA
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B493A54F6
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253472FFF81;
	Fri, 21 Nov 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WD+SEtf0";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tLTdn+pw"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88308156F45
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753911; cv=pass; b=FbgUyA0GFQ44BLBKewisogIOb/utoq+QPDsn0bKzPOGNWDgoSbqBXGGrh4Fp3GPmLrarZgIXAakN7ZvyYfdPVADl8HLgokmfMNedt3JDCUSlqo/7UD0QUMp4Q0n1D1BXFPyTDrP6kKE14wwU0Qk+9mZn4gsQNGzCRr6dCQpEpRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753911; c=relaxed/simple;
	bh=6mDZVwzEnFJ59N4nY2yC4/tp9eJSSzGFmr8GiPScwII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQVuOkwXrxUGuIHTnWEZvHqGbHuSnBdsJZtsj1bgyaL0zdiifmGmoxLgOncLdnLgRrchz3IFNSbExICDloI2GLpnoaK5iPVI4DNufdfJafBuMe2dsROzdDqa5gnkCHawnDr7fieuMH7rckmjTz0EowNnUh9fnaMhjDHGuTfIli0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WD+SEtf0; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tLTdn+pw; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753726; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YKfl+7XDvmtk2stHNXAwiFtaenNNCALs4I9vZi8MtWvQl0c67HJD8yOLgFZqWxoCip
    3x+VDBxN+lNZITHZY9Vp28kty4QPgzllnacPSBN0qL4ESdfMXREdq/bdVwx514KWNf4i
    5iGWi5fMhOwBD8chlNR0N4hzPzHwglMTpZQE51xLJCxql60rVGo92pYA71vsTUoWugA3
    wXinUzcnavaZ41LPgGxgdilPpdD+aL+S3hP7uuvnVEx5cdBGc/xZtqW1037d2xEEnBlG
    bzljnnDuXe7PF9DKdfIOZR91tRQa/XvZc9+E6utBp7f5ElyHAIvB8yolRd2B2eMFQWe4
    rhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753726;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q+mamv5w9FD8TZ90JE8yhuXNRbxExewklWl42wj0/O8=;
    b=Oy0zsv20Ri6cTOIEM8GJpUk3YgW/BvulixmQZ94uv1BW4jpEV4uC0ieQZkmVJj+1uR
    t4JdzQFNjkb0pgVPpb5u2aHF/Q6xsxGgm/rq/wG0nlD39tXWSOgWN+KcZ+F+PIZN8Dr9
    NZRH78zf0AFa4vxHrilPcySPgDbxW9NW/35BpqIHzlG5OXSQINKPS+xhSbzJUA5muSvs
    3kPxp2LdU5lv3JLYoMBzg0IwvgJfjJyg9xupSz51GEqhssMnzDLJIB/4sfLF3m/9PWB+
    Go6+DURK2bbUG1qfeNWRty/jfQtJJ0AMAG2BZRPM6NiqdKrqrZtO6ZvEA+Uob4QE2Ihv
    bh3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753726;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q+mamv5w9FD8TZ90JE8yhuXNRbxExewklWl42wj0/O8=;
    b=WD+SEtf0HRz18nR4yAYL2hfb4fBkT1fV/H+4r8kXsc7b4kHm2EF6bQDwj0OkNA/Nut
    Vw9dD6yO9pgZZcw+AYFU9kdFslnGlZlgukqRWKYIauULDfoHlRTdaR697mb382SPmv/Z
    mwmXwP/SkKF4qmkn18RY5V9W5hv76L8xeFYnu9x6Cw4HIZW0l50HRuE9ZNe1SlYedBrA
    9xqJ3qRsjPKh3tv8LJf1lybAVm2QGnz2ovrj//wbjtNcADkXZkb3bjRF9vop/qo+n5Pu
    njHNC1yyq9lHD9UGoUjlQSpXYVGlBZ0HqidlqZxzBzKu6qui0KAwPNE2xW+dz3/edesu
    QKQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753726;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q+mamv5w9FD8TZ90JE8yhuXNRbxExewklWl42wj0/O8=;
    b=tLTdn+pwaWFp9piVt8N2p01ZrY/He95xCPEXu0PiUy6frH3XqIEngX65cNkn8Q1zVa
    2xayENg3ZLtzulB5B3DQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZQEn1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 00/17] CAN XL support for review (full series)
Date: Fri, 21 Nov 2025 20:34:56 +0100
Message-ID: <20251121193513.2097-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Updates according to Marc's feedback from v4 patch set.

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


