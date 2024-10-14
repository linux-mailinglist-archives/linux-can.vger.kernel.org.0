Return-Path: <linux-can+bounces-1672-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9FD99D8D5
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8409B1F22059
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93571D0F61;
	Mon, 14 Oct 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rsEBMNO2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6921D0E3E;
	Mon, 14 Oct 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940496; cv=none; b=WdQB4wNs5in5vSy78NH/OT47/igLow6TKHy9YKtQENXXJ3TXb/pjkgWEbyhNhOlb4FH6djCu41lXiI9FBjO2oyZ/uS7OEK7ezB5JvJywrMgu/H8rQeavnCNHNk5AmfAg1wBpWbpCdRD+ID9HAD8ruJT4VTRQIkm3enihMKk78xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940496; c=relaxed/simple;
	bh=rvIywEjogCiwXVzlP8g7B4K28/cFU0k/kLvToB8437w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJkDJ8xuZCH8P6qCRJS0pmCyh1hVxLPygRXl0LImjdD3xJcTh8Eg2QD+N+QQYZQIxkloU2x8p8E0efPiTQHKmACBcsrv1w6NCZCr2UykFJLIE/gMy6d3tGZQGSE8w+5YILvXFAlakdxXmcxxXvC+njPiPPkZ3vrzLfL3VWCAQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rsEBMNO2; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728940495; x=1760476495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lm1nlbhRFalml+XjwqIVmMPssVpEVAP0w03w1PajwV0=;
  b=rsEBMNO2kFFaMZCX0/4GanWBnD4I7v7M9VK1dwghRZLUW2QgJvXk3EWI
   Ts/Zf7LCaI8PiIWjbaINwzYnvOohv+jBv/8NKvd23hO2qr3UrYjIGIw0x
   mncJuF9ihRHViFruPG36pa5URlVDyy3NogyLSfPtQT3Ifgdvq/MAKWML7
   s=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="138023042"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:14:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:20116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 8bc78cd4-9c40-4b9c-b747-d35989fc65d1; Mon, 14 Oct 2024 21:14:53 +0000 (UTC)
X-Farcaster-Flow-ID: 8bc78cd4-9c40-4b9c-b747-d35989fc65d1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:14:52 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:14:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <alex.aring@gmail.com>, <alibuda@linux.alibaba.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<johan.hedberg@gmail.com>, <kernel-team@cloudflare.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
	<miquel.raynal@bootlin.com>, <mkl@pengutronix.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <socketcan@hartkopp.net>, <stefan@datenfreihafen.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after sock_init_data() in packet_create()
Date: Mon, 14 Oct 2024 14:14:42 -0700
Message-ID: <20241014211442.96478-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
References: <20241014153808.51894-2-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:00 +0100
> After sock_init_data() the allocated sk object is attached to the provided
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

