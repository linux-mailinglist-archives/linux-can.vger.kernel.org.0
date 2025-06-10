Return-Path: <linux-can+bounces-3803-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F82FAD461F
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 00:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08A87AAF66
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248392690EC;
	Tue, 10 Jun 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHSm+2/b"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44378F34;
	Tue, 10 Jun 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749595841; cv=none; b=nv6XvV8y/b1EmEeSyTj34+iRA/sa+vOtOVIz7HPr60LwMw2EmNUa0fui4JM1ygEjxyfuJpbaXoQPOS7KKP0yFp0X78xVtKBcLTVZfLBwVv3Tk4m5hFVnyXcI2kmjExqyYbBB6OWp6DWoV2OQe3HLouZP443R/MgiwySEN3jqr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749595841; c=relaxed/simple;
	bh=E5Joro9HlzBjP3julacNUlpI6/kKDTFeiWRVvm3pCSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQZ29Thtrval4aXYeVsEiA/490f3bwDceBVbl7GcteQcaw4caUtc4FQpRkjB76iKHOmXAdkwqiEauv8p76dH/LebYwqdpl2GtAo1NsdyStC2Q+trOBUGPMYLfAcWjIT78ZnYZ4232va78SVTEm5Yx3/ExefmYT6Mty0uPlfgums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHSm+2/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20352C4CEED;
	Tue, 10 Jun 2025 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749595840;
	bh=E5Joro9HlzBjP3julacNUlpI6/kKDTFeiWRVvm3pCSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHSm+2/bBfjGvwLtXPYEm1ksY+T+c0sZSLJLYPvjn308/AGNvLc/faQOoZMgxIZia
	 zqFpDGmz/DlnVFURcgyG0CEwiR8yj8WbpIewfYjwpkA1KsMcUzA05qaatH91F1As/J
	 zWoT4en7GMM8Un4HrSyOhFD//JTi43AQuLAqPyiZNydW/JR600Z/D3ZIjZ1Nf6aplF
	 yqF28E4JJdp/PptJUnZ+xvPE38SiONAE6hw1TjG5ixvtdLKEJKsHbDIrwVnVT5Y8aa
	 C9MRQ1rFZqMDWfRViRdOUmAPht34TnbGWulyHXMbfAkV0t7tdliLa56Yu11qmlollG
	 DtVYay4jlUZzQ==
Date: Tue, 10 Jun 2025 15:50:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 6/7] can: add drop reasons in the receive path
 of AF_CAN
Message-ID: <20250610155039.64ccdbda@kernel.org>
In-Reply-To: <20250610094933.1593081-7-mkl@pengutronix.de>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
	<20250610094933.1593081-7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 11:46:21 +0200 Marc Kleine-Budde wrote:
> Besides the existing pr_warn_once(), use skb drop reasons in case AF_CAN
> layer drops non-conformant CAN{,FD,XL} frames, or conformant frames
> received by "wrong" devices, so that it's possible to debug (and count)
> such events using existing tracepoints:

Hm, I wonder if the protocol is really the most useful way 
to categorize. Does it actually help to identify problems on
production systems?

AFAIU we try to categorize by drop condition. So given the condition
is:

	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) 

my intuition would be to split this into two: "not a CAN device" and
"invalid CAN frame". The latter not split by proto - user can dig into
the stack traces of the relevant drop for more details.

But drop reasons are not uAPI so we can re-align later.

