Return-Path: <linux-can+bounces-2027-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679AA9C8547
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133A71F222A2
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E851F709E;
	Thu, 14 Nov 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Ee9N5MDM"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F71E8822;
	Thu, 14 Nov 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574376; cv=none; b=MtNqlH18SwHYgK4EpTUWnx8n51qRWhtahj8cmpK5BUDPE+hXipUg8MImPfTtnxCFhlHhXvX5MegjokTYaZjx7FqdwSQSrvqa9wL6JTRvRstOWaKsgkROuoxkeWT6FpJlFpk54Iktv5RJFKjEf8m9CbZ/N8hEC4cMatAaQXTtbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574376; c=relaxed/simple;
	bh=mV6wCDQQ98rR/ujdsfhSfcUAcivczFca5OV8rGM7sSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iImph95/WxJKiY/BUP2wQhIHpIJ5ey/eSx5ZYUU0UcPrJ3mhGHSQ3xcXdQaMN7cOxMPMuxO/q3TXvvNBmGMLOEF07FMV0Bxcd5q96gnzQ//wQRI7JjVQc4jxxgFRuc6kVG9HEW78PCP/vYRKAVkTf+OtyP7fbdswtywiJ14opnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Ee9N5MDM; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=o42UFSPZ8M6NDF4IfNFLvd4R2qtAoiiJCVYA2hpMZhA=; b=Ee
	9N5MDMiJjA2OJ7yI4vMvDWpiCcDBRHY0pc2aQyUsZ6Ql/I3CmTR1oE/yftk4utQYzXuD0a8qbsxaM
	gxmFXtSv5kjnImoVgS4gJvG8Ub9CXcC+8DC3lZu7uRTamcPhzMHR67oAEjNnreOK3AOPm8Itdp9bW
	u6Ew1WafMxF/jptC+feL7qfgGGpJj3cGa+x8DqqOK58x++YSOTftu6lNGqzeY8JDIznpVFillkeXz
	vp5Wv1gO5lAwh35RbtUmp/W9UHs5xlW2VPLZKk6MyNkr+WgfRxWNOBYOz6CXe1OZtVU3Nx68hoUZy
	+0Ugph65G2vwwrQ1hNUrw+VwwIzM+V4Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVan-000CeT-8c; Thu, 14 Nov 2024 09:52:45 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVam-000CcT-1g;
	Thu, 14 Nov 2024 09:52:44 +0100
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH can-next v4 0/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Date: Thu, 14 Nov 2024 09:52:20 +0100
Message-Id: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEW6NWcC/2WQ207DMAyGX6XKNUGJc1jbK94DcZGDs0Wo7ZaWU
 jTt3TEtE6vInWV/X+z/ykYsGUfWVldWcM5jHnoq9FPFwsn1R+Q5Us1AgJZCCT4F1/PP93KZebD
 gG2GFMNExAs4FU15W2Sv7GetxmdgbdU55nIbytf4yy7X/K5SPwllywWtQ0UcJCbV7OaLr8/Ich
 m71zPDH0tuxQGxzsMrIxhsw8I9VjyzsWEVssFaDSt6BjTv2tp1W8PJB8Uz3++7ptNWmFIaHoZ+
 xTJtaeyPJqDEk29LiZPFuRBrqujwR5cE1TtSpToJi1OjAByujV+qgNUgvUqO1s7TA7Rt7INyNp
 wEAAA==
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

This series adds support for setting the nWKRQ voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v4:
- Fixed commit msg, as pr. Marc's comments
- Added Reviewed-By tag to 2/2
- Link to v3: https://lore.kernel.org/r/20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com

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


