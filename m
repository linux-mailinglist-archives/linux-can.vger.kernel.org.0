Return-Path: <linux-can+bounces-4508-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52171B4880C
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 11:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFA77A4289
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222E224247;
	Mon,  8 Sep 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nUq5X9+L";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8thKdMwN"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500372F0C6E
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322873; cv=pass; b=Ssi0NmuEGCHYQU1RsMQWTsLjPgZtvSfThPUh0X6e3yyOCqsmaO+V1zdlDuANYd/674r/rDtFkTVOmhOdRUnMKpocRZn9uxqKnLAXq1OB5h/DCvknq1PXWlkuoXpCKEHNSQbyJhTItpAmXCjnSgIe57b9xO2QmSUs1SB+vZA699M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322873; c=relaxed/simple;
	bh=zcfbD0S/TclBh+KhU2hAhTs/X6C86g5BPU/o+xA6VcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LIdeCmEuk8rI0XOPcIRKg2YXD6qpC/ClzS1budxmL8B+JANrSEGSUvse7ETtS/ou84Qw5jX8dmKZ3QRpy20Sqn1noYq1yI7GkoWPB6argaXx977R/22TiQN5QckQPPbXWjmXaiid+ZMyWMRyi52ggRGIYasckrg/3Bmux+mtM8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nUq5X9+L; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8thKdMwN; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757322508; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ICS3jv3gYY333Gpa9/h2CYQFGLDE0Onp/4o/wUKP57rIqXBRrXXufA7ZnmWu5N3ZjU
    wUI8R5GGXnv8Iu5VX5JIZMllEmYwIR9AVsKAPBsugPaiOCAVph5BQ4DcyaR7L80/AkkY
    tZH3Sunfydxjw0vrOmtQkhuowZ9y/ymUmZlxkbt6VPZp6cFd2RpTmNIRrB7LJPZHm0ZU
    hK/YVtpAM90SFWZqg0U9zErrQwA3AkeR9JIXBlLgwmrzxfb0bl8x4EYXtq5gDP7ikos+
    WXqFeyh9pFafy+LNXSHKUC+Avwj3keJpD6HgD/JSwe3vEA915aUhz05meDN/Z6tfn9/0
    zJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757322508;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=SIuQBYpTuE0ts2x201vbljPeMhIZV997G69gzVqwu/o=;
    b=Lgf9d488HAFyIopXILjw/wwXz8XfESXYJDFWCcw+gU8u4GfUCe5TLllffHZbDlQluu
    nsQMgW6IrGsGk9UYL2Xbm+bv7j5Qyg76mHuQnptoSgveXte0ro3jmrHSHLvbokNpCEnZ
    AXB53yrG6j7msukq+lqfrNdESn2No3l/xikmPl6YyG5E22PubiROJGb9wxq3Zi4gK8qY
    3KsV9WTDKdXbAhXrt9H7XwUlo/JXaJjPUxcIIjHR0I3oVVm7UXb7aD1s40WDmGfayRPk
    jLtyXGw5WDzyEKohOTcUPZl91eTl5MbyyWszTfxvFJaafwNZJjLC5AjP1T+qXzwt0s/Y
    pPmA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757322508;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=SIuQBYpTuE0ts2x201vbljPeMhIZV997G69gzVqwu/o=;
    b=nUq5X9+LByzEV7r+VMaKRqGT13XdyEqObiCVFTmnrJYg7h0w5p4ycDHpqstcpxLqHo
    1BnEybN+En1b8lDhIzRRqb+d5L5DVo70sy2JrDTpykbSEEGNpeQ06J/I26Gs1V1QARMR
    9mF2OKj49LlcsxOhdDDClVUQhbg2z3kfrDUIDCaWiKpwVX1wIKyi8x4ceM9KObhgWUpW
    KIRZmCkvwaN0NdRgpqxvVW0kxmRRX+vTpiAwLOi+87W/VcbRFU6oP+8YFhDxJ8rzrbnu
    mn+gBhilHYp8NB/MWqb8mMpXGdGVU+/EuychN661kY7zNKwu92FB6ic5I024sROmXI67
    1D0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757322508;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=SIuQBYpTuE0ts2x201vbljPeMhIZV997G69gzVqwu/o=;
    b=8thKdMwNHl6Og2r27kb+xWYfsuvK8mrLmg9o95HHkyD4zeHhrUJcDLxFqrgtPVgyuT
    s+GzhzsOLnGRl3yh9OCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118898SY7U
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <linux-can@vger.kernel.org>;
    Mon, 8 Sep 2025 11:08:28 +0200 (CEST)
