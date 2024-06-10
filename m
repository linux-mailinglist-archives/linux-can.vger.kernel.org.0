Return-Path: <linux-can+bounces-719-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A2C902275
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2024 15:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40C81C21F3B
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E599581ACA;
	Mon, 10 Jun 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BO40FuOl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+5t5aA6X"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6C80639;
	Mon, 10 Jun 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025041; cv=pass; b=t3gHn4dr2UmUhUYRdydpmeUfGXmZTRFzsyxaqnZCQnbNVZGLsY5+fkrQgR8KgaiyfdDMoO+ITkVJTpCaMos6KCHm2wScOS8Ea649vWKOlpyI/zeR+/wQjWymdXqV1bfCcQ1DRo1LfiAIadLPCL3d4igpAUuznf9JfWwK/5Mrng4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025041; c=relaxed/simple;
	bh=NCrmIujlQ7hRWimVF3uCnnDS0h+9B5Z9LifeoDzKmT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIGpmgUM7JHDxKS6kx+Ii2VdIA+4fT87w0Bxep+vYOnq2sbyx5p8AxiCw04iA3kCDi5hGBneDXJWwST3JYeNHw9ij9AeNq5YssjDldHiuchQMHIoD84dyOB0kWI3J2ZCVP9QoTD/Gn0WpyQHUxQWEFkpagz9cBLg1TfbDsEj4lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BO40FuOl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+5t5aA6X; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1718023585; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lEcIRpI1XcIbPnRReZTjklKLdGCRtIXHrxHsoUUM6aW0bwMdXrvSAam5FoDhhkhk7+
    IcZqruUYAMC41nImsc+3Inxf1rRxt8yWYK6+vefxtZrfKXxQWAb2ah/OzQUSM1ZMUgZl
    HTa0bJSn3s6oxudIvOS3dJu94awawxCrznDbCixmbCqvfvcudji8J+PmXcti4r1iv4Je
    aJIiqE1I7UOZGadV2Fm+lspm756Y1UDIj8dA5etcvRD3+oC+8MV5eGafQJ2TvQBkp1/r
    8WwIAjgzVAaEJeehPbm1C9e8JXXEhRUFTkC3KyT53gUUGp3eVM/b94rsUvxbaosVFYjj
    x4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1718023585;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Yy/KeXePnjS9eUge6Fe4uaIv4DAnnVovzlqVealwFr0=;
    b=Bv+agTKub6AISf5rcb4dqWMbCDMWrLGpcYFkRvRmf5d5k4Lkck9fc1z899sF5ndNCO
    X7Lwhtpko/n6Ro1ybTTOlHlwMfC6gaXLYpRC4L8b0OItvDWHuDv7svd2ALRpvcidZRF6
    RA6O9eFSePMFEdQ8reGbdrmfQfVBfJR36GpBTXbmdyRX86bCEzkbLIlnSPYv/QpFYvWQ
    P101mg5q0Zq5uCKoSw45sOn8Oy44wTEQmg7rgLKNk/Rawgds0cmZnHzGpGGsOiXoUuun
    R5caknfmFOfPCg3DoP7R7UxJqjWNO9AtMO9OJrsek5U9T98gyXVxaKh6gUVUMiKvQrWW
    QCVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1718023585;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Yy/KeXePnjS9eUge6Fe4uaIv4DAnnVovzlqVealwFr0=;
    b=BO40FuOlI57pDECLqnXXgj9dAiCC8iUvc9wdKPPEcEYBiq/tlASdsg/vEha9g5Hl77
    rAHjYSvPuuAOUqqNwbxJfGydNLQKnH4p5Izwkc+KVhdfa+LWw5R/km9N8LIOpqSzYUnK
    VhOdfwFILCzrUhOR7xFwIitm8G3ESr2NCB/+1vagDwHu9C7ARJmSKe7PiHgXogndzFg3
    dmYKbn5y42TmyOehakxXMbmxefhMGTyoYa2sc07ECw8w+SxUb/RakVFz+Vf44bPWHcW+
    eCIU9atSXN574zVdKb69QldD6hof3Wup4L+u6zXbJZSZvdd9TPFnua7x7JQxhni7lKp+
    TFWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1718023585;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Yy/KeXePnjS9eUge6Fe4uaIv4DAnnVovzlqVealwFr0=;
    b=+5t5aA6XFFmeHzRs/gGtntJX+c+ydN8gdc4mV4c0Jx71/AJCK67XlBt2sRi76meJa/
    zwW8Is1mgsVrft3dt/Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTF1ViPMgG"
