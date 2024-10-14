Return-Path: <linux-can+bounces-1674-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99999D8FC
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 23:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850B71C214F0
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902391D0796;
	Mon, 14 Oct 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HYLbpUQL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA91A4E9D;
	Mon, 14 Oct 2024 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941413; cv=none; b=JNLjnJkw2iLW/omxmLYZyQTfUPhi+3Z6bqnNRj91VAR7YfsP3UQhFCo8+TvU2ZA0xrrrITRgR3euOFTIK2YpGMRasje/HCETayeps075K9eQmmMfuu/FiiKAt6C/xSxqcVmKGAc2mOMNA5MDO7/g9sIcyWiEupr2uGIIkMv37w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941413; c=relaxed/simple;
	bh=su04eqcmzbNsoBPEDjOtk4+rC2d9cxSsGq4fWIYfB08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlqDxl8yv8YSecmJId7vl6dQL1KBjEPkSsRAjbUxjO0FKAH0n0ycErZZF9CH6MfvP2z6OjhS2T8cJvIn3BxN8lR4OjzKhMHg0q0oMjmECflI3CthVBECvzR1QVl5Im4l6hcErJCMHv79xrLBg7ESWwTjk5FxL1rXYGlernXkJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HYLbpUQL; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728941412; x=1760477412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cy3nRj6ZbrEXkjSJrmnBFPGak+LBHbw62VLP0dq0Jsk=;
  b=HYLbpUQL3tuPl9GLZ7An+FI0CjQYNwvjoIsVDqTlhr4WNqqQsMnmed8g
   p760A8mESQbLNK0eUxJ1/YeXCZtu9JGDtM6BmPeU6qCmlSWpKbElBIU+T
   ASbVobne9Zfe/mOSA2sGCm/+Ad8DDDikn5znY1p3M0ASZxzzlpo9zCW9n
   E=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766514186"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:30:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:62488]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id c51856a5-92bc-4122-b22f-690cf97f479c; Mon, 14 Oct 2024 21:30:05 +0000 (UTC)
X-Farcaster-Flow-ID: c51856a5-92bc-4122-b22f-690cf97f479c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 21:30:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 21:29:59 +0000
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
Subject: Re: [PATCH net-next v3 3/9] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Mon, 14 Oct 2024 14:29:56 -0700
Message-ID: <20241014212956.98604-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-4-ignat@cloudflare.com>
References: <20241014153808.51894-4-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 14 Oct 2024 16:38:02 +0100
> bt_sock_alloc() attaches allocated sk object to the provided sock object.
> If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
> dangling pointer in the sock object, which may cause use-after-free.
> 
> Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

