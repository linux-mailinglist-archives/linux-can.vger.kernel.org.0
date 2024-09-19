Return-Path: <linux-can+bounces-1516-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B097CD3C
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 19:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F905285BEF
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B29198A33;
	Thu, 19 Sep 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="SyIr1Ff+"
X-Original-To: linux-can@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47948191F74
	for <linux-can@vger.kernel.org>; Thu, 19 Sep 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767771; cv=none; b=Axkzhbr7nV9uUJEU1VMl16P+3oqf5YCTh6GSoYklKZAEjk7ZlOXX3l04VRfoa+cTy7h4xMmRz9axA2rdpU22QRjS3lkmSHsT2U9TXxKIFN+w83NPY9aCtWmgTxNqkp7DOhk4yRnIwdTjCgUbX1qlZ826umoeuo3XmbpquL47LYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767771; c=relaxed/simple;
	bh=PiKWogjtYIm4EEz35P/Ca+40yy4H59xWGZ2KUFKGAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JS1Ra+4HbTrRWkTuds+Q9oKFC+RRlDJyhpN2AcOy0jU6+XlvkWk9AImpkF2TTlOWaweP2rlTZieZUdIdvt0apxW26HQB45qBrHL7vAiFaX/j/ML1r/57NLNzWTMUiuWecXUFVFrzj9vEk6g04djv1AVjPquXwjnTNGozyUJVzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=SyIr1Ff+; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0AC80240027
	for <linux-can@vger.kernel.org>; Thu, 19 Sep 2024 19:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1726767766; bh=PiKWogjtYIm4EEz35P/Ca+40yy4H59xWGZ2KUFKGAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=SyIr1Ff+twAX/84tnbdCCVi7smfiSeQN7dfnfdhnxwqhqo1JBizwLytEtRhLx1R1c
	 LfCUjkeLjxRP/eQpMYGgLuCxXdfpEb4eVZ2l9VdZN3x9Ixw5rOFPXoUt1AhbTeZGXR
	 zYwUNo0NdoyNHwo1usq/EcxUYGwSL1w54GaOFvEoIgMZ0P7kdH2hInCsEK3e3ePeMx
	 00fBfhNv3g+9gf/2GfeKOjZzeXASo/qQs+scGVcAlH8XoZYenH86uB7zXWYGKhIoz9
	 pECgIZ4uExqU1kfx/lGUyGBZX8BIfZUkHj+/ukx5/koXJ1LWJpklR3ZlQj8KNQiQL1
	 tNLhtb/C2te6A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4X8jXN6cNVz9rxB;
	Thu, 19 Sep 2024 19:42:44 +0200 (CEST)
From: =?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Subject: [PATCH 0/1] Allow building {cc770,sja1000}_isa on x86_64 again
Date: Thu, 19 Sep 2024 17:35:21 +0000
Message-ID: <20240919174151.15473-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I noticed that with kernel v6.10 the cc770_isa and sja1000_isa modules
vanished from my x86_64 distro kernel system. There are though still
some industrial users that will want to keep using these in the future.
Most of these users probably stick to LTS kernel releases, so it would
be neat to have these available again for v6.12.

This is my first kernel contribution, I hope all is in order.

Thomas Mühlbacher (1):
  can: {cc770,sja1000}_isa: allow building on x86_64

 drivers/net/can/cc770/Kconfig   | 2 +-
 drivers/net/can/sja1000/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
2.46.0

