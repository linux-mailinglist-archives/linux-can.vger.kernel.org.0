Return-Path: <linux-can+bounces-1583-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3198BAAE
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD72B20C62
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAB519DFB3;
	Tue,  1 Oct 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frjVdLIa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC81885A4;
	Tue,  1 Oct 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781128; cv=none; b=ZQttga5LkpUs4vK7ryl/lk8R+SMUq3ajX4FNOF2QRWJQT+km3q2Zb1hVHqrek/JwRho1s5qfB56gvFIqZe0J781WmRhoqki/QpptOoMBvc1x6WUF09/MmayrvWumbx/r6vcYmXh4ARnPWZRw3glvz0+uCnJdc6z4ka40L1oCLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781128; c=relaxed/simple;
	bh=bLTNjASZloJNRz+323HD1OnMVcxJtaaEL69n/0QFJiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuFj6Csn55I3O0FSVnFNZtbD2tbqB/fqcZeuS5Hy91tyzPuKtWJ1zCj9zCE5XnxBSspG8Y00IoFAy6+ISsfDD2kAs6cb5CzkYuTxLveCpZ3omaZd0vljdHAn9+yc7obyNmETg5zfvHI5LRp5KQa5ZGw6o4lywNB9XgJ0kDpMr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frjVdLIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAB7C4CEC6;
	Tue,  1 Oct 2024 11:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781128;
	bh=bLTNjASZloJNRz+323HD1OnMVcxJtaaEL69n/0QFJiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frjVdLIae+QeEJ+ELUhBKrUQdEl5eWaR7zhkxEL4+nC6n7iQ7L+x8Ekhfa5F3s5md
	 pmKdlYLFPXvaB7IoqPp20D73g6yvoD8Y9T2OL07YoWPCb0zq147M9r1CWX+BNjxqnE
	 HCs4+WBtLBFADPIozfuYUt6e/nkN6bnIXlHpg7oS9oEnO5wZHLdznbsND53ZBTvDYb
	 3MhloR3JcoNNIa4VwiCbTuaLAyUklhzaQxissC8lkM4bsS45FVF56L3yGCa/OsGbFI
	 ZRET9K/4ML3R1kt+YEc1Qp42DWElqlEeDY6aty0amtkYrBCozoaIYsUJTJAnFVVpGs
	 hp/7MZYRjxchA==
Date: Tue, 1 Oct 2024 12:12:04 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next] can: mcan: m_can_open(): simplify condition to
 call free_irq()
Message-ID: <20241001111204.GP1310185@kernel.org>
References: <20240930-m_can-simplify-v1-1-43312571c028@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-m_can-simplify-v1-1-43312571c028@pengutronix.de>

On Mon, Sep 30, 2024 at 08:03:46PM +0200, Marc Kleine-Budde wrote:
> The condition to call free_irq() in the error cleanup path of
> m_can_open() can be simplified. The "is_peripheral" case also has a
> "dev->irq != 0".
> 
> Simplify the condition, call free_irq() if "dev->irq != 0", i.e. the
> device has an interrupt.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


