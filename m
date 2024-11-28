Return-Path: <linux-can+bounces-2253-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78D39DB3CF
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 09:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29732B20BE4
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5E149C7B;
	Thu, 28 Nov 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="b1Bpx7z/"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F71863F;
	Thu, 28 Nov 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782769; cv=none; b=sjXRVYu3m4HdFNfgXYMV6o3F8t9aSuNK7ZbE+ahuWnxpjzqjuMSxiLfy731R2nW7IaI80T4JjZDep876D1CZKNkRCbZ1NzvQGu5vfJK8QI5kDe8oeUYPsZj3hNUeGH1yp2WqqMCuVv4P/evPN1Qr3JWaLZyqB7aiRYZVWpoNW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782769; c=relaxed/simple;
	bh=nPJfzjw2IzYDyvBj2QMAjwMYpWx5zWBGijY92AGYwzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r5x4AFnjoGtL+Ze2PlzNbhsTOYXcYs3Yr4slwZ2W8b7VcJkSEwJ+PbKSGOqTp26WRg+fbQrbp2aEjFpr+rcetVLaYKHHgsKh11CrmBUj0crV8yeh0yMeSTKpEnLv6hMGGUChPEJq0g8ge5Flvs4DKe8RucE3jFBhxH+WTiLF6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=b1Bpx7z/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=S0T/bJtNnZ8RVrU1SOk0n/9fkL9A+JwcK0Q5OqH8Ous=; b=b1
	Bpx7z/fAeh0OwfahlSY744AEscveqmrEDlrtclz21z/n8nOLdm3nYjRKNFVeT5Q2tJtQvKFuTp0VS
	+o5j7sWu8l5Cpx+FP9TxYm3G+4YHlqbDrfCvheceG4yKSyXj0e0E61ZqPKA/NhjM8+/IKuzwvri0h
	kyBWomHbGUdzX+xToNep+ZOJdRhockDcT7oZpKy5sxDyUBvMPIGgOp46gGJEr/M406ntNpmdj7n6p
	WTQ3O4Q6j44IqjIuvwdn6j02j6AF/RXFPEyLuZD3oznx6uBCoaVKiTl5meD4L5jjMKjQMJCQkeHSt
	AcT3oXbRrbxN1wsxBxtgnYb+NYtCzhQA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGZx6-000H5u-Q0; Thu, 28 Nov 2024 09:32:44 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGZx5-000Pzk-32;
	Thu, 28 Nov 2024 09:32:44 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 28 Nov 2024 09:32:31 +0100
Subject: [PATCH] can: tcan4x5x: get rid of false clock errors
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-mcancclk-v1-1-a93aac64dbae@geanix.com>
X-B4-Tracking: v=1; b=H4sIAJ4qSGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNz3dzkxLzk5JxsXXMTwxQjw8S05CQjSyWg8oKi1LTMCrBR0bG1tQD
 oXgYYWgAAAA==
X-Change-ID: 20241127-mcancclk-741d21afcb29
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27470/Wed Nov 27 10:59:44 2024)

tcan4x5x devices only requires one clock cclk, so call devm_clk_get()
directly. This is done to avoid m_can_class_get_clocks() that checks for
both hclk and cclk.

tcan4x5x spi0.0: no clock found

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 7213d9894c82d079bf92f1ec62d4eebb500cdfa4..7463c40b909873b9c5bcc753f9db7009e9d66008 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -410,7 +410,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		priv->power = NULL;
 	}
 
-	m_can_class_get_clocks(mcan_class);
+	mcan_class->cclk = devm_clk_get(mcan_class->dev, "cclk");
 	if (IS_ERR(mcan_class->cclk)) {
 		dev_err(&spi->dev, "no CAN clock source defined\n");
 		freq = TCAN4X5X_EXT_CLK_DEF;

---
base-commit: e0b741bc53c94f9ae25d4140202557a0aa51b5a0
change-id: 20241127-mcancclk-741d21afcb29

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


