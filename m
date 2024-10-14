Return-Path: <linux-can+bounces-1676-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0A99D931
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFF61C24AFA
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C71D1F69;
	Mon, 14 Oct 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GOO/4LB6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034F1D27A9;
	Mon, 14 Oct 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941720; cv=none; b=LtHU/nIf1ii2+nVHRrQ6LzFxnjI/tncIp5Rm+2v/MQovKiKUoYTBzIw91mBA1wi+llZ3TtzbNxIdeVRUnqT8kVTmJRVKVK4yXZUp3E3U4WsEUxdmxCz7qq7MWD9aqBu1UoDhlWmlWjQFCMWUscc02sXeUH/b3EmfiIj1vByxsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941720; c=relaxed/simple;
	bh=C2pOexooCIcGgd8vS6n6mfILsYcfRSYxPD2V+XFNlqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndRfIqoDgChJPVmq9mXIsUD/XiMmzg9fEWb1elUj13mGRC335zoGfiyfo/VgoFJwnuDPhLB0AQ+rxgNHk/VIOWsO3x5GHyeN3q7l5vEDaP4q1XxJq1o7W173c/akRorYAmJDe3Shc9qgmgVTP19FlEXUUL/VqW74642U+lj0cXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GOO/4LB6; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728941719; x=1760477719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gySbmUUcVgx8A0HlLGRHsrxS7qemurEk0AThfU8UVrA=;
  b=GOO/4LB6ulLAr2cGcdnQmbVViDZu/tEQWrDYH6dq8AHRdT8C4AC1sVhD
   iNAEWYPlQtVHYLpihwBxme5y5HH3nnjDVb7i8Xsf83MZ7SZQVGtkkUyl9
   X1V+twCymLpDUem85mgzrpSLy+KkY6fvZl3IXG/WQQklG2qgCz10Nv7FN
   U=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="440761007"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:35:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:51033]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 16445af8-4a7e-487d-9604-81aebfa4da36; Mon, 14 Oct 2024 21:35:12 +0000 (UTC)
X-Farcaster-Flow-ID: 16445af8-4a7e-487d-9604-81aebfa4da36
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:35:12 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:35:07 +0000
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
Subject: Re: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling sk pointer in ieee802154_create()
Date: Mon, 14 Oct 2024 14:35:03 -0700
Message-ID: <20241014213503.99078-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-6-ignat@cloudflare.com>
References: <20241014153808.51894-6-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:04 +0100
> sock_init_data() attaches the allocated sk object to the provided sock
> object. If ieee802154_create() fails later, the allocated sk object is
> freed, but the dangling pointer remains in the provided sock object, which
> may allow use-after-free.
> 
> Clear the sk pointer in the sock object on error.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

