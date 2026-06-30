Return-Path: <linux-can+bounces-7930-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vxvAIa/zQ2o3mAoAu9opvQ
	(envelope-from <linux-can+bounces-7930-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:49:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E256E69E7
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=jcGTMlov;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7930-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7930-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6768D314D080
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6583DA5AB;
	Tue, 30 Jun 2026 16:44:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE53D79E8;
	Tue, 30 Jun 2026 16:44:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837850; cv=none; b=mn1jWenwQW5suDWTDRmC8WpdLv6cDMCQk1XXay2cJizNhRWfL0/YlOBZbqxzk/nRqtwrvEo5wDgcvzVDPRHnsCZqOajl+vyjfM7uwvRKyJpi3+wYLz2GQk0Q7AqRomt4Aic3u/0R6EZv4n5MXkRty2iir6DwN0ZYk/05lkyb5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837850; c=relaxed/simple;
	bh=2RS22bCvU29SJTPJBZRqkhGt6eJpyXkgbTgJ00CVcWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBZMJhrIu8j/+mHlBpGSEbDhJLjCwnvlsOgebkCaDWfIkqhcO+5dN3JehmCHLIZKZLg43wmdx7QSIOrxMaqfPzu3d6LmisbU9TO0piqrcv50DeeQ2bD+O/GWfrtIWsNdWC7PIfZKfSGKawXSsQvcCv5uRuYsEfNdJStC1Fu8/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jcGTMlov; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=YxgRnbMG5q6RvDxWCmqV39hig+L95ZAtZ0OCJoUEZCY=; b=jcGTMlovmEnW5T6RR38oDr3o8E
	49onk0OPt7MV/hZ+wUlLFyHB3OMHc021B9MoEGePIowoNdMV0SIBA7aoZi+YXoUQCS6Mexp1BTgdc
	JI1bDAqCmMMhGjhn5G5HTV6A8Rd23TkMRmbxRgE9fYqy/QmZ43RDdCYkVJJFSlVVBL4z+6mJ8TNGc
	yk9T8hGiTcV7HJ1T1iY90TcvfWc1G1gOhWsRp6czZ99Y6n7rtl5AwtfDZQ/EJYTNWI+g37xVoRtqf
	vWlJkaXXvD+7r1yZ3G/v3LJcXUmwf2D8F7JS2+8BrKnHZTGjyEnXfYlFgbF4Ojus+MW1v/LAcSXWG
	jBY+R5vg==;
From: Heiko Stuebner <heiko@sntech.de>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: kernel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	shawn.lin@rock-chips.com,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	zhangqing@rock-chips.com
Subject: [PATCH 0/6] Enable CAN support on RK3588
Date: Tue, 30 Jun 2026 18:43:30 +0200
Message-ID: <20260630164336.3444550-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7930-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:shawn.lin@rock-chips.com,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:quentin.schulz@cherry.de,m:zhangqing@rock-chips.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sntech.de:dkim,sntech.de:mid,sntech.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1E256E69E7

The RK3588 uses basically the same CAN controller as the RK3588, except
the documentation stopped claiming for it to support CAN-FD.

So add a compatible to the binding, the basic driver support and the
errata I could test for so far + enable CAN on the Tiger-Haikou board.

I'm not sure if more errata apply, so I've added Elaine Zhang in Cc
to maybe add more information.


Heiko Stuebner (6):
  dt-bindings: can: rockchip_canfd: add compatible for the RK3588
    variant
  can: rockchip-canfd: add support for the RK3588 variant
  can: rockchip-canfd: enable erratum 6 on RK3588
  can: rockchip-canfd: enable erratum 5 on RK3588
  arm64: dts: rockchip: Add RK3588 CAN controller nodes
  arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou

 .../net/can/rockchip,rk3568v2-canfd.yaml      |  1 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 39 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts |  6 +++
 .../net/can/rockchip/rockchip_canfd-core.c    | 12 ++++++
 drivers/net/can/rockchip/rockchip_canfd.h     |  1 +
 5 files changed, 59 insertions(+)

-- 
2.47.3


