Return-Path: <linux-can+bounces-4707-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E88B583E0
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 19:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B9E488272
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180C28C864;
	Mon, 15 Sep 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="P3YZlvx3"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420029BDBA;
	Mon, 15 Sep 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958161; cv=pass; b=cn9RWMNNsvQ3urAMAvcgwYXgt6coUQM+thQIddjEATqi5vDrHmAf4IHocDg5Ft1r9+gQwgW3r7NIosOPBL/PMP706u0JLGiAygv7c1ENlB963Of8GYi8qPQ8rNKakPl5QxTCJ3OH/tUPyE0ap1/WtzTEW6Yuv+CesS6CGKW40MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958161; c=relaxed/simple;
	bh=/YXkyLfQYooRkfkd+z3QYbBkkRVFXvAmC53IuRna/f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=medm61RZ+UAI8gfmtPWGuF2E74VgL40687y9XqorQ9zdsp6tuIHLdf6O0ArNSylXAxDmc7vmg5UGte3qYp93neQP8eVuYvRfj8CtXXc8gLQx8IyXLjO1NWHngrbhj5IxU4cN4gBWid7nsEC1xGFnug5nV50A6Kqz1DBvDfApraQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=P3YZlvx3; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757958150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VIby8CWK1JytTADuungZnrTID6gSxo9K2w4chYMTtFBwKvOHJ2Z5tFHKXpz9vFFOv2
    iHog9HuI47wkO5bQpXvJ8IA/+vXGuxg+0i85eVOH9q1PXVWsdkmH9rzz8ALy+7sFDOhM
    W2+1ObYuzRNa7pw2IhHNNppXCM5cYhuABXTSj47hZ7dBSpzqFmYkN49YBoBraSGp1HxA
    r4SyJM6aTB1LFCATvLlbsrSLXMQEOjwUbBpJxdL63OZwkRv03G1YdYv2ukBRBmYzzobX
    7T/rBomWjXrPhzD74bcDQTsuRp9zuVcpLO7cBZTke0TFnCpVIpmsNx/krYAgUTiZi3ZU
    HDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757958150;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=u4pLkNW9cBOx+9k0ETH+QYi5IExjHMgMxuUfJnQO428=;
    b=XBin0BJpOVkIcauC0rsiEK1dByz3PurkJgUScW53dh0fh/Y4BqCDhQnmLwAVEOeLbd
    KBVZVnq3r5s5vSlCxetO86Ig9xgl31x/PtNLWpzasJ/Irw+Lc/u3j9YVVFUsj+EdT0Vl
    QS7HwFQTApvURHZ3ykoRpTG+MGGHBwZurIvvWsSYEdo6kE8QAjGqsZvPGG+riOynxvxK
    jyF5UMo4Kh3AxLKEskya/i/LdQUGjKgcJctczwnpyYKw+Paybx8nMPJPvIPIx1SA+WOd
    IOiHiI2LAnjPMNpdTbg3izhLYXPSY2EQiLJXy5rNVMYQ5X/RbWbKJoGXFnxoPCyqS0Ry
    W52A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757958150;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=u4pLkNW9cBOx+9k0ETH+QYi5IExjHMgMxuUfJnQO428=;
    b=P3YZlvx3slsuLbgyE8+ZZWo4I/4Mx4+6iL0LI2/uZrqEzm+TkoE1PZ3n2oCiu42YWB
    /Nh4acjAzZ+EjYQ98BIyWunrIWmNGBK+0WLSH82wbSVNZbgdHyTQi1yLhzcoxS3UEbp3
    c44ewfwemZX19pdp0ftQ0RzzuGS8nGydPBAcms4skrzzE5CT6SFwENWobrmwjxn8UQot
    agkm//lq0//RI3U07Z67nnOaj26D8BWgz7w0OBYvczr+0uHXWEkb/Z6uPvx1PVdC6WSe
    F/5jeBARoj596WNL32Xl5MtGRXLg4yInlmIzeJxDRtF3Q2kHqHQS3PID9nX8KOC74Y4v
    V36g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5owMnk64sm8VF6OpcIrgdno+M3mNGEGSIofQp0UJwtSeLY="
