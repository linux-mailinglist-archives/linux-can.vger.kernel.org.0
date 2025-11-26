Return-Path: <linux-can+bounces-5668-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D1C888AA
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 09:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8263A9334
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DE29D269;
	Wed, 26 Nov 2025 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b31HG0FG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HHxmrynG"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B02C0281;
	Wed, 26 Nov 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144198; cv=pass; b=OTOUDyvhUOtUthw7V1RKtIKXPdmDTEZa1WxrmnCnWe7WS4VE4rLHSKzce8SOv0pV7Be8Xt4Hzuo+HXn95KWDl3AVglGJAlzrG31vkr3GAMW6hTBXpo2VKDXg7Q+qV0YBD54gc8oxPE4S22YIrQG3FOzCKqoazP3opSzj/h189G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144198; c=relaxed/simple;
	bh=RelsMd9hfRJ7l5QRe+U2TTU9wBkP1DUd6GiP8S5Fook=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TD8FHCmVF3iSBnkZkU25AS3FxYlVDd5Roqzie/yjpY0ZxV+OZIOrnUAWgKFWOZg86MJd1A0ongjDIZP0dlCC+l3yCEm69BsSlw7nwvVao9WaMBeFssnyN/AjjtEPzi4j8SzMOVeLDVVzUJiigqKDyDi2Kc0pivuJpF0KXVp8dyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b31HG0FG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HHxmrynG; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764144181; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W7KP68chQEuLWH2n5qZyVdXKe3/uANKnO802uMM6RRrETeDLe61vceRp44kIkGayl9
    GLk1VEaPDOaRh4oE42yifLT1R9teOmV7PNdFmjdoMVKw/wQEF2c5ZCStQce3nzI3AmR8
    oWFBz9nrWZ/KS/2lCgt+P0T1ZfR9ex2lwrlxyCoQQB0NH7OpuphVz2nxHm1v5iNZKcbq
    TYW8XXyYl25EuH1mJeHcZpr4Z8VFPwC3I8KVha00pewBnZCbeaRojo/gVCeNHSRao5BU
    ruO1jj3GenOF6prLgrYlwzrjOsFyk1VQcdm16kv/yAZZIH142K/lqjGsb2lhcb+MFbOV
    elsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764144181;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7BNW/7EtzxYQq4hLV+lpBsOhflrPFHU/a0NL8IIWH0=;
    b=AYx6kZYln1TzVNkMBeOuWtoEWfHqE5lK27zQaG0tFs5Xufl7UYtKMMT4k2HhpDN4fF
    myZrguAKsomNy0YEVFYeHmMZJ2dHekwEG2T16qjz7OMNZ4F7RQgoK39wIVG4MY4HJjOu
    7qDSRrMNeVigpqw28un9vuKK6Owbz3z9c619GK5KeoZlzW+i33qRCCPozUu5OX336/7R
    3L+6BR3h94mcebqxmOl1ZwBGvH7til65uVu/ZXYb6hwyGOB4BYfWSdPv9+EpS7nJnamy
    y3PDkGfPCEE3xUbMxO6npnTSE26uSqjfuPNb9t2pEJbtnMYlDZnV9GQ/tH6qqkXKst5f
    Z3zg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764144181;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7BNW/7EtzxYQq4hLV+lpBsOhflrPFHU/a0NL8IIWH0=;
    b=b31HG0FGhRC1ey3oxub+yprCUWTAVYX7Lz1t9WbrzoWsJG1yLopnAtyq9E2wOfvjLb
    nWdHWvpNtTSvf11XoOxAPlqsr+/Ky4F3HiR8yFVfmzhOdNq5ZdJ7RErqadgQxdYMTZFI
    xmQJX7ZsYR0TM78RS9o0vWW2+F7htcSYq16SXKsnr7zroUsGqI09YhxyClA9N/qj5F/L
    xMDTkpUf41S34dzutSzLsRWGOecJL8WuE2BJ4Z+lWqVYJQZw89ANToWSkVNjzzWXwvaA
    uY8jmD1ixsSRQ7Gx+IpxHrHchhhMlQX//Yd7aQYwODbw9YqjQH99Ada7M6UC74nVnJB5
    GMYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764144181;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7BNW/7EtzxYQq4hLV+lpBsOhflrPFHU/a0NL8IIWH0=;
    b=HHxmrynGfh/kvVtBXF7emxdlfrT1qkTo/a6JfN+UVxOyDnbTJscw/hI0n95JyW1GB0
    wti6l/cXid0zuLXtqtDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AQ830W1z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Nov 2025 09:03:00 +0100 (CET)
Message-ID: <9c9e9356-55c2-4ec0-9a0e-742a374e0d04@hartkopp.net>
Date: Wed, 26 Nov 2025 09:02:54 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/sched: em_canid: fix uninit-value in
 em_canid_match
To: ssrane_b23@ee.vjti.ac.in, Marc Kleine-Budde <mkl@pengutronix.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Rostislav Lisovy <lisovy@gmail.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 khalid@kernel.org, syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
References: <20251126070641.39532-1-ssranevjti@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251126070641.39532-1-ssranevjti@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Shaurya,

many thanks that you picked up this KMSAN issue!

On 26.11.25 08:06, ssrane_b23@ee.vjti.ac.in wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> Use pskb_may_pull() to ensure the CAN ID is accessible in the linear
> data buffer before reading it. A simple skb->len check is insufficient
> because it only verifies the total data length but does not guarantee
> the data is present in skb->data (it could be in fragments).
> 
> pskb_may_pull() both validates the length and pulls fragmented data
> into the linear buffer if necessary, making it safe to directly
> access skb->data.
> 
> Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
> Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> ---
> v2: Use pskb_may_pull() instead of skb->len check to properly
>      handle fragmented skbs (Eric Dumazet)
> ---
>   net/sched/em_canid.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index 5337bc462755..2214b548fab8 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
>   	int i;
>   	const struct can_filter *lp;
>   
> +	if (!pskb_may_pull(skb, sizeof(canid_t)))

The EM CANID handles struct CAN frames in skb->data.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/can.h#n221

The smallest type of CAN frame that can be properly handled with EM 
CANID is a Classical CAN frame which has a length of 16 bytes.

Therefore I would suggest

	if (!pskb_may_pull(skb, CAN_MTU))

instead of only checking for the first element in struct can_frame.

Many thanks and best regards,
Oliver


> +		return 0;
> +
>   	can_id = em_canid_get_id(skb);
>   
>   	if (can_id & CAN_EFF_FLAG) {


