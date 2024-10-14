Return-Path: <linux-can+bounces-1675-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D04D99D90F
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315012829DA
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4661D0F4A;
	Mon, 14 Oct 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b8NUoVQm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784613BC02;
	Mon, 14 Oct 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941565; cv=none; b=MB8j9/wiwzkoV1vJ6R01YbnSe85lvcUajVyQ4/Stk8PEwD3XO42YZZMJV7zE/5a4lrLGLphxB2rrRj2zfuatimRUkrYBm2F99+nigbuOPVWLNUDIF9HmIt5IB1KV1CcxiJ+Cns2gAInCIkIcB6lyJODI40jfnfzp1OEgQiCWH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941565; c=relaxed/simple;
	bh=m8lw1DtTZ1MZP+UllJpZatRafL9M9FoviwWn3MUnSTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8YmVv3r3oEFyoWty4t86Zi60GA59eZ+ITcDJTLTbBPGpZIXNoyM1396P/glxTGIep5hcvhxAQa5ZKRRUfXJaUOX5mtUzAiG8vqb24UHa4mqDUmrS3ImImBjUtJOPUyAXh6GU4rM/oEk1NoTMb6t1clSImOo4ofnD2rzhlYT7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b8NUoVQm; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728941565; x=1760477565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anau8ITUOh9ZDx4HIGjWJQXF+uE125DcReJ9DX4QlEs=;
  b=b8NUoVQmJgmLT8d7L5T1zIFlRgXfPMAwubPjAvuYyw17pej0h39ZEYVC
   AeRWPR/XUuzFUJwYqxvE2NeScdHH9HbVEllZt7mxiSvVJApvlx6E9TRAD
   BD3Q9jeNL5zO/alW5DOh8Jy3WagI0LB/vQlUsOuFhaawduBb2tpkf+IMy
   0=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="666126587"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:32:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:61887]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 089fae70-b9df-4653-8713-50e6dc2106ba; Mon, 14 Oct 2024 21:32:38 +0000 (UTC)
X-Farcaster-Flow-ID: 089fae70-b9df-4653-8713-50e6dc2106ba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:32:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:32:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <alex.aring@gmail.com>, <alibuda@linux.alibaba.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<johan.hedberg@gmail.com>, <kernel-team@cloudflare.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <luiz.dentz@gmail.com>,
	<mailhol.vincent@wanadoo.fr>, <marcel@holtmann.org>,
	<miquel.raynal@bootlin.com>, <mkl@pengutronix.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <socketcan@hartkopp.net>, <stefan@datenfreihafen.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 4/9] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Mon, 14 Oct 2024 14:32:28 -0700
Message-ID: <20241014213228.98842-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-5-ignat@cloudflare.com>
References: <20241014153808.51894-5-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:03 +0100
> On error can_create() frees the allocated sk object, but sock_init_data()
> has already attached it to the provided sock object. This will leave a
> dangling sk pointer in the sock object and may cause use-after-free later.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