Received: from [IPV6:2a02:b98:8b0e:d800:856:bd03:6d59:abd2]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218FHgU2xc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 15 Sep 2025 19:42:30 +0200 (CEST)
Message-ID: <7c8ec848-4a78-4015-b7ff-9067c1fd3bba@hartkopp.net>
Date: Mon, 15 Sep 2025 19:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: raw: reorder struct raw_sock's members to
 optimise packing
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-3-5ea293bc6d33@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250915-can-raw-repack-v1-3-5ea293bc6d33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.09.25 11:23, Vincent Mailhol wrote:
> struct raw_sock has several holes. Reorder the fields to save 8 bytes.
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
>    	unsigned int               loopback:1;           /*   808: 0  4 */
>    	unsigned int               recv_own_msgs:1;      /*   808: 1  4 */
>    	unsigned int               fd_frames:1;          /*   808: 2  4 */
>    	unsigned int               xl_frames:1;          /*   808: 3  4 */
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
>    	struct can_raw_vcid_options raw_vcid_opts;       /*   808     4 */
>    	unsigned int               loopback:1;           /*   812: 0  4 */
>    	unsigned int               recv_own_msgs:1;      /*   812: 1  4 */
>    	unsigned int               fd_frames:1;          /*   812: 2  4 */
>    	unsigned int               xl_frames:1;          /*   812: 3  4 */
> 
>    	/* XXX 28 bits hole, try to pack */
> 
>    	canid_t                    tx_vcid_shifted;      /*   816     4 */
>    	canid_t                    rx_vcid_shifted;      /*   820     4 */
>    	canid_t                    rx_vcid_mask_shifted; /*   824     4 */
>    	can_err_mask_t             err_mask;             /*   828     4 */
>    	/* --- cacheline 13 boundary (832 bytes) --- */
>    	int                        join_filters;         /*   832     4 */
>    	int                        count;                /*   836     4 */
>    	struct can_filter          dfilter;              /*   840     8 */
>    	struct can_filter *        filter;               /*   848     8 */
>    	struct uniqframe *         uniq;                 /*   856     8 */
> 
>    	/* size: 864, cachelines: 14, members: 20 */
>    	/* sum members: 860 */
>    	/* sum bitfield members: 4 bits, bit holes: 1, sum bit holes: 28 bits */
>    	/* member types with bit holes: 1, total: 1 */
>    	/* forced alignments: 1 */
>    	/* last cacheline: 32 bytes */
>    } __attribute__((__aligned__(8)));
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/raw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cec580ecd58e36931d1be05716e6beb9c93aa271..81f5de63bcfaacf3f51670159fb3d1d7d1fc6020 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -87,19 +87,19 @@ struct raw_sock {
>   	struct net_device *dev;
>   	netdevice_tracker dev_tracker;
>   	struct list_head notifier;
> +	struct can_raw_vcid_options raw_vcid_opts;
>   	unsigned int loopback:1;
>   	unsigned int recv_own_msgs:1;
>   	unsigned int fd_frames:1;
>   	unsigned int xl_frames:1;
> -	struct can_raw_vcid_options raw_vcid_opts;
>   	canid_t tx_vcid_shifted;
>   	canid_t rx_vcid_shifted;
>   	canid_t rx_vcid_mask_shifted;
> +	can_err_mask_t err_mask;
>   	int join_filters;
>   	int count;                 /* number of active filters */
>   	struct can_filter dfilter; /* default/single filter */
>   	struct can_filter *filter; /* pointer to filter(s) */
> -	can_err_mask_t err_mask;
>   	struct uniqframe __percpu *uniq;
>   };
>   
> 


