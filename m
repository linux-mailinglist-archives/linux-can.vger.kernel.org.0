Return-Path: <linux-can+bounces-4697-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51690B57618
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 12:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F271AA22A4
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E52FB986;
	Mon, 15 Sep 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nF3u8lq4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6C2F90ED;
	Mon, 15 Sep 2025 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931417; cv=pass; b=PCsTIGvvUGoFCGywgwcWiA4WUm6Ic/qE0UBxRMrQyw8bOaMHBQnc2k8eVWFIhH2NBETSw06Rp+cZo02upjhADVTGfDF+CAITDzOaGIWJdWZh32zDVQ6JTceDP7dD2V/lq3+ViFTdMCWK7BoCPzx2ZZu8CqLBM2/p0c8r6m8WzTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931417; c=relaxed/simple;
	bh=hiS6CWWzzSZrfwhMY6sTSReXu6EATGI7A8Jq+9VOfdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMTyoSJilgzGJpDloUDA+FWqBdh2S57auBkN8a1pH5rdshV8VwPlIrEAsJCsB7eswA1CJ49NQWDCDotcmObo/tctKy5pZAvPysYDw4O92kz+d0EPV4LzFOBq1Kvp/5QJsjV30/vuAhegS2+kDh80sOOI6hv5e/4+qpNe6XAdtZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nF3u8lq4; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757931405; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mvX8m0ekeIojlHJw5I0KCOlLcZzw77UTNhK9yRf79RES9KCeGozlZHxyXjlXuYgqnV
    wOBctuwFnk79sP6TASthOKXUtHI/h0Xrt58yho26n+0otAGhwg3ms5PWMtR5RL22csae
    E78lWme+l/3cPH6RMpVANlSIWLb6RYGszHoj5IMgrfOE8DwgPSb4abp4BCCFRhDTruUa
    DMoseT/m+SdzQWZWKqMAYiJn3Z7RZrbj8j460e59CQRnFmBup9yCzk9kdw87E8qG6Nob
    6bQNQ46His72ee2foPknOCdw0tOKKfr4l675mce9kBEm/UcpyTV7WvaOGA6i59VO5ehU
    otsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757931405;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S1j67qi4cL/1MfbwQIlWd+x1A4aY80skvZvrPOAqL8w=;
    b=FH3qIDaFCVkYG6CQ6boG3jmWvPfXy44mEEq7OLhqwxkmzepZVaxRy1ywhOHiU8gbMK
    I7aREgIdF4D3NKP/S6KXoicABBmd/WqpBF/zrKqYOOMWytfWfFm44ItPs6i1TqjFsGi6
    BLH5FFfSsDp4ACuyUOKmH+X1hzCcneIu3P5pTKP2lhL50Fp10wXSos/rGOt0p3AUS8WI
    d5BYnXPWuqUy11QVGbh6KND7X21x6tcgGTEEuo9iLUL7Z96GIrRxttPoZAsXmhX1bWEM
    iSEIYwhWPcBZPoX/b9K9WakqTXi7mE2x7RwAubjAyKMpdXzLx//h/SnAqjkABHKUkB8T
    FCgg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757931405;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S1j67qi4cL/1MfbwQIlWd+x1A4aY80skvZvrPOAqL8w=;
    b=nF3u8lq4Sm/b1+ZQS9y2SJ90q+j4doRaovLXndlPBEr5vKn/8kluQVY6oMQl6vfgSe
    NTonUefUG5Gg6P/WRIx4uPHq0ZIxSFRWWP4eOtRry5pT2HnrmYhFQ8/qxcrvHl5YuDry
    jV49dolnB5um/aq1qWHN0ET2ZcMa0hf8euiySaCBenrC99rit0QAiNtHKieV/2odAu25
    TftfOjk8+YMPxubwBNnS1SCKqRlPEhEWbEQn80xYDoxgz1nQXxlSSu3MZ3j1rCGyH/Of
    c6gO8JXiVc9a/gkrfgUanx2ZKRE8wlCDSO2eMV5e2Ik1i7dUq05oN4QIbPvItrnL293I
    rf5w==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5owMnk64sm8VF6OpcIrgdno+M3mNGEGSIofQp0UJwtSeLY="
