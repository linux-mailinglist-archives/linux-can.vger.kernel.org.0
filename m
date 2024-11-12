Return-Path: <linux-can+bounces-1992-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A074B9C5AA3
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 15:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662B928A337
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D42003B9;
	Tue, 12 Nov 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uPy/zGqA"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0945920012F;
	Tue, 12 Nov 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422415; cv=none; b=qjZu/pltNEBDuHq/rpGl082XcIF8foRmAhF+zjBlFjmWYoTsleDoFA2GYDjrunvTa6Kfb4lGGkA8UWWT4/DC5IFlavMdIUBUZZrtkFG5L4WX+Xrh18HKnBeA5vY+mHD1cFW3+Q7zQs4IH/clSpHalJVnBpzInXXq/H7sqfqsUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422415; c=relaxed/simple;
	bh=tLiyOYdn4NNHt5BE+18n/llcdobkAXi4c2H9DIp4KNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gfpxPnmA2QsQA9iqTtxZNdONY1drKAMDcYAhfkyMz9TaOwj88fNslj5kjAb0ibSz5uqCfHF+EP2DsuhQtb2PBH3M0mKvryLwsrbEaq3wBHzH0Famm16dfoOStJ0wNLI23mgrxDxmTt/MLRwRKIZg59MJcEuTEiGAGmDXsGi0CVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uPy/zGqA; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=5z0qkzpzTaqSRLBhyPcrkLXrKVsaoXL9ogzup9TZNgc=; b=uP
	y/zGqA0JxsIP8vPe0DX+A2dovawAxa4z4elKpGrGTiE10jtMtc8/iBrSj8PvGMG6be0nD+0Wc9xfP
	M+YSHq7JSPna2qWaXChLZ6pkP+hnKadK5DxNeBlhdVAZlVJFpdZ+FrUS2GgZXAxteN4R55LuLhTsQ
	NrGko00lHOf6oXjzC8ks/s/gLhY0CQlD/tQggZ7uuq0sdkquUFBe02947Fcv6h0Wkemf1cjndrAvF
	lhNrawXNwnxqed/xru5ebSSOV/p13sWMjZc8zKOefBBoiUT3dwP+3vXsgl8yvxE2Ti1V+yEHy99jf
	MupIhBJWxQFRErZz7D7FqWTAtN7VLvBQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAs3p-000Mzs-5H; Tue, 12 Nov 2024 15:40:05 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAs3o-000GXH-19;
	Tue, 12 Nov 2024 15:40:04 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH can-next v3 0/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Date: Tue, 12 Nov 2024 15:39:38 +0100
Message-Id: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpoM2cC/1WQ3W7DIAxGXyXiekxgfprkau8x7QKIadGUpCWMZ
 ar67vOSVVu5s+xz/JkrWzAnXFjfXFnGmpY0T1Sop4aFk5uOyNNANQMBWgoleAlu4p/v+VJ5sOA
 7YYUwg2MEnDPGtG6yV/YzNuFa2Bt1Tmkpc/7atlS59X+F8r+wSi54C2rwg4SI2r0c0U1pfQ7zu
 Hkq/LH0HlggtjtYZWTnDRh4YG97vIyXDzqx3DPeL+ybXSkMD/NUMZddrb2RVoPGEG1Py8ni3YI
 0NI6pEOXBdU60sY2CvkKjAx+sHLxSB61BehE7rZ2lALdvOR3hiGsBAAA=
X-Change-ID: 20241030-tcan-wkrqv-c62b906005da
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27456/Tue Nov 12 10:49:43 2024)

This series adds support for setting the nWKRQ voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v3:
- Switched the order of patches, yaml patch first and then code change.
- Switched to a boolean ti,nwkrq-voltage-vio.
- Switched internal variable to a bool.
- Link to v2: https://lore.kernel.org/r/20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com

Changes in v2:
- Converted tcan4x5x.txt to DT schema. In
  https://lore.kernel.org/linux-can/20241105-convert-tcan-v2-1-4b320f3fcf99@geanix.com/
- Reworked ti,nwkrq-voltage-sel, to DH schema style.
- Link to v1: https://lore.kernel.org/r/20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com

---
Sean Nyekjaer (2):
      dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-vio option
      can: tcan4x5x: add option for selecting nWKRQ voltage

 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml     |  8 ++++++++
 drivers/net/can/m_can/tcan4x5x-core.c                | 20 ++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h                     |  2 ++
 3 files changed, 30 insertions(+)
---
base-commit: 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6
change-id: 20241030-tcan-wkrqv-c62b906005da
prerequisite-change-id: 20241105-convert-tcan-4b516424ecf6:v2
prerequisite-patch-id: a652b1a16dadd5ff525d0b58fec56f605a976aa3

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


