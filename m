Return-Path: <linux-can+bounces-1678-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3F99D949
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37411C21473
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854801D1739;
	Mon, 14 Oct 2024 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YJnUPp4V"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373915575E;
	Mon, 14 Oct 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941940; cv=none; b=ALDKfJQj+GdEjGphBIptR5/ToNf4wr9dV9Rlpz9iDz7taWqM++zoVLE4//K9TT+waoXY0W4PkBXYl2zw/jUKug8uB3Nw62m/wvmjOTyKmPFZ60hfggSV7iz6o/68LULry55LzS6SG2Fz6H6ZSkQoRAFazG+LsK/eGV+maV5XxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941940; c=relaxed/simple;
	bh=pQYIct3dM9sg6Iggfyj5KwY52ZD4UmQwHeQmcW34nZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M43cd5oXgeReV/5rjT2GkfeH9kM5UTTSj/tbstS1OCYYk2tu0gxDjCNxpvSPrRLGqmcWUDt2FInaHLFYWo/YNYrcuXUPkPw07hlOezfGNoTwgtdoq6YC+UmNq6Z6yLW94VaArwf6Vgt2fEWesGVyMaUwHDGiziTc0KljYQSYrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YJnUPp4V; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728941939; x=1760477939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DF8vkyjA5G4R5JIvo2q0KeZN2zzdQyoxtNsHpgLK7mQ=;
  b=YJnUPp4VZqVsNBdUdEqcn2Hr1iSRc05g35Jz/stCJB2B7J3OZfv+bG8n
   XAiZj1c2V8lfDwh4C15emISquZ2tFhre5OEv/owU/le5ICvQd+E9Xk423
   JgaAeM8oBuCxsCo5gWGWUDga+IqeJDXIy6nwmRtC0OEVuJAFEIAJgJ/WW
   E=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766516037"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:38:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:14244]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id 43a2b6a4-252c-4d14-ab11-be0cfb154bf3; Mon, 14 Oct 2024 21:38:57 +0000 (UTC)
X-Farcaster-Flow-ID: 43a2b6a4-252c-4d14-ab11-be0cfb154bf3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:38:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:38:52 +0000
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
Subject: Re: [PATCH net-next v3 7/9] net: inet6: do not leave a dangling sk pointer in inet6_create()
Date: Mon, 14 Oct 2024 14:38:48 -0700
Message-ID: <20241014213848.99389-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-8-ignat@cloudflare.com>
References: <20241014153808.51894-8-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:06 +0100
> sock_init_data() attaches the allocated sk pointer to the provided sock
> object. If inet6_create() fails later, the sk object is released, but the
> sock object retains the dangling sk pointer, which may cause use-after-free
> later.
> 
> Clear the sock sk pointer on error.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