Received: from [IPV6:2a02:b98:8b0e:d800:856:bd03:6d59:abd2]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218FAGj0mn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 15 Sep 2025 12:16:45 +0200 (CEST)
Message-ID: <f96cd163-0364-4c14-882b-48c3f8e0f05a@hartkopp.net>
Date: Mon, 15 Sep 2025 12:16:40 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.09.25 11:23, Vincent Mailhol wrote:
> The loopback, recv_own_msgs, fd_frames and xl_frames fields of struct
> raw_sock just need to store one bit of information.
> 
> Declare all those members as a bitfields of type unsigned int and
> width one bit.
> 
> Add a temporary variable to raw_setsockopt() and raw_getsockopt() to
> make the conversion between the stored bits and the socket interface.
> 
> This reduces struct raw_sock by eight bytes.
> 
> Statistics before:
> 
>    $ pahole --class_name=raw_sock net/can/raw.o
>    struct raw_sock {
>    	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */
> 
>    	/* XXX last struct has 1 bit hole */
> 
>    	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>    	int                        bound;                /*   776     4 */
>    	int                        ifindex;              /*   780     4 */
>    	struct net_device *        dev;                  /*   784     8 */
>    	netdevice_tracker          dev_tracker;          /*   792     0 */
>    	struct list_head           notifier;             /*   792    16 */
>    	int                        loopback;             /*   808     4 */
>    	int                        recv_own_msgs;        /*   812     4 */
>    	int                        fd_frames;            /*   816     4 */
>    	int                        xl_frames;            /*   820     4 */
>    	struct can_raw_vcid_options raw_vcid_opts;       /*   824     4 */
>    	canid_t                    tx_vcid_shifted;      /*   828     4 */
>    	/* --- cacheline 13 boundary (832 bytes) --- */
>    	canid_t                    rx_vcid_shifted;      /*   832     4 */
>    	canid_t                    rx_vcid_mask_shifted; /*   836     4 */
>    	int                        join_filters;         /*   840     4 */
>    	int                        count;                /*   844     4 */
>    	struct can_filter          dfilter;              /*   848     8 */
>    	struct can_filter *        filter;               /*   856     8 */
>    	can_err_mask_t             err_mask;             /*   864     4 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	struct uniqframe *         uniq;                 /*   872     8 */
> 
>    	/* size: 880, cachelines: 14, members: 20 */
>    	/* sum members: 876, holes: 1, sum holes: 4 */
>    	/* member types with bit holes: 1, total: 1 */
>    	/* forced alignments: 1 */
>    	/* last cacheline: 48 bytes */
>    } __attribute__((__aligned__(8)));
> 
> ...and after:
> 
>    $ pahole --class_name=raw_sock net/can/raw.o
>    struct raw_sock {
>    	struct sock                sk __attribute__((__aligned__(8))); /*     0   776 */
> 
>    	/* XXX last struct has 1 bit hole */
> 
>    	/* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>    	int                        bound;                /*   776     4 */
>    	int                        ifindex;              /*   780     4 */
>    	struct net_device *        dev;                  /*   784     8 */
>    	netdevice_tracker          dev_tracker;          /*   792     0 */
>    	struct list_head           notifier;             /*   792    16 */
>    	unsigned int               loopback:1;           /*   808: 0  4 */
>    	unsigned int               recv_own_msgs:1;      /*   808: 1  4 */
>    	unsigned int               fd_frames:1;          /*   808: 2  4 */
>    	unsigned int               xl_frames:1;          /*   808: 3  4 */

This means that the former data structures (int) are not copied but bits 
are set (shifted, ANDed, ORed, etc) right?

So what's the difference in the code the CPU has to process for this 
improvement? Is implementing this bitmap more efficient or similar to 
copy the (unsigned ints) as-is?

> 
>    	/* XXX 4 bits hole, try to pack */
>    	/* Bitfield combined with next fields */
> 
>    	struct can_raw_vcid_options raw_vcid_opts;       /*   809     4 */
> 
>    	/* XXX 3 bytes hole, try to pack */
> 
>    	canid_t                    tx_vcid_shifted;      /*   816     4 */
>    	canid_t                    rx_vcid_shifted;      /*   820     4 */
>    	canid_t                    rx_vcid_mask_shifted; /*   824     4 */
>    	int                        join_filters;         /*   828     4 */
>    	/* --- cacheline 13 boundary (832 bytes) --- */
>    	int                        count;                /*   832     4 */
>    	struct can_filter          dfilter;              /*   836     8 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	struct can_filter *        filter;               /*   848     8 */
>    	can_err_mask_t             err_mask;             /*   856     4 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	struct uniqframe *         uniq;                 /*   864     8 */
> 
>    	/* size: 872, cachelines: 14, members: 20 */
>    	/* sum members: 860, holes: 3, sum holes: 11 */
>    	/* sum bitfield members: 4 bits, bit holes: 1, sum bit holes: 4 bits */
>    	/* member types with bit holes: 1, total: 1 */
>    	/* forced alignments: 1 */
>    	/* last cacheline: 40 bytes */
>    } __attribute__((__aligned__(8)));
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   net/can/raw.c | 47 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index db21d8a8c54d1b6a25a72c7a9d11d5c94f3187b5..cec580ecd58e36931d1be05716e6beb9c93aa271 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -87,10 +87,10 @@ struct raw_sock {
>   	struct net_device *dev;
>   	netdevice_tracker dev_tracker;
>   	struct list_head notifier;
> -	int loopback;
> -	int recv_own_msgs;
> -	int fd_frames;
> -	int xl_frames;
> +	unsigned int loopback:1;
> +	unsigned int recv_own_msgs:1;
> +	unsigned int fd_frames:1;
> +	unsigned int xl_frames:1;
>   	struct can_raw_vcid_options raw_vcid_opts;
>   	canid_t tx_vcid_shifted;
>   	canid_t rx_vcid_shifted;
> @@ -560,8 +560,8 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   	struct can_filter sfilter;         /* single filter */
>   	struct net_device *dev = NULL;
>   	can_err_mask_t err_mask = 0;
> -	int fd_frames;
>   	int count = 0;
> +	int flag;
>   	int err = 0;
>   
>   	if (level != SOL_CAN_RAW)
> @@ -682,44 +682,48 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   		break;
>   
>   	case CAN_RAW_LOOPBACK:
> -		if (optlen != sizeof(ro->loopback))
> +		if (optlen != sizeof(flag))
>   			return -EINVAL;
>   
> -		if (copy_from_sockptr(&ro->loopback, optval, optlen))
> +		if (copy_from_sockptr(&flag, optval, optlen))
>   			return -EFAULT;
>   
> +		ro->loopback = !!flag;

This is obviously an additional effort. Instead it a simple copy the 
code makes a copy to an extra variable and then an assignment with bit 
(shifting) operations.

Best regards,
Oliver

>   		break;
>   
>   	case CAN_RAW_RECV_OWN_MSGS:
> -		if (optlen != sizeof(ro->recv_own_msgs))
> +		if (optlen != sizeof(flag))
>   			return -EINVAL;
>   
> -		if (copy_from_sockptr(&ro->recv_own_msgs, optval, optlen))
> +		if (copy_from_sockptr(&flag, optval, optlen))
>   			return -EFAULT;
>   
> +		ro->recv_own_msgs = !!flag;
>   		break;
>   
>   	case CAN_RAW_FD_FRAMES:
> -		if (optlen != sizeof(fd_frames))
> +		if (optlen != sizeof(flag))
>   			return -EINVAL;
>   
> -		if (copy_from_sockptr(&fd_frames, optval, optlen))
> +		if (copy_from_sockptr(&flag, optval, optlen))
>   			return -EFAULT;
>   
>   		/* Enabling CAN XL includes CAN FD */
> -		if (ro->xl_frames && !fd_frames)
> +		if (ro->xl_frames && !flag)
>   			return -EINVAL;
>   
> -		ro->fd_frames = fd_frames;
> +		ro->fd_frames = !!flag;
>   		break;
>   
>   	case CAN_RAW_XL_FRAMES:
> -		if (optlen != sizeof(ro->xl_frames))
> +		if (optlen != sizeof(flag))
>   			return -EINVAL;
>   
> -		if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
> +		if (copy_from_sockptr(&flag, optval, optlen))
>   			return -EFAULT;
>   
> +		ro->xl_frames = !!flag;
> +
>   		/* Enabling CAN XL includes CAN FD */
>   		if (ro->xl_frames)
>   			ro->fd_frames = ro->xl_frames;
> @@ -758,6 +762,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   {
>   	struct sock *sk = sock->sk;
>   	struct raw_sock *ro = raw_sk(sk);
> +	int flag;
>   	int len;
>   	void *val;
>   
> @@ -806,25 +811,29 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   	case CAN_RAW_LOOPBACK:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
> -		val = &ro->loopback;
> +		flag = ro->loopback;
> +		val = &flag;
>   		break;
>   
>   	case CAN_RAW_RECV_OWN_MSGS:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
> -		val = &ro->recv_own_msgs;
> +		flag = ro->recv_own_msgs;
> +		val = &flag;
>   		break;
>   
>   	case CAN_RAW_FD_FRAMES:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
> -		val = &ro->fd_frames;
> +		flag = ro->fd_frames;
> +		val = &flag;
>   		break;
>   
>   	case CAN_RAW_XL_FRAMES:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
> -		val = &ro->xl_frames;
> +		flag = ro->xl_frames;
> +		val = &flag;
>   		break;
>   
>   	case CAN_RAW_XL_VCID_OPTS: {
> 


