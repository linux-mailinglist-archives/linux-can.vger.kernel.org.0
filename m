Return-Path: <linux-can+bounces-1677-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB799D943
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C7E1F22892
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19F1D1E62;
	Mon, 14 Oct 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AOIZw3b6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD01D1518;
	Mon, 14 Oct 2024 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941842; cv=none; b=km1ezKOuR2BqFO0SWQpURF3RchwlTruPJHDICX4pTlRgdtEu3FlL159wI3qo929bPqCEDfIBxl4wmFGdLIpemTyqe3zGZnQfwgRG7vYBIAVWkBB+/2lROfXL6RirIpj0EauDfkZ7WhNM+ZXrjiL+INX/n0ZWpbiK6FfdvIzOOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941842; c=relaxed/simple;
	bh=p/HRydk2WbbeV1Xsj4DBf6LGpuJs9jl6ySz3PNzKmWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8VRdBM2TO6IBk9oRrpPfywRDV3xUt9WebI6cFl5+DkaYkPJfbGnoye9cEhMy6H/vE3i5cf41Dzh2tVOVj51Qd1LrrhzhRtPRyfaZsi2neqyxKClAb77Ry8EjtfWe8W+euolKaLJFi9az6Mx7RCOPiz3PnRx+1kminPmDKrYcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AOIZw3b6; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728941841; x=1760477841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W3hd+4pFwwziUAi74TQ9zioclqFqUTYcF/v2j+nzP2M=;
  b=AOIZw3b6LYLDxpP1OFY9GYEjDSS4nrkrD9eIacSM8TWOK8Tqi12XMotb
   o6fc+1rrNUD0u4IPMjkhkkUa0nNOqz04nG38w2bCcIkq3Ja9V3c3FL8fp
   NX/rsYpqF1Dq6UYyM7YlHKaphhrD9ysSDy1Wvv9CBC+cUCi0PieTC+iRU
   o=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="376100539"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:37:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:61276]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 68574c29-0a0f-4daf-83c2-8303d7174fd3; Mon, 14 Oct 2024 21:37:14 +0000 (UTC)
X-Farcaster-Flow-ID: 68574c29-0a0f-4daf-83c2-8303d7174fd3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:37:13 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:37:08 +0000
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
Subject: Re: [PATCH net-next v3 6/9] net: inet: do not leave a dangling sk pointer in inet_create()
Date: Mon, 14 Oct 2024 14:37:05 -0700
Message-ID: <20241014213705.99272-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-7-ignat@cloudflare.com>
References: <20241014153808.51894-7-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:05 +0100
> sock_init_data() attaches the allocated sk object to the provided sock
> object. If inet_create() fails later, the sk object is freed, but the
> sock object retains the dangling pointer, which may create use-after-free
> later.
> 
> Clear the sk pointer in the sock object on error.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