Message-ID: <8efb798c-d5d1-4eda-9077-76f22450fb42@hartkopp.net>
Date: Mon, 8 Sep 2025 11:08:28 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] can: skb: enforce CANFD_FDF check in
 can_is_canfd_skb()
To: linux-can@vger.kernel.org
References: <20250908083041.1723-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250908083041.1723-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08.09.25 10:30, Oliver Hartkopp wrote:
> The check in can_is_canfd_skb() is about a length check of skb->len and
> the CAN FD data length. As a skb length of CANFD_MTU can potentially be
> created with a CAN XL frame with a data length of 52,

No. It's the length of 60 + the CANXL_HDR_SIZE (12) which becomes the 
CANFD_MTU (72).

Just sent a v2 patch.

Best regards,
Oliver

  the length check of
> the CAN FD data length is used to detect CAN XL frames via its CANXL_XLF
> flag which exceeds valid CAN FD data length values.
> 
> To make sure the CANFD_FDF flag can be safely used as a marker for CAN FD
> frame skbs the bit was set in can_send() and is now also set in
> raw_check_txframe() to re-use the indroduced can_is_canfd_skb_set_fdf()
> function. In the RX path alloc_canfd_skb() sets the CANFD_FDF flag.
> 
> The enforced CANFD_FDF check in can_is_canfd_skb() clears up the potential
> uncertainty when using the skb->len check with the CANFD_MTU.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   include/linux/can/skb.h | 25 +++++++++++++++++++++++--
>   net/can/af_can.c        |  7 +------
>   net/can/raw.c           |  2 +-
>   3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 1abc25a8d144..38d036b43280 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -111,12 +111,33 @@ static inline bool can_is_can_skb(const struct sk_buff *skb)
>   
>   static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>   {
>   	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>   
> -	/* the CAN specific type of skb is identified by its data length */
> -	return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
> +	if (skb->len != CANFD_MTU || cfd->len > CANFD_MAX_DLEN)
> +		return false;
> +
> +	return cfd->flags & CANFD_FDF;
> +}
> +
> +static inline bool can_is_canfd_skb_set_fdf(const struct sk_buff *skb)
> +{
> +	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> +
> +	/* The CAN specific type of skb is identified by its data length.
> +	 * A CAN XL frame skb might have a skb->len of CANFD_MTU but the
> +	 * skb would have the CANXL_XLF bit set (0x80 = 128) in the
> +	 * cfd->len field position which would intentionally break the
> +	 * CAN FD length check here. So we can surely tag it as CAN FD.
> +	 */
> +	if (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN) {
> +		/* set CAN FD flag for CAN FD frames by default */
> +		cfd->flags |= CANFD_FDF;
> +		return true;
> +	}
> +
> +	return false;
>   }
>   
>   static inline bool can_is_canxl_skb(const struct sk_buff *skb)
>   {
>   	const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index b2387a46794a..0caf75a9e27f 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -207,17 +207,12 @@ int can_send(struct sk_buff *skb, int loop)
>   
>   	if (can_is_canxl_skb(skb)) {
>   		skb->protocol = htons(ETH_P_CANXL);
>   	} else if (can_is_can_skb(skb)) {
>   		skb->protocol = htons(ETH_P_CAN);
> -	} else if (can_is_canfd_skb(skb)) {
> -		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> -
> +	} else if (can_is_canfd_skb_set_fdf(skb)) {
>   		skb->protocol = htons(ETH_P_CANFD);
> -
> -		/* set CAN FD flag for CAN FD frames by default */
> -		cfd->flags |= CANFD_FDF;
>   	} else {
>   		goto inval_skb;
>   	}
>   
>   	/* Make sure the CAN frame can pass the selected CAN netdevice. */
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 76b867d21def..f48b1f3fd6e8 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -886,11 +886,11 @@ static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
>   	/* Classical CAN -> no checks for flags and device capabilities */
>   	if (can_is_can_skb(skb))
>   		return CAN_MTU;
>   
>   	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> -	if (ro->fd_frames && can_is_canfd_skb(skb) &&
> +	if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
>   	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>   		return CANFD_MTU;
>   
>   	/* CAN XL -> needs to be enabled and a CAN XL device */
>   	if (ro->xl_frames && can_is_canxl_skb(skb) &&


