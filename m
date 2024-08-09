Return-Path: <linux-can+bounces-1187-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2594D7FF
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 22:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491E2283308
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4DB15A851;
	Fri,  9 Aug 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VSCy9ql5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EC33D1;
	Fri,  9 Aug 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234985; cv=none; b=RAGNPxh0IaiWPurGTSnkFcSZChzls3UPrgrJ9Gpg4pSHn4ASxfp44osTjL9Z5wtVze40Dr1btl6bAWuVyDIZuuD8cyvv4lvby+gvDKxsm7scNS2pnjHVgrzfcdFPpZjpnWj7fCjcDst+V+3yU4YxrrttWmHzRGGX5KBkb94eKXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234985; c=relaxed/simple;
	bh=SGdE+e5vii25VpavXbLGyCEpV8mXQD+JqsD7M3i7j8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFB6bFo1ZmtxwXPmTWPc+BHqiUt9CLgMSszaxxX/fKGJ/dnUpBLTzAdLO4oHBt4+EwRhHykynHz0ca+JIyyy8XqIfIDkjCr/qgcbQPDmDWOXGy38QmU50Xilg2fuzBcWWcyPuOFs1Jkqj1yxZ7uNU2ebrDoApT5aOovdIDLVc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VSCy9ql5; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723234983; x=1754770983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zUeaPEMbAwsBz9fFLJRiAzOBSEZsFMQr1EZcxbWRRq0=;
  b=VSCy9ql5OnQriNZQ19xqkqV6xgtXbUdqJekYUfnZjxyfiStMVnsHxj3u
   g2czAOgACFAMhh/vCTwdL4D9Gx4qy4vMxESQpri1GGhGULtj5DS2mRg/F
   h3NsNk80yWM1Jh1XIA536nP2PReH0mygO5ShdAouxmZyM8UyVutUCQArj
   M=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="113920681"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 20:23:01 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:45062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.195:2525] with esmtp (Farcaster)
 id a3ffb0ee-4f38-4521-91fd-3a8fa119e9f5; Fri, 9 Aug 2024 20:23:01 +0000 (UTC)
X-Farcaster-Flow-ID: a3ffb0ee-4f38-4521-91fd-3a8fa119e9f5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 20:23:00 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 20:22:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <socketcan@hartkopp.net>
CC: <davem@davemloft.net>, <david.hunter.linux@gmail.com>,
	<edumazet@google.com>, <javier.carrasco.cruz@gmail.com>, <kuba@kernel.org>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mkl@pengutronix.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<skhan@linuxfoundation.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] Net: bcm.c: Remove Subtree Instead of Entry
Date: Fri, 9 Aug 2024 13:22:49 -0700
Message-ID: <20240809202249.16183-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2bf44b8d-b286-4a94-8e1d-6c4e736a1d07@hartkopp.net>
References: <2bf44b8d-b286-4a94-8e1d-6c4e736a1d07@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 9 Aug 2024 11:57:41 +0200
> Hello David,
> 
> many thanks for the patch and the description.
> 
> Btw. the data structures of the elements inside that bcm proc dir should 
> have been removed at that point, so that the can-bcm dir should be empty.
> 
> I'm not sure what happens to the open sockets that are (later) removed 
> in bcm_release() when we use remove_proc_subtree() as suggested. 
> Removing this warning probably does not heal the root cause of the issue.

I posted a patch to fix bcm's proc entry leak few weeks ago, and this might
be related.
https://lore.kernel.org/netdev/20240722192842.37421-1-kuniyu@amazon.com/

Oliver, could you take this patch to can tree ?

