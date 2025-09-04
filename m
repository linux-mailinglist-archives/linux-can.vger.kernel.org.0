Return-Path: <linux-can+bounces-4463-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E4B433B0
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6864316EFCB
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265E29ACFD;
	Thu,  4 Sep 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="saRGw1uu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EWpAf+ne"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591F29B8EF;
	Thu,  4 Sep 2025 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970472; cv=pass; b=rY8UQMJUSuXwr8iEUJVF8UUHd6wZI8bGTYluvGcMS4R0g6eCsnnpF1C/S1dxGxOnsSUISv6JaEcNcRjqMWStHytfWL3rxJdT75yCvNdR3gTcF3sRea59X9pCbqXyVWv0gH+NGyj0ju+hU3GVMcSK16LVjQrD4500B6mYtg+aTtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970472; c=relaxed/simple;
	bh=d5Je983Zpm6ZxezaW99TgfVmvsNsRMqV4eFaF2on/Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRaqnjvwyAM9HYzGDaYZq5FK46TSyugpmHGnDy4k5wc0Th8mboAD/2aSi2Dg+iwpx3a/s8rzqyJ2dmEsuZbDwy00T5GhAJws0Tw9htYHXybzegdhqWIF99BdfqU4SHAAo/JwjhAhLx6xT+Lf/Qt9tsBqhY0WErNMZkWvfO56BeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=saRGw1uu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EWpAf+ne; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1756968663; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JJOC8H7ALT2yV0Fz2I5MOisD5ds6rjyny4m5m2+30I9SZNJ4SYpAY7aWkuWIyEkuq/
    1qQ18ESSdWSDXTWLR/Fd5UZGT5uClr2BB8nZ6ZD070oiIkR+NkjoW1j8tzS+mRg26Rxt
    rhktBhB41UWEhmHt2n5i2iFqbBTQo8941bXEuuxETqbnuUrUrZ9WRElDhRF/xD0BKtrQ
    D/Eyd0Bn/uODqhNQv5ECsjLuRuTPRqKczslkhIEOlRMh2gAfANw2HlEwsKSXuxtzenlQ
    N5SLTNVlyFpR5I4nVnAon3rvQ6U/IJi76sOAEqW4KGc7jHzcYO8awcAFq0wVgWE2U70p
    H6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756968663;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=q/8yqkRcNNGInyNpRQZmjg/AxxUKBcbXWsOam492Sws=;
    b=qip2UErn3WsyKTGGp5lhHvm4WPFkWSRdi4KS/XknCdDXMtSi/nBpbOnYIxN5to8KVj
    Gu8cjq4GeHW5aGjow8gl7Bnu1lfKaWGmKn60qyc9qtarB2LRjg2HSiD1z6XKVtIVN30Q
    GSxH6HUsX85b5vxoCrOEWL8YFIvSGzdPzQdadmnj6vG7iwNR270GQlKsc4UbluuMqvnF
    O3xyHfCEKWhBKksu1qiz6wsFUOrUSHHcDd63cAUSX+3D9ivWdh/OB3H4JKoHr2Nbl1Bo
    EiWJJ9QH0d3Ei6SA0BdQdWP8Wlpg075WQM8ux02/L6DThcdSdjjvLKekW1t2qoIlpwxr
    4sOA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756968663;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=q/8yqkRcNNGInyNpRQZmjg/AxxUKBcbXWsOam492Sws=;
    b=saRGw1uuSHB2hEjrbwPS071Ksl8doTkt4ocZc1QKFkhjQJL2k3+icmVoDUzqurhujm
    x5xJl7iM+jgRUYG/0cQRTTxfRE3MAsT+uCPTOVOYT0TMLZdAeBSBE/hGArYmeBq1bCek
    OZgBQbxlpKm00IUrGNVgRZW9FijxZ7WFL9jjmxwKv5ykxzG/zBzFEOlT2jIcMIPE4ube
    PWb3pxgFXp60MJH+IQMS7sPUHSdGe4RLdogOBHXGTTQvENO/xJW9JtbGmv6Ag+PhpUo2
    sL/4ntfCaYp7cJH0ae2H+KZvrYCpTKOfvWp6AhvKK478Ajtro3IVy495Ts2MjBbB3HMh
    ioLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756968663;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=q/8yqkRcNNGInyNpRQZmjg/AxxUKBcbXWsOam492Sws=;
    b=EWpAf+neZHnmBy7L7T7MiwEhatoOqHtWKj+FX09CV5jvczK6L0O7gx7kVZ9FT8tnx9
    ZfPAOY5m9pABz6GzMdBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611846p2LlS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Sep 2025 08:51:02 +0200 (CEST)
Message-ID: <b1bf6cc5-f972-4163-8619-e04b887e2d32@hartkopp.net>
Date: Thu, 4 Sep 2025 08:51:02 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] can: netlink: remove comment in can_validate()
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <20250903-canxl-netlink-prep-v1-7-904bd6037cd9@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250903-canxl-netlink-prep-v1-7-904bd6037cd9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 03.09.25 10:50, Vincent Mailhol wrote:
> The comment in can_validate() is just paraphrasing the code. When
> adding CAN XL, updating this comment would add some overhead work for
> no clear benefit.

I generally see that the code introduced by yourself has nearly no comments.

E.g. if you look at the [PATCH 12/21] can: netlink: add 
can_ctrlmode_changelink() the comments introduced by myself document the 
different steps as we had problems with the complexity there and it was 
hard to review either.

I would like to motivate you to generally add more comments.

When people (like me) look into that code that they haven't written 
themselves and there is not even a hint of "what's the idea of what we 
are doing here" then the code is hard to follow and to review.

We definitely don't need a full blown documentation on top of each 
function. But I like this comment you want to remove here and I would 
like to have more of it, so that people get an impression what they will 
see in the following code.

Best regards,
Oliver

> 
> Now that the function has been refactored and split into smaller
> pieces, let the code speak for itself. Remove the comment.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   drivers/net/can/dev/netlink.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index f7b12057bc9c6c286aa0c4341d565a497254296d..6ea629331d20483c5e70567eb1be226a3b09882c 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -143,13 +143,6 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>   	u32 flags = 0;
>   	int err;
>   
> -	/* Make sure that valid CAN FD configurations always consist of
> -	 * - nominal/arbitration bittiming
> -	 * - data bittiming
> -	 * - control mode with CAN_CTRLMODE_FD set
> -	 * - TDC parameters are coherent (details below)
> -	 */
> -
>   	if (!data)
>   		return 0;
>   
> 