Received: from [192.168.20.47]
    by smtp.strato.de (RZmta 50.5.0 DYNA|AUTH)
    with ESMTPSA id K0664a05ACkO2Ov
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 10 Jun 2024 14:46:24 +0200 (CEST)
Message-ID: <384c7d85-3add-4658-954e-604f6408bd77@hartkopp.net>
Date: Mon, 10 Jun 2024 14:46:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] can: gw: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-11-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240609082726.32742-11-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.06.24 10:27, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
> // <smpl>
> @r@
> expression e;
> local idexpression e2;
> identifier cb,f;
> position p;
> @@
> 
> (
> call_rcu(...,e2)
> |
> call_rcu(&e->f,cb@p)
> )
> 
> @r1@
> type T;
> identifier x,r.cb;
> @@
> 
>   cb(...) {
> (
>     kmem_cache_free(...);
> |
>     T x = ...;
>     kmem_cache_free(...,x);
> |
>     T x;
>     x = ...;
>     kmem_cache_free(...,x);
> )
>   }
> 
> @s depends on r1@
> position p != r.p;
> identifier r.cb;
> @@
> 
>   cb@p
> 
> @script:ocaml@
> cb << r.cb;
> p << s.p;
> @@
> 
> Printf.eprintf "Other use of %s at %s:%d\n"
>     cb (List.hd p).file (List.hd p).line
> 
> @depends on r1 && !s@
> expression e;
> identifier r.cb,f;
> position r.p;
> @@
> 
> - call_rcu(&e->f,cb@p)
> + kfree_rcu(e,f)
> 
> @r1a depends on !s@
> type T;
> identifier x,r.cb;
> @@
> 
> - cb(...) {
> (
> -  kmem_cache_free(...);
> |
> -  T x = ...;
> -  kmem_cache_free(...,x);
> |
> -  T x;
> -  x = ...;
> -  kmem_cache_free(...,x);
> )
> - }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

For net/can/gw.c

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Julia!

> 
> ---
>   net/can/gw.c |   13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 37528826935e..ffb9870e2d01 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -577,13 +577,6 @@ static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
>   			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
>   }
>   
> -static void cgw_job_free_rcu(struct rcu_head *rcu_head)
> -{
> -	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
> -
> -	kmem_cache_free(cgw_cache, gwj);
> -}
> -
>   static int cgw_notifier(struct notifier_block *nb,
>   			unsigned long msg, void *ptr)
>   {
> @@ -603,7 +596,7 @@ static int cgw_notifier(struct notifier_block *nb,
>   			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
>   				hlist_del(&gwj->list);
>   				cgw_unregister_filter(net, gwj);
> -				call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +				kfree_rcu(gwj, rcu);
>   			}
>   		}
>   	}
> @@ -1168,7 +1161,7 @@ static void cgw_remove_all_jobs(struct net *net)
>   	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
>   		hlist_del(&gwj->list);
>   		cgw_unregister_filter(net, gwj);
> -		call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +		kfree_rcu(gwj, rcu);
>   	}
>   }
>   
> @@ -1236,7 +1229,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
>   
>   		hlist_del(&gwj->list);
>   		cgw_unregister_filter(net, gwj);
> -		call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +		kfree_rcu(gwj, rcu);
>   		err = 0;
>   		break;
>   	}
> 
> 

