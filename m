Return-Path: <linux-can+bounces-5510-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83545C75F60
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B07E34B0A0
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA91F8BD6;
	Thu, 20 Nov 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nhwQBv2H";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Lw0y718P"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A85229B38
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664330; cv=pass; b=joCppNeXS14xaD8FoieEDqnxK3oxxcZhoae8gfjUOZJo9wlKEbvKYws0+zGoS96xwyvI6uudPAl9niT5m1Bhi5+BC8/WQXiayqSWDiTG0gwdGVYbOXqPON3ufnDrY1cDCkUv14UhrAvMCfR+x7+ZdTZfxhANwzOlOfqtmecrs7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664330; c=relaxed/simple;
	bh=JiTy1/ifiHYwJicB8vDgGgkP1tSL7kAcnuYBvst8FYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LRfsQkaL5muKauN7eGTSPxNylNzBgH2LcyTV5+AA/kU3vCMIi6aFVt0JkcEWLMrsIqFjrz7aR4UyY7RwNZpo0npTlXOVK4OI3VE32cKFUZsSweIansxiiqi/YNBS1Gv9nL+bu40/0vSnNjjyIomoFTKsfT5nierYR8ejzIlG79E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nhwQBv2H; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Lw0y718P; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KIe2iyPTmDCutR99dDVVZjC8PpXV86byy7GJFusHKRSIkUnLfXF1YMmccj0SmfUSAC
    Ads/CurPZ4LBD1bDKLfwuvH1MYHKBJTvAGnGNENzP2DJo8h19qhQ1DfUQzRZYIutJ+BP
    uYrykGdim1KbPt6XB+JA/Ga3bTtOmapXrcDQfX7qCPCix86vPLNGHCDWyr38m/nuuI0I
    ylkRnNmEhn3nAzvsC7RjcNpDgG6p4vi0OSf0hWA4bqjsjPMNUpNYA8J6T/R+qgFHKN/A
    JUS58txmK5LVWXCck2cYAWvjck4aZ5veQ/4FtFb0KyHQB0FZELvmPp5UDglLcvjI99Gv
    0T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664320;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=43iIZdySuqbMVgOLsDy5fZ+aGqoHML63VrFSz6/Ti1A=;
    b=ZuzvXrem/kEkUCITKr7Zm8sUDz4DRGOTYWFP56jKZRHNtPKh9aXCBvr3erGT/3KuJl
    m47dXYzLVwcVZ/sBaU94K8mAbEwFw3p9D7BY5j5fv+Tjm9+uJa27YwGwgVbsZNRNV4p4
    LGSDCYyEAKoXGCJZm1a+h5TpdrRbpReGUB2FQKSoqtma44GwefheRapIVQxB6ScfypEu
    Sld36+xZGYjy5qM0fBBN+nRZ0BNRePrXhhZ4puKOEm8fkPhLzm/pahOGodvQP3mBFVpk
    GzhFNqsZIcvi/pqsh/ihH7TJAM7hNM9Dm7pE1MhyUDcdajoFA0eiGv0oYj/AM3hLZqZi
    w1YA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664320;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=43iIZdySuqbMVgOLsDy5fZ+aGqoHML63VrFSz6/Ti1A=;
    b=nhwQBv2HS4QT2lQaYyVVhteMvnWpndhJ4NrTHDTGleklrwWanfGIHwi+D4MUFUIBw+
    E8jmrb3P/frCIDqNQeExPHc3ggXw3QOEKoWDxVpMqmsIXnuf90iq+dGWvcsXVxqcj6V8
    kY03DzYMe1Lt/UIrM7BUwNS5ILQE60JNnfb8CgTcUiAz0LPHZQ/XyNW36jt2qbvK1GBu
    aQyQNfkbEeCLkq9r4cCW5q4mlG5mOR3giKu9nP5Q0869SfY/gvMggmR3SrvUbqLdJ7vQ
    qSUB2B/bFoK0Pkt3TcEtf7OhfVB5kQ7dt5Jq36cISrODqgzuhEm9b1Wfht5quxRo4pR5
    3lig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664320;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=43iIZdySuqbMVgOLsDy5fZ+aGqoHML63VrFSz6/Ti1A=;
    b=Lw0y718PssRmGE5OUUGk24QWvOIVnlYLsbYrdXKkZ9C8jB8y3hvpsdQb4j1i9PC84h
    0M+AKF1UDrlFiUiY+7Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjK9DK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 00/17] CAN XL support for review (full series)
Date: Thu, 20 Nov 2025 19:44:44 +0100
Message-ID: <20251120184501.27597-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changes since v2 patch set.
Generally added my S-o-b tag as requested.

Oliver Hartkopp (4):
  can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
  (reworked commit message - no code changes)
  can: raw: instantly reject unsupported CAN frames
  (no change)
  can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
  (new patch)
  can: dev: print bitrate error with two decimal digits
  (new patch)

Vincent Mailhol (13):
  can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
  (no change)
  can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
  (no change)
  can: netlink: add CAN_CTRLMODE_RESTRICTED
  (no change)
  can: netlink: add initial CAN XL support
  (no change)
  can: netlink: add CAN_CTRLMODE_XL_TMS flag
  (no change)
  can: bittiming: add PWM parameters
  (no change)
  can: bittiming: add PWM validation
  (no change)
  can: calc_bittiming: add PWM calculation
  (no change)
  can: netlink: add PWM netlink interface
  (no change)
  can: calc_bittiming: get rid of the incorrect "nominal" word
  (restore the const statement)
  can: calc_bittiming: add can_calc_sample_point_nrz()
  (no change)
  can: calc_bittiming: add can_calc_sample_point_pwm()
  (no change)
  can: add dummy_can driver
  (no change)

 drivers/net/can/Kconfig              |  17 ++
 drivers/net/can/Makefile             |   1 +
 drivers/net/can/dev/bittiming.c      |  63 ++++++
 drivers/net/can/dev/calc_bittiming.c | 119 +++++++---
 drivers/net/can/dev/dev.c            |  42 ++--
 drivers/net/can/dev/netlink.c        | 319 +++++++++++++++++++++++++--
 drivers/net/can/dummy_can.c          | 284 ++++++++++++++++++++++++
 include/linux/can/bittiming.h        |  81 ++++++-
 include/linux/can/dev.h              |  68 ++++--
 include/uapi/linux/can/netlink.h     |  34 +++
 net/can/raw.c                        |  54 ++++-
 11 files changed, 991 insertions(+), 91 deletions(-)
 create mode 100644 drivers/net/can/dummy_can.c

-- 
2.47.3


