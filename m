Return-Path: <linux-can+bounces-1679-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606CE99D954
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254DB282CCD
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74381D1F69;
	Mon, 14 Oct 2024 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UjMQxEx/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA91D1518;
	Mon, 14 Oct 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942060; cv=none; b=duGpj3sLpdwjAYSXn2f19Rnf/1Gltiewji2Y3L+9tqfjIAD+GTErRB2rDVCac41oh9gNP8sYfYeSMv9CcVfio51N6ipQyxvUwH/9MVsFtK2f8wmSv91+TN0x99w9qErON3ntsu+Ejvxq23Lk2I8KBE+HRponM/Isyu1qziduJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942060; c=relaxed/simple;
	bh=5tybJj87GEUPc0wTVFPoTUOp5X7TYtD+hUTHPDwr2dY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+4WmpgOahMIEEDU4/+NzYRWah2rKiewD2iXL9PEaP0b+vvPS/W6zMTe7l8XEYOwniOZG3BxI/ei0Bb7TeZ8hrf7wpBkyKVm+AEVFHb55bJcftkJ149IiWJSp7HWSQtBrFs+By67C9mxcznbJe+OvOZBwmE0iXTH1gTt5dEA4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UjMQxEx/; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728942060; x=1760478060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TsWdPhAg78zah+haKesFDNmrKf2/vLwX+nTS3fPXyEY=;
  b=UjMQxEx/PDhrSgVPkR1duuqcbMs4srZFCaL0N+/nI01SoN56zndIbvSF
   Njg2KgKZItVAzVlBfNyx30Kpg3EAAmTTkGXVHkcTOajep5WZKuVp5Pbx3
   /+DmJTVZAViZ5E3YhmeuFbnSQ/RIrZen7IBObdkT3Cp414lRAKjsEPfwo
   A=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="440762113"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:40:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:34442]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id ba444916-cb10-4a0b-bce8-f20f62f6a979; Mon, 14 Oct 2024 21:40:55 +0000 (UTC)
X-Farcaster-Flow-ID: ba444916-cb10-4a0b-bce8-f20f62f6a979
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:40:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:40:50 +0000
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
Subject: Re: [PATCH net-next v3 8/9] net: warn, if pf->create does not clear sock->sk on error
Date: Mon, 14 Oct 2024 14:40:46 -0700
Message-ID: <20241014214046.99495-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-9-ignat@cloudflare.com>
References: <20241014153808.51894-9-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:07 +0100
> All pf->create implementations have been fixed now to clear sock->sk on
> error, when they deallocate the allocated sk object.
> 
> Put a warning in place to make sure we don't break this promise in the
> future.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

