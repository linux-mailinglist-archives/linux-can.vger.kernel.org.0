Return-Path: <linux-can+bounces-1608-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A70993BA2
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E56A1F242AC
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD665AD5A;
	Tue,  8 Oct 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upa9NYTG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A9EAD51;
	Tue,  8 Oct 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346831; cv=none; b=teVeSS67rLDbOTMoAFLesNoej3lFlSIiy+ryWr58AtDWfbrYDkSW6Jmnn5MzsI71prmkyaw7zbY2gLA4I7H2kjQUN71SK1VfrI/svPb+gPFpcDkvK8UPSYNqXng41EMFAUNHi+VzDeMeOGLKeBAv9n1h2W9HtHbQYRxove/ETpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346831; c=relaxed/simple;
	bh=/+6uaaMCh4sbJPAQbhHpA/CscaKM7TpXkjIak0yRLVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANpiZcFlmMiMVIh7FsykRtUXSPpsHgxnWa0oQlGNRMVdNv59e20zim5rYDWbFWgIhnm0WoaO/thfzAZ2kWHtrTiqYR4nPZ3mH/30z1Z06ZsmPvDUyYtMX0aRJb2n3mYN7C7XICV9FMfuGGAqecBvihDd58KxehddIhf7TZISjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upa9NYTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509C2C4CEC6;
	Tue,  8 Oct 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346831;
	bh=/+6uaaMCh4sbJPAQbhHpA/CscaKM7TpXkjIak0yRLVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Upa9NYTGyJ/4HOqvJ+z6HZV4iVbewGaDD7R0rtxi+8+0YHO75QlapLO0hblRyH54r
	 Okpwc3i4hN2fm2TTAMum4DWcA3PuxELXL4id91Pzdf4YJsZzHIjUUEB+9LlhojT8Ty
	 pGySaM8AdRn14naMI97Tn0ZovOiyYQp1GagE9QMcHbaWoSqBSa6SoYKb0i4f5Zbdxp
	 7HgOBehE6GDxIekWcBJp3b+Cwm+YSiuk8rN/6eKzV/d9o4LO0Uo3bT6RorAppQZr0c
	 LKoOakFhsxPgKmA31UDLNyGce01uDRGwf3jdbvlLf4IgJESjf5WZE2UEKxthqjVGHK
	 bB1zUXWGFN/Ng==
Date: Mon, 7 Oct 2024 17:20:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp
 <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander
 Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern
 <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com,
 alibuda@linux.alibaba.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] net: explicitly clear the sk pointer, when
 pf->create fails
Message-ID: <20241007172029.5d48ea32@kernel.org>
In-Reply-To: <20241007213502.28183-2-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
	<20241007213502.28183-2-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 22:34:55 +0100 Ignat Korchagin wrote:
> diff --git a/net/socket.c b/net/socket.c
> index 601ad74930ef..042451f01c65 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1574,8 +1574,13 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>  	rcu_read_unlock();
>  
>  	err = pf->create(net, sock, protocol, kern);
> -	if (err < 0)
> +	if (err < 0) {
> +		/* ->create should release the allocated sock->sk object on error
> +		 * but it may leave the dangling pointer
> +		 */
> +		sock->sk = NULL;
>  		goto out_module_put;
> +	}

This chunk is already in net, as part of the fix you posted earlier.
Please resend the cleanup portion with the other patches for net-next
on Friday (IOW after net -> net-next merge).
-- 
pw-bot: cr

