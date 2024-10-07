Return-Path: <linux-can+bounces-1607-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F7993997
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 23:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B11C22F88
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8818C352;
	Mon,  7 Oct 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kYPRDpNf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33A74C08;
	Mon,  7 Oct 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338274; cv=none; b=MdJm1acYzyHVjUGJylc0rMHMVBM7pk2KiwViFG3GHJdX3SbM9aMN7o6TbhtdWV++cUtGkPp4ekFyC353q/i30Gb6ek/3nxnZoSDWZHvF703xKd+kfGPBWbFOcFAwYfcuKw69L6UOvHFmO7jgWPlf3RWC0mYLNoRRBvEJVLCNP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338274; c=relaxed/simple;
	bh=yO83BjF/EhIdb6aTjF7BPHgAouFqqASxCf24Qe5GbGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmecxqxFW5emA63r9YBBqFwBIhzKQsKdRqv1CI2Py8IigVjhiznPoHRNI9MNSEuxarClyod2IZKmdkKQ1SIyvDhDeYfNRmbWIza9lyTKKLscBNDdoYHV5rU8ugD00hNX2dvf9ipbMlr/GfTwnnmLht0b5N/hMRlnUjg5jPS0HTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kYPRDpNf; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728338273; x=1759874273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k/7b6auwZDyRxDUdfhnW2bApj7G/ZohOfXk40geD9XI=;
  b=kYPRDpNf2rPaqk6p6xKvRnkw7juaodWEMO94V8lxy9Wy+US0uHFDbmww
   dHRRO38siQyA1mwSOJcRroMwyCge3VFd5d/BJMnVffTtiypVyOxD3lWwO
   22gNQqnMHmDwhRVmrwqqt7a+t2U+zrRLC/PMnogWoBw4a19Xva0CzsfwO
   o=;
X-IronPort-AV: E=Sophos;i="6.11,185,1725321600"; 
   d="scan'208";a="31343091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:57:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:62342]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id d363b916-a870-437d-8fb0-40975da680ee; Mon, 7 Oct 2024 21:57:47 +0000 (UTC)
X-Farcaster-Flow-ID: d363b916-a870-437d-8fb0-40975da680ee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 21:57:46 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 21:57:42 +0000
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
Subject: Re: [PATCH v2 0/8] do not leave dangling sk pointers in pf->create functions
Date: Mon, 7 Oct 2024 14:57:34 -0700
Message-ID: <20241007215734.72373-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> [PATCH v2 0/8] do not leave dangling sk pointers in pf->create functions

For the future patches, please specify the target tree, net or net-next.


From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon,  7 Oct 2024 22:34:54 +0100
> Some protocol family create() implementations have an error path after
> allocating the sk object and calling sock_init_data(). sock_init_data()
> attaches the allocated sk object to the sock object, provided by the
> caller.
> 
> If the create() implementation errors out after calling sock_init_data(),
> it releases the allocated sk object, but the caller ends up having a
> dangling sk pointer in its sock object on return. Subsequent manipulations
> on this sock object may try to access the sk pointer, because it is not
> NULL thus creating a use-after-free scenario.
> 
> While the first patch in the series should be enough to handle this
> scenario Eric Dumazet suggested that it would be a good idea to refactor
> the code for the af_packet implementation to avoid the error path, which
> leaves a dangling pointer, because it may be better for some tools like
> kmemleak. I went a bit further and tried to actually fix all the
> implementations, which could potentially leave a dangling sk pointer.

I feel patch 2-8 are net-next materials as the first patch is enough
to fix the issue.

Also, once all protocols have moved sock_init_data() after the last
failure point, we can change the patch 1's part to

	err = pf->create(net, sock, protocol, kern);
	if (err) {
		DEBUG_NET_WARN_ON_ONCE(sock->sk);
		goto out_module_put;
	}

for the future protocols.

