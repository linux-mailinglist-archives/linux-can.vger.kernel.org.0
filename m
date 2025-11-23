Return-Path: <linux-can+bounces-5622-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EADC7E55F
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23CEE344E04
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C55243964;
	Sun, 23 Nov 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="B27jAzCf"
X-Original-To: linux-can@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DE2D3EF1
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763921919; cv=none; b=F3+fULdnnupX9s3wpgXOzQ8cHZ51kOKFbMjKU31vO01B0/KsX+RWDZSyQqTkGKHDh8c2Ha0+3LT4ujgq5V6yirxnaUNzCnpI41dFHVHQqxyD4N3D2KTyRkQV8sQP5mvKENoZ/w6mDEf21gTS+DDqB546NbvhQQyaxieL2ujOT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763921919; c=relaxed/simple;
	bh=v/UELuNjfEDmHPJ4WHNYsI/OELUBo8EWUiHKUyT5Kns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ffhqSo2JgvCq7dlt817hcB4qxCdO9yxP/42aejsFv0GynRTrPfWzlqnyAsQF/z2mDV6cgRzETdaE2zqL8G04H/PtjrkvxSBlPRwuqiyRHgnn49eqx9sdwSVwD6rvWKGYiQSdSwKlkdWsLuKGVX74wlnn8V0Z3FsglxLaABRIJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=B27jAzCf; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 3CFC1240101
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 19:18:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1763921908; bh=GUd23RQXvEQ82/zx8RZThb6Z/fUd3CX0EX7d/cGRuzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=B27jAzCfHg8Qt9pdELMx+HpNdTGuI4Yeyur7MDeNSdFxXQywJP1X5NE1XQ8hux+U0
	 FK1DGyotd/c1L2phnu1pUnLWvqTMrCO2/OiEw6TJcTA4s4bwRy4jxLaLcNCoLGCulZ
	 Cegee4Z4QhciCwCTZfsiuH72LKcGzNcvmQ+FKgT6UovO6RuwrHVYIBzVpdQe7PLlr1
	 Snak7SfqwrgBdzrJy3LQhowHkSIU0t8llXBUTDnn0un6anHXOZuK7zlax0vJcy7vQj
	 1J+bnf/8dTRpILcyU0FCeI1dyKZsE8bUsCKizzSC9uxbVEYYy+1CIOHs07vximUDv9
	 pn1QDvd1UP/Kg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dDxz73YdCz6txb;
	Sun, 23 Nov 2025 19:18:27 +0100 (CET)
From: =?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Subject: [RFC PATCH 0/1] can: sja1000: try to enable NAPI
Date: Sun, 23 Nov 2025 18:18:27 +0000
Message-ID: <20251123181820.19233-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I think there could be some benefit in avoiding the unbounded while loop
for RX in the ISR. On a system with slow IO between controller and host,
we can end up staying inside of the ISR for much too long if a more
capable bus participant causes a lot of traffic.

Given that this module is reused by other drivers as well, I checked how
they handle the interrupt and since they are reusing
`sja1000_interrupt()` with multiple `dev_id` parameters, I am avoiding
interfering with those. Not sure if there could be even more nuances
that need to covered.

Still need to test this to make sure it's useful and works on the
hardware I have available.

Thomas Mühlbacher (1):
  can: sja1000: implement NAPI for RX IRQ handling

 drivers/net/can/sja1000/sja1000.c | 42 ++++++++++++++++++++++++++++++-
 drivers/net/can/sja1000/sja1000.h |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.51.2


