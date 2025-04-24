Return-Path: <linux-can+bounces-3479-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB6A9B538
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 19:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DDC1BA47DD
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41C4284B48;
	Thu, 24 Apr 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b="Ie9AyD2J"
X-Original-To: linux-can@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE31A255C
	for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515784; cv=none; b=f6WF+9M/QsdWbZWpL6uCw9LLCQ4RV/vL4qsuXKCxMxg3vYuE6dhQz3k+wTJjLbIYxDCOmcVsnvf5ITN07vZFg00TqUC0ppLzMYpTegGdbcSDKtYxROYMMqSxx1Tak+daiclAxjDCx4NjUNemtiPtXhYo0ZV8LXc+odV2NePJugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515784; c=relaxed/simple;
	bh=7hTef6s0STD4iM8JlOC0mOSINuRuw1LT+2OQIhfwCuo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=tHlvehj6Rcy/2szERdg9QCes2MBHM8D2RxlmPTk1UuicLraIU9PCxYlrhFIBQG8ez1WHzQrg2x3d65ScG49VdveA3byhOMmnYbdAY1Cdvh4Q8DRP6OntpDPOnArBsCbDZmgv7AvHcNIMG+cfFGqdb3G+QqFQCpIjsZQlVDhyI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com; spf=pass smtp.mailfrom=vpprocess.com; dkim=pass (2048-bit key) header.d=vpprocess.com header.i=@vpprocess.com header.b=Ie9AyD2J; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vpprocess.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vpprocess.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vpprocess.com;
	s=key1; t=1745515779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=inzYoj2AgDTp8gsmeKorGP3CQHvO6OcM4FKAZ7mW3i8=;
	b=Ie9AyD2JqUkiYXY/73VMI9qscQRHl6TVNyZRbvGAHFCpNwWPywkBDrVymxGrLo7WeRMQyN
	jHhgVdA9QtuQq+PfP9ZuyIiL4nCG3NCJ5IE7G9/EKBp8DozxQ2DJDNRjArSqLk2pb7mwm+
	rjD0F3l0Fkdfus9RgctEHugk95oZCM/VqOaFlh4ZXsS5VnFPI68GMhbRXP/3zwUi2+oSXK
	u+XmYOCtWelj7v+ES1f+1NR693kq/K+a4B5kO9pOE6tEuwcujj4YD6CDlmAhSg47eWlEik
	NXTBvNvNPSQfC1KDMker/DxL3Kw7wjiF9iYm3RJLy3r8vUk2gU3zqVDIFSl2rQ==
From: Kelsey Maes <kelsey@vpprocess.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: [PATCH] can: mcp251xfd: make TDC controllable from userspace
Message-Id: <07F32FCD-D6AF-47E1-A76D-C136F6E5E2A5@vpprocess.com>
Date: Thu, 24 Apr 2025 10:29:25 -0700
To: linux-can@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

TDC is currently hardcoded enabled so lower CAN FD data bitrates result =
in a bus-off condition. This patch
allows userspace to control TDC as needed. Tested on a Raspberry Pi 4 =
with a MCP2518FD at 40 MHz and
arbitration/data bitrates of 125/500, 250/1000, 500/2000, 1000/4000.=20

Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
---
drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++++----
1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c =
b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517f..1180c489b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -577,9 +577,13 @@ static int mcp251xfd_set_bittiming(const struct =
mcp251xfd_priv *priv)
	/* Transmitter Delay Compensation */
	tdco =3D clamp_t(int, dbt->brp * (dbt->prop_seg + =
dbt->phase_seg1),
		       -64, 63);
-	val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
-			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
+	if (can_tdc_is_enabled(&priv->can))
+		val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
+				 MCP251XFD_REG_TDC_TDCMOD_AUTO);
+	else
+		val =3D FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
+				 MCP251XFD_REG_TDC_TDCMOD_DISABLED);
+	val |=3D FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);

	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
}
@@ -2086,7 +2090,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
-		CAN_CTRLMODE_CC_LEN8_DLC;
+		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
	priv->ndev =3D ndev;
	priv->spi =3D spi;
--=20
2.39.5 (Apple Git-154)

