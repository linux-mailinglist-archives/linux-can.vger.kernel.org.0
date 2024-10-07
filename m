Return-Path: <linux-can+bounces-1606-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF8993989
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 23:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E9B22836
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2024 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A004518BBBD;
	Mon,  7 Oct 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BqMsHoD8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535F74C08;
	Mon,  7 Oct 2024 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337683; cv=none; b=F8zgr1nouxLx8mdRBybYkMStPsScsGrW9BfbqHYzm7CoBIGwXDlEnM+gkGKVwyv9K0Q/Q5yFfkFcPYAsYPc2AFYzCk5kJHv+4aKgaY7dmZN0ER6OMu9FwAOfo91cwx7CjX8k+VaLP4bX8gGFqw9lmaM4JN02pyOnuBJMRDwiRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337683; c=relaxed/simple;
	bh=qVmzV/H6UOMfNGOvY3TKqBhr01pASTuN79Rmi1/JnPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhXPkKqdvBZxHwzwp/q12T/gzbeJJQPRqWtJuMASe3vSdwJYvZuQ4DAopci+Kje/+BZe5HXio7K7K8vaPTzcgWfYiKDxBqagHeOytHfy8iMwLbtS4DSKbYE+mHG8QgiAxvSGjg1++TcXxdHkL1LYeAD+dbNZ8MoyhHSrfyIT0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BqMsHoD8; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728337683; x=1759873683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5UYgTzXnM5eqMwIu5DLYwZIfp9TwYKN/EpHlZtCJE8U=;
  b=BqMsHoD8nfk4+ZnDbDKOVgeF9v3pf67O+Cp3K2tGT5aLQR9PwJhP0xWL
   YxpLoig0UuVNrytu7tVAfR+j8Pak2kbrsYJA0eAD7ekmM8Mn96QY4zlpY
   vuJITooYopIxnWSSpYFYTZZu8wcXoQotkWC0WIakdQuZuJM4b439Ygqvo
   0=;
X-IronPort-AV: E=Sophos;i="6.11,185,1725321600"; 
   d="scan'208";a="438976788"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:47:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:61310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id ba3521ad-b6a8-4f28-b11e-5ebb28fe17a9; Mon, 7 Oct 2024 21:47:54 +0000 (UTC)
X-Farcaster-Flow-ID: ba3521ad-b6a8-4f28-b11e-5ebb28fe17a9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 21:47:53 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 21:47:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <alex.aring@gmail.com>, <alibuda@linux.alibaba.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<johan.hedberg@gmail.com>, <kernel-team@cloudflare.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
	<miquel.raynal@bootlin.com>, <mkl@pengutronix.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <socketcan@hartkopp.net>, <stable@vger.kernel.org>,
	<stefan@datenfreihafen.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 1/8] net: explicitly clear the sk pointer, when pf->create fails
Date: Mon, 7 Oct 2024 14:47:33 -0700
Message-ID: <20241007214733.71958-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007213502.28183-2-ignat@cloudflare.com>
References: <20241007213502.28183-2-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon,  7 Oct 2024 22:34:55 +0100
> We have recently noticed the exact same KASAN splat as in commit
> 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> creation fails"). The problem is that commit did not fully address the
> problem, as some pf->create implementations do not use sk_common_release
> in their error paths.
> 
> For example, we can use the same reproducer as in the above commit, but
> changing ping to arping. arping uses AF_PACKET socket and if packet_create
> fails, it will just sk_free the allocated sk object.
> 
> While we could chase all the pf->create implementations and make sure they
> NULL the freed sk object on error from the socket, we can't guarantee
> future protocols will not make the same mistake.
> 
> So it is easier to just explicitly NULL the sk pointer upon return from
> pf->create in __sock_create. We do know that pf->create always releases the
> allocated sk object on error, so if the pointer is not NULL, it is
> definitely dangling.
> 
> Fixes: 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket creation fails")
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

