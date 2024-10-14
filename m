Return-Path: <linux-can+bounces-1680-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B721C99D958
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488E51F22E17
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840121D0490;
	Mon, 14 Oct 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DD4/OUrS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746A26296;
	Mon, 14 Oct 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942173; cv=none; b=Wh1Y97xoFk/cNFKZ7Op//k3plb9sGLp5eIjtaQ+5nxpGWBgKggzKwWxQO0F180tw1H+HunnT8c+lVvXiQsFD0GvUqb8TC1EosiaQNsDTl6cf6xEgfXhUOP4NApFuTqLTVf3L7L3Zt3+0c+uNVzhub85YxEB5Ndb81dWm/dnXSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942173; c=relaxed/simple;
	bh=R8TLXuDeZ/MYISPWdcvYZ2Bu1EAnbjLogEwVptKbAUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j75xeKOnmoh3dmAST+6/ykYMW+YLBzb1gYKcOh3/CW5qN5J/yH1i5j6lOaEqqqtidaPv08uWnnwBVIkm3RtOfKfGJWUMCaQy9ZHLHMYRfpeYr0z8ee8f1UISLJ1y5jHDS2MHELTyegVPfaJ3dmo5ySa/yiSDgtnTGHl3TOgA21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DD4/OUrS; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728942173; x=1760478173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38tSf7bWxW+kNdx5AoLI8mlMpML3oA826XH6AyrChzQ=;
  b=DD4/OUrSTY6/0T2KoqkgDEYMV4sBOvWtRVas2Ni2BVaEusydwX6wEG75
   KDMrr44OtRASa+KKAVUvryKFeL3kA8QB5QFI8PLR9x2T2gSa9anQfVnI9
   qVzG6gqYLofWkY4+OQPh9d36l3ivUSxUlp10RlawcDd6Gmry5EuAkk96V
   w=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="33178660"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:42:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:26950]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 74ac6199-0006-44ac-aa20-580d5d9f7a7d; Mon, 14 Oct 2024 21:42:46 +0000 (UTC)
X-Farcaster-Flow-ID: 74ac6199-0006-44ac-aa20-580d5d9f7a7d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:42:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:42:40 +0000
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
Subject: Re: [PATCH net-next v3 9/9] Revert "net: do not leave a dangling sk pointer, when socket creation fails"
Date: Mon, 14 Oct 2024 14:42:36 -0700
Message-ID: <20241014214236.99604-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-10-ignat@cloudflare.com>
References: <20241014153808.51894-10-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:08 +0100
> This reverts commit 6cd4a78d962bebbaf8beb7d2ead3f34120e3f7b2.
> 
> inet/inet6->create() implementations have been fixed to explicitly NULL the
> allocated sk object on error.
> 
> A warning was put in place to make sure any future changes will not leave
> a dangling pointer in pf->create() implementations.
> 
> So this code is now redundant.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

