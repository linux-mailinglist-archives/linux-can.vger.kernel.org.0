Return-Path: <linux-can+bounces-4582-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FCB502DA
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 18:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13605E3024
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532EE322536;
	Tue,  9 Sep 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YEx1JCsV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IaGNk5vk"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D7345756
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435992; cv=pass; b=InjW88vi3qBnR1aEeWK0/RRHvS0Hqwikpzk6dLnv0AWUCg9RhuTlHk+WtBQ9MqiJlkektxFDm8u73I23KeYj0mfnQDaEYlHdytco51cj1s3qjtiXPJ1ze1ZxCcFAUF/KQg04fvv3YFAQCslucFoylUjpJLESUvMIovDKCOJyNFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435992; c=relaxed/simple;
	bh=QzNPFhyXxSNEgfmR8N/4u1POLT6A0Fll+FYfbI4koAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=maCJrFkVaNCol0OqoUWDVDnBwrZ1lFWhCgtjqDzreiHRyxw8oRCNm8kyS/NF72CG0DYKlnSLrSlcv6S4ooz3UZHOqZ+2UGckpDaHDn7sPMyhejfL0X6nl7vdFrjR1AI10dUf/e7DtxDE/BfDkQGgwbiKYeK3zVVwLHD/NMJbiBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YEx1JCsV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IaGNk5vk; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757435798; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MySWR1oJR6X78l2NJAHMVRvVQjae1q9LPcgYAO5YsD7ARnIsI/a0H2pQulKLCO0QLt
    4Bw3nKSjnyazR2TcBspoaQCZHd3V0EAWyXAnOuGvhfeSZWF0MtU554aH88nAmo+iDmWN
    hqhj5p2WxSX9SbrNfz9gQe4+wYvMJyQ9Z1YijI3UVCw9KaW+EiMfJVSO9Mhv2H1He3PV
    0etZR4WW8D5FmE0Oj2GPubxcAqbDXCNXALexxppLtchQKpShXsjkY8optb6rhxGD3jmI
    3ekhUH7j5uJDwxqTrayGT2hjosgD2IYh6ZbdCLO2BScU5lj2w2W3kuimCyyRHEWOyzMJ
    RHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757435798;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=3hT0Nr8fUpTI+H/PAGBABGdugP4gHbFd4vDgSv3KUSc=;
    b=nNqbkhUJSYT90Pr7mbHsDjhYcib1f96WvIvkPVgXV86gMXZMARXmICjFxJVbGpDv/S
    c6VseyiIUa4XZQ+tSp2R7+aRkcyndOfshG19FbDnKNee0bcukpoOCDsjtJ1e2OYcZR/v
    HMFzui54PY9yaOSR8SFR46p8SFHnLlR4Ens7i1hWnmv78BNnngeaUSqHdOLwEDAAOH/F
    0Bh9NI20XzJ7zw54p2afzpsQrEHmd8vc8wfv84Cnh6ebg5mW4DLoZkyCgPB15nI8KcfC
    35Ra4Bx0m1nQ4SxTYKfBOy3UaxVzwYNmpGwPXoS6A8XgBQmYWE24xP0nyWGBAgTMDYnL
    /WqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757435798;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=3hT0Nr8fUpTI+H/PAGBABGdugP4gHbFd4vDgSv3KUSc=;
    b=YEx1JCsVwGnURb5faM0IK2Erdk7nXLTNwRWmeZ9JonRqz/CRecWnYVL0SUBKUoQkOs
    2iZvwi8ay+LLX/GQ65PYA8af/S5adtizgljYrlme57bcF6g24vPi9/DDYNdz2AbMaDy0
    CE7FFPWZb3dLSf5xViATkQ3hooaxE7DQDYt8Xf4GhjKFpJ0sj4RmX5XgsDWefDt48Z4F
    8nMdC5MAEq7MgAeQWkdgqdqxUciSo2wFa+Wo3Q1eC8/+bD3z28ovsCGe0OzuWB/YkCph
    RqiPyJnMjYknX6YTxTBODX11v54BC6hEVGNRw28kXRV528ZZHUHE1f4Qol/umJrYpLzT
    CXVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757435798;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=3hT0Nr8fUpTI+H/PAGBABGdugP4gHbFd4vDgSv3KUSc=;
    b=IaGNk5vkHtXrYX4p3ukNbcZVoaSRI7NK4hSRBBMbL1ayFpBfymAB+YPmyitF4D2e62
    I/qc4q30gZeFFSCeF0Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d361189GachPI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 18:36:38 +0200 (CEST)
Message-ID: <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
Date: Tue, 9 Sep 2025 18:36:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250909092433.30546-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 09.09.25 11:24, Oliver Hartkopp wrote:


> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
> +				      struct net_device *dev)
>   {
>   	/* Classical CAN -> no checks for flags and device capabilities */
>   	if (can_is_can_skb(skb))
>   		return CAN_MTU;
>   
> -	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> -	if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
> -	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> -		return CANFD_MTU;
> +	/* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
> +	if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb)) {
> +		/* real/virtual CAN FD interface */
> +		if (dev->mtu == CANFD_MTU)
> +			return CANFD_MTU;
> +		if (can_is_canxl_dev_mtu(dev->mtu) &&
> +		    can_dev_ctrlmode_fd_on(dev))
> +			return CANFD_MTU;
> +	}

I've simplified the above code and rewrote the commit message in v6

>   	/* CAN XL -> needs to be enabled and a CAN XL device */
>   	if (ro->xl_frames && can_is_canxl_skb(skb) &&
> -	    can_is_canxl_dev_mtu(mtu))
> +	    can_is_canxl_dev_mtu(dev->mtu))
>   		return CANXL_MTU;

We might also discuss if we create a can_dev_ctrlmode_xl_on(dev) 
function to check if the CAN XL interface has CAN_CTRLMODE_XL enabled.

Currently my patches are based on Linus' rc5 tree where CAN_CTRLMODE_XL 
is not defined. But I can rebase it on your b4/canxl-netlink branch if 
you like it.

Best regards,
Oliver



