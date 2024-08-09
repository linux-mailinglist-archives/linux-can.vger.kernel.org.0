Return-Path: <linux-can+bounces-1188-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25A94D81A
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 22:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8794AB230AC
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E315ECD2;
	Fri,  9 Aug 2024 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qtc8IBUB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5E168486;
	Fri,  9 Aug 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235328; cv=none; b=fuO/QcT/awPncG40Gg7L+GnuQfAzUTf1fdwFTRoFYYfsDhAK69/Wv7bDCX60SgsTk1aHAY/eWSypg+k/M+mqGUc8NTWwZ6uVJiFYQ11J5Pc3BEFYZcNkvf1mBQYX/I4beDpldZpCVGjBclbG4weBTnzLz0XkLBSSpsYvL/jbZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235328; c=relaxed/simple;
	bh=RVTD8lu37WkCSvbV2tFQ5te0a5UrAuGbiQPVnzS4a2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skA3vDp6TqLoqztyhHkvbTatJ3n0eQucYefQVyOVBp+h8NFvc0jOHfdZpLE8V16rqPjb12Zx8otjGfmGm9xN0rwmwGJY2ZzUKyAx/LG2Y6sIFjEe/nnYA8LsR2Z1biBcBiysObyqDvFP0pg8/mKhqEP033pGfdcKfze19C+SccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qtc8IBUB; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723235326; x=1754771326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dl5Cve0Lb8Sk6iPByTnFqllv4rbw1bCvGfSFc/Qsizs=;
  b=qtc8IBUBe8gtuABB+5c449nwvh4wqTh/efm7iC2x+K2DBCX3kjvPmQ3a
   zsm7Mw23AYKk+yFthgCyPpDg49+XOw1sVpSiifVEuUi+MTOEDW4unsvh8
   8AeJ2PiMs2gD1Kd3uBl/eJ+XK8NKR/Rj2TVq4Ly8qd9uWZ8ENkH1Zt8XE
   o=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="114172973"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 20:28:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:61520]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.82:2525] with esmtp (Farcaster)
 id 1a9688fd-8a99-46e6-be2c-5d19aebc4a7c; Fri, 9 Aug 2024 20:28:44 +0000 (UTC)
X-Farcaster-Flow-ID: 1a9688fd-8a99-46e6-be2c-5d19aebc4a7c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 20:28:44 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 20:28:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <david.hunter.linux@gmail.com>,
	<edumazet@google.com>, <javier.carrasco.cruz@gmail.com>, <kuba@kernel.org>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mkl@pengutronix.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<skhan@linuxfoundation.org>, <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/1] Net: bcm.c: Remove Subtree Instead of Entry
Date: Fri, 9 Aug 2024 13:28:33 -0700
Message-ID: <20240809202833.16882-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240809202249.16183-1-kuniyu@amazon.com>
References: <20240809202249.16183-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 9 Aug 2024 13:22:49 -0700
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Fri, 9 Aug 2024 11:57:41 +0200
> > Hello David,
> > 
> > many thanks for the patch and the description.
> > 
> > Btw. the data structures of the elements inside that bcm proc dir should 
> > have been removed at that point, so that the can-bcm dir should be empty.
> > 
> > I'm not sure what happens to the open sockets that are (later) removed 
> > in bcm_release() when we use remove_proc_subtree() as suggested. 
> > Removing this warning probably does not heal the root cause of the issue.
> 
> I posted a patch to fix bcm's proc entry leak few weeks ago, and this might
> be related.
> https://lore.kernel.org/netdev/20240722192842.37421-1-kuniyu@amazon.com/

I just noticed the syzbot report that David pointed out has the same
splat, so this is the same issue that my patch fixes.

https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a

