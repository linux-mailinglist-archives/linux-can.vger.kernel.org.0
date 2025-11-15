Return-Path: <linux-can+bounces-5425-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD4C608B6
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E90DC4E22C7
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1562FF644;
	Sat, 15 Nov 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZQe+nlIT";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DjmSzvta"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298772FDC41
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224677; cv=pass; b=BLcs6wMET6XFgWO6THImOJ9XbyuHBVrIllaO1BaXaJ9fWmP03v/++RWhw4R3IHvKpAloMZpDCS6AdylBT8UMxvmRCiX1oRXDVByvMun8osHTbp8xOOK1QynrET6K6IvWOdzMVPb2nV/XnzxA45R5xNdB2hhF8Ul5I9tdakqAK44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224677; c=relaxed/simple;
	bh=cUky70S3LaTGjWSVRkrwjhPbyZwZO0dJ123Dpy7GO7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNv8+5i9+7lg5IMh+XXX/+DCQvzj603a7E/bmbDeGQd0L6FKVPmI3EX0qUurwb39Ujbev8hPI+7eTGtMdul0+VSPBKtruVu/hu5ZvSshZ+e/8D7mREDSpDsjG3CfLuExwwfQTlY5jFCMqLn4jpX0mrbAg2zcyFfYXqz+MmrMl00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZQe+nlIT; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DjmSzvta; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224672; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sTZrjwdZxf8DRkU2K5mfdBpTfYNqT3g4SbjuKLrGb+WhdSfLI5+J23yM+p+kBTz+ex
    R/rMKRPnCJXk6/4sLeusnGPbU9ZbxujSvBc6nT4qffVp/jJTobnqIMJ2h7W8YYpvf6l8
    lkIIi1BGyKu45aptUsL/qz7Nu8+TjQOeAFubnpTzzqGft3RPvif1wC4Mg9hrUcIaupTH
    6/btyQuXS8KNHUiblIlk+nbGZeBi7MhgWN8dMUqs8Tb+m7XeYK/a7Q5MjxBsOA/oDrIg
    ef/Tuf8HxUqYb8tV7K/kOEO+TbpCMDSYgKHAlaCOBS2t9yfou6CPXOEHFQcY1gbkLi/S
    Umjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224672;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dBEgEB6/iIHSgTEyIUliviTdBxP0bqZAUmkzCf1VEVs=;
    b=DUlHvGHUMTDUMop5jleetAIktvv4zpuVsAUbYvkzSiwGsgtdynOgPA4w17SECioWHd
    tA7jZmmyIR/SAN9zU5OBCAIWLqErW/zB2frlB/Jj4LdPAGfNeDWvzq/yPOtS/2S3Yzgs
    H+hcxlNBv+xrNYcA9DIY8NfL2X2YfYmTjkEKLscc3MAplJiWhWZ37nKADFo2cvRHkp92
    81TwqnfUphKTVY0vaLvV5QkGhiB+Pz99hoOu8jbOWDOD0gBM1gzdoVyAXPzCorvzRpcH
    GHxiqp7MVKCWgqS7fRKMHrBwtZTRd26/1qjvganQQfkpumX90p35xCqSeK12r0kemM3X
    kkTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224672;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dBEgEB6/iIHSgTEyIUliviTdBxP0bqZAUmkzCf1VEVs=;
    b=ZQe+nlITE5XdCkXGkEjRR9mSzHUR5SWYPufcbZRHReu7RXjSJ/u8kP3Hyjom4RzcW1
    AC2Cq26vh9qf8VD9yhZOWtiMJ4dUPIJWZ1O0WB0kWURDUKNhD/gwkzexv1+2CsyXY/a7
    QUCXlywCzAWY8v2yNCpwE9X1ZodRgVU1p1qgMqIa+42djsa5z/hZHhPb4Um61p/Ka6or
    KBykrZLn42ABKTNNhLcqdicjoSRLgRl08GQEpSQu38i5YC2En8M/2NWv1YHxrjCnNsbA
    uR/yhogF2Vy40tUlFKZAuc9NIguMTicvPpd7xDA+eNOMPh7pAAnWGelO8XmKYoy3+jrI
    mkvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224672;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dBEgEB6/iIHSgTEyIUliviTdBxP0bqZAUmkzCf1VEVs=;
    b=DjmSzvtaEV4/P+WS91BPhmFe0McVpbK0Yf8VXJoat5sm0qyVaDh3sRAh/yMSYV+NX+
    wO/VEBnfG6dNyl+eP9Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbqeQj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v2 00/15] CAN XL support for review (full series)
Date: Sat, 15 Nov 2025 17:37:25 +0100
Message-ID: <20251115163740.7875-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This series is based on Vincents CAN XL patches 2025-10-13 11:01

https://lore.kernel.org/linux-can/20251017-enchanted-quiet-civet-84dd47-mkl@pengutronix.de/T/#mdecc959e0ef7c16c64f35e9dd3d687954e15c8ac

For a better review here is the complete series of available patches with
some changes, especially the error-signalling handling.

The changes to Vincents original patches are documented below:

Oliver Hartkopp (2):
  can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
  (replaces can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL flag patch)
  can: raw: instantly reject unsupported CAN frames
  (the adapted version using can_dev_in_xl_only_mode() helper)

Vincent Mailhol (13):
  can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
  (no change)
  can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
  (no change)
  can: netlink: add CAN_CTRLMODE_RESTRICTED
  (no change)
  can: netlink: add initial CAN XL support
  (remove the "bad device" warning for CAN_CTRLMODE_RESTRICTED)
  can: netlink: add CAN_CTRLMODE_XL_TMS flag
  (remove the requirement that TMS MUST be set. Use defaults: off)
  can: bittiming: add PWM parameters
  (no change)
  can: bittiming: add PWM validation
  (no change)
  can: calc_bittiming: add PWM calculation
  (no change)
  can: netlink: add PWM netlink interface
  (no change)
  can: calc_bittiming: get rid of the incorrect "nominal" word
  (no change)
  can: calc_bittiming: add can_calc_sample_point_nrz()
  (no change)
  can: calc_bittiming: add can_calc_sample_point_pwm()
  (no change)
  can: add dummy_can driver
  (remove CAN_CTRLMODE_XL_ERR_SIGNAL but print error-signalling state)

 drivers/net/can/Kconfig              |  17 ++
 drivers/net/can/Makefile             |   1 +
 drivers/net/can/dev/bittiming.c      |  63 ++++++
 drivers/net/can/dev/calc_bittiming.c | 104 +++++++--
 drivers/net/can/dev/dev.c            |  18 +-
 drivers/net/can/dev/netlink.c        | 319 +++++++++++++++++++++++++--
 drivers/net/can/dummy_can.c          | 284 ++++++++++++++++++++++++
 include/linux/can/bittiming.h        |  81 ++++++-
 include/linux/can/dev.h              |  68 ++++--
 include/uapi/linux/can/netlink.h     |  34 +++
 net/can/raw.c                        |  54 ++++-
 11 files changed, 970 insertions(+), 73 deletions(-)
 create mode 100644 drivers/net/can/dummy_can.c

-- 
2.47.3


