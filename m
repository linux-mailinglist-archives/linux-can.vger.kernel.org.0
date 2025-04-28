Return-Path: <linux-can+bounces-3500-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3703A9FAA4
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220CD5A6A6A
	for <lists+linux-can@lfdr.de>; Mon, 28 Apr 2025 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457A1EE7B7;
	Mon, 28 Apr 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FSvWZ5pL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7g/5IHS0"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E401A8F7F
	for <linux-can@vger.kernel.org>; Mon, 28 Apr 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872199; cv=pass; b=iwilqgpLH6O5ojWCFh8a21lLBBFSrWN8o1aek/8b4rqO5p4eDRRqebG4xE6B4Vu3aSGzFQwyHyWfmEkZO0QO3fcCqeGDLwyTj2tKah4ZU5PKH4eKV2sVftgUF+ASJrbuET6xnDyjC6MithzRbM+pdi7jc7Du1l5pH5UwI1IcIig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872199; c=relaxed/simple;
	bh=efhMR4+DJ+ZqSckYTwlOCTLIUgzZFmRFNyk3QlW06wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCsjJKrsKUe+rG8ODtqx+DI3zcANsUzhdbteN1BPksp9Ve1Q92oVJqgW6B5EEqJDBhXCaQCC/p7mGFsGHP4dWsyHqmHQ87hqgqWGZZQBikt2ITQEjq8jflLXummAPNGzzG5j5adeVwZtHY22w/jCVT61LarEKr7r4HuceOe7d2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FSvWZ5pL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7g/5IHS0; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1745871108; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GKc/44CdTL3rVZaUWUxrK+d+b6Lbb5FDynzbrUzmTFiyPvlhkR5FYMAUJtjv5o2Jmi
    26MIrXrVuf+wblThakQrr9vxOXqbp99L0fw+oRDdu6IDEIHwHi3XLJYEjNHf925NPJ6w
    1LppyyaRhETZzaDfU/ENCI/3UIkjchhmA9J3TN++IBjlS6ansQDLkGnj3gO3Wxlw10bE
    f2pNRcDMlB8jI8pHUZ4LcB2IgoMBlOR3paHYr0fBV/TygTmXjlCqANp/ag/UP75TJY+/
    jNR3uUEoPgydmQK6apwCQ8GBoDP+AkxCBITYpd4O8vZtsJfzjMRhlot9GstjqgXAkeq3
    idVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1745871108;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dIJpYypGyNaYQc2+fjQRm++1cAprDgWsZzoIykTPVLY=;
    b=hGwRVSHvnzWNsRh7OpQPwBc9/PHZjZVMqbV46YZjkg7v7OwyCi0VWaaRc0ptbew9tP
    hvnMyMP1z5woK/iNpGKHoySawRkxtAUmjYQ9RNcs6DqGpVpK3curWQXQJ4CRPSZvrpW+
    ofzKRdnbiwd9GQmIQz2MGSQjb+XcsOU8f8EYVeV+DcL/VrXrv1AizoqCwRCZ1AaX8jjc
    7WOKT5SZnW2jcFVYQ1R/44vOekpbzB/31Lrp349BSJCtANUkVzLJbH5lcc4QpqdiSspf
    cVBOFLsi5Gxr/ryFBIXB4qvnWoc9WedDUIqDFp3hLg6vSPi93okc6cIk5YfBcJgMs36a
    ljOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1745871108;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dIJpYypGyNaYQc2+fjQRm++1cAprDgWsZzoIykTPVLY=;
    b=FSvWZ5pLdQh022zjugHu/deBITYeoPEeZoCn4Zntm+ih6eTkpmIv8mj8Dn+x/k6CIW
    RjOAGAlbVkjpHL/9Gf2jgceKpYz6VOi9AX0SGfPKHtp++Uv8AlaG06S/H2tpXQ56UrSC
    q6INu3ZIAEKJ9Mwiba6RWjeavHbKNtdt+1pIiDxL3goExJkg1Vgst9oSYYLXZWz681Vy
    pv1S6SQI/0TMICsqJUOUEGLt8Lkhsm4JkwiO6Usjad1wemUkeekTf0F8wnjIwctg7Xkj
    z2EXDE+h+/2L768XuxaSwigtRReD3rvD0NcO/EESctoOdR2XqerCF/LcGfscX9x8Ml0p
    XCLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1745871108;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dIJpYypGyNaYQc2+fjQRm++1cAprDgWsZzoIykTPVLY=;
    b=7g/5IHS0FbWuG31aBjhJFo+kUEadhizX+8V678Skgng04Ba7Vt2nkGrkMRlRHuiy+t
    WjwM7NB2iOcjSAocrLBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e513SKBmKmG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Apr 2025 22:11:48 +0200 (CEST)
Message-ID: <f7551463-1fe4-41e6-bd7c-1b99111a7e46@hartkopp.net>
Date: Mon, 28 Apr 2025 22:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: gw: fix RCU/BH usage in cgw_create_job()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-can@vger.kernel.org, tglx@linutronix.de,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250417144122.LVyWdXXO@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250417144122.LVyWdXXO@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

thanks for your interesting work!

I have one comment/question inline ...

On 17.04.25 16:41, Sebastian Andrzej Siewior wrote:

>   	err = cgw_register_filter(net, gwj);
> -	if (!err)
> +	if (!err) {
>   		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
> +		mod = NULL;

I assume this assignment prevents to kfree() the assigned mod data some 
lines below, right?

If so there should be a comment why this assignment was made.

> +	}
>   out:
>   	if (err)
>   		kmem_cache_free(cgw_cache, gwj);
> -
> +out_free_cf:
> +	kfree(mod);  <<<<<<<<<< HERE <<<<<<<<<<
>   	return err;
>   }

You can also add my

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks,
Oliver


