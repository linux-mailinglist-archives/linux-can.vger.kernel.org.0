Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF43D2D04
	for <lists+linux-can@lfdr.de>; Thu, 22 Jul 2021 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGVTOk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jul 2021 15:14:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:16261 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGVTOk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jul 2021 15:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626983697;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=BUH41gjbt1XSj/FQSf0qQOE7K8bX37cyxz4cMsA/9CM=;
    b=AuixzfwzlB2pCJbUpNeofOh4iudUbrAKtLsCsz1sCCRlOhlP8AdL52Zhq6xGZjl+1e
    Ba63K+oh/QELTY2qgB2NgEPkgL0ipw8cLgaDc3EztCaY+QDgSC/hwJE1SWUPuDTYgtJx
    xfaRaqaHRH3APF+R2s+sYR6UGfi7+DaTm3vy5CVrkXmCTJu4FHFvSzKPWw5iUROZHc/r
    uL7q0JIHuH2ukECzqHs6DWeVIfrUFCgfJPJJe1bQt6o+bcqRDVi0tM2PrTa36JNJBPrv
    RyKedgqOmrlHQNy0BmY0EOsK2xppg7nuAM4efhSUYdZAHswn8D4PQ9vIp7sVcweNgyQf
    y9Bw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3htNmYasgbo6AhaFdcg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cee:8300::b82]
    by smtp.strato.de (RZmta 47.28.1 AUTH)
    with ESMTPSA id Z03199x6MJsuLhI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 22 Jul 2021 21:54:56 +0200 (CEST)
Subject: Re: [PATCH net v2] can: raw: fix raw_rcv panic for sock UAF
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210722070819.1048263-1-william.xuanziyang@huawei.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <5a715cd9-b085-5f69-a3a2-675854233a8e@hartkopp.net>
Date:   Thu, 22 Jul 2021 21:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722070819.1048263-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22.07.21 09:08, Ziyang Xuan wrote:
> We get a bug during ltp can_filter test as following.
> 
> ===========================================
> [60919.264984] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> [60919.265223] PGD 8000003dda726067 P4D 8000003dda726067 PUD 3dda727067 PMD 0
> [60919.265443] Oops: 0000 [#1] SMP PTI
> [60919.265550] CPU: 30 PID: 3638365 Comm: can_filter Kdump: loaded Tainted: G        W         4.19.90+ #1
> [60919.266068] RIP: 0010:selinux_socket_sock_rcv_skb+0x3e/0x200
> [60919.293289] RSP: 0018:ffff8d53bfc03cf8 EFLAGS: 00010246
> [60919.307140] RAX: 0000000000000000 RBX: 000000000000001d RCX: 0000000000000007
> [60919.320756] RDX: 0000000000000001 RSI: ffff8d5104a8ed00 RDI: ffff8d53bfc03d30
> [60919.334319] RBP: ffff8d9338056800 R08: ffff8d53bfc29d80 R09: 0000000000000001
> [60919.347969] R10: ffff8d53bfc03ec0 R11: ffffb8526ef47c98 R12: ffff8d53bfc03d30
> [60919.350320] perf: interrupt took too long (3063 > 2500), lowering kernel.perf_event_max_sample_rate to 65000
> [60919.361148] R13: 0000000000000001 R14: ffff8d53bcf90000 R15: 0000000000000000
> [60919.361151] FS:  00007fb78b6b3600(0000) GS:ffff8d53bfc00000(0000) knlGS:0000000000000000
> [60919.400812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [60919.413730] CR2: 0000000000000010 CR3: 0000003e3f784006 CR4: 00000000007606e0
> [60919.426479] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [60919.439339] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [60919.451608] PKRU: 55555554
> [60919.463622] Call Trace:
> [60919.475617]  <IRQ>
> [60919.487122]  ? update_load_avg+0x89/0x5d0
> [60919.498478]  ? update_load_avg+0x89/0x5d0
> [60919.509822]  ? account_entity_enqueue+0xc5/0xf0
> [60919.520709]  security_sock_rcv_skb+0x2a/0x40
> [60919.531413]  sk_filter_trim_cap+0x47/0x1b0
> [60919.542178]  ? kmem_cache_alloc+0x38/0x1b0
> [60919.552444]  sock_queue_rcv_skb+0x17/0x30
> [60919.562477]  raw_rcv+0x110/0x190 [can_raw]
> [60919.572539]  can_rcv_filter+0xbc/0x1b0 [can]
> [60919.582173]  can_receive+0x6b/0xb0 [can]
> [60919.591595]  can_rcv+0x31/0x70 [can]
> [60919.600783]  __netif_receive_skb_one_core+0x5a/0x80
> [60919.609864]  process_backlog+0x9b/0x150
> [60919.618691]  net_rx_action+0x156/0x400
> [60919.627310]  ? sched_clock_cpu+0xc/0xa0
> [60919.635714]  __do_softirq+0xe8/0x2e9
> [60919.644161]  do_softirq_own_stack+0x2a/0x40
> [60919.652154]  </IRQ>
> [60919.659899]  do_softirq.part.17+0x4f/0x60
> [60919.667475]  __local_bh_enable_ip+0x60/0x70
> [60919.675089]  __dev_queue_xmit+0x539/0x920
> [60919.682267]  ? finish_wait+0x80/0x80
> [60919.689218]  ? finish_wait+0x80/0x80
> [60919.695886]  ? sock_alloc_send_pskb+0x211/0x230
> [60919.702395]  ? can_send+0xe5/0x1f0 [can]
> [60919.708882]  can_send+0xe5/0x1f0 [can]
> [60919.715037]  raw_sendmsg+0x16d/0x268 [can_raw]
> 
> It's because raw_setsockopt() concurrently with
> unregister_netdevice_many(). Concurrent scenario as following.
> 
> 	cpu0						cpu1
> raw_bind
> raw_setsockopt					unregister_netdevice_many
> 						unlist_netdevice
> dev_get_by_index				raw_notifier
> raw_enable_filters				......
> can_rx_register
> can_rcv_list_find(..., net->can.rx_alldev_list)
> 
> ......
> 
> sock_close
> raw_release(sock_a)
> 
> ......
> 
> can_receive
> can_rcv_filter(net->can.rx_alldev_list, ...)
> raw_rcv(skb, sock_a)
> BUG
> 
> After unlist_netdevice(), dev_get_by_index() return NULL in
> raw_setsockopt(). Function raw_enable_filters() will add sock
> and can_filter to net->can.rx_alldev_list. Then the sock is closed.
> Followed by, we sock_sendmsg() to a new vcan device use the same
> can_filter. Protocol stack match the old receiver whose sock has
> been released on net->can.rx_alldev_list in can_rcv_filter().
> Function raw_rcv() uses the freed sock. UAF BUG is triggered.
> 
> We can find that the key issue is that net_device has not been
> protected in raw_setsockopt(). Use rtnl_lock to protect net_device
> in raw_setsockopt().
> 
> Fixes: c18ce101f2e4 ("[CAN]: Add raw protocol")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

> ---
> v2:
> - add exception handling for dev_get_by_index return NULL
>   net/can/raw.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index ed4fcb7ab0c3..cd5a49380116 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -546,10 +546,18 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   				return -EFAULT;
>   		}
>   
> +		rtnl_lock();
>   		lock_sock(sk);
>   
> -		if (ro->bound && ro->ifindex)
> +		if (ro->bound && ro->ifindex) {
>   			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> +			if (!dev) {
> +				if (count > 1)
> +					kfree(filter);
> +				err = -ENODEV;
> +				goto out_fil;
> +			}
> +		}
>   
>   		if (ro->bound) {
>   			/* (try to) register the new filters */
> @@ -588,6 +596,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   			dev_put(dev);
>   
>   		release_sock(sk);
> +		rtnl_unlock();
>   
>   		break;
>   
> @@ -600,10 +609,16 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   
>   		err_mask &= CAN_ERR_MASK;
>   
> +		rtnl_lock();
>   		lock_sock(sk);
>   
> -		if (ro->bound && ro->ifindex)
> +		if (ro->bound && ro->ifindex) {
>   			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
> +			if (!dev) {
> +				err = -ENODEV;
> +				goto out_err;
> +			}
> +		}
>   
>   		/* remove current error mask */
>   		if (ro->bound) {
> @@ -627,6 +642,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>   			dev_put(dev);
>   
>   		release_sock(sk);
> +		rtnl_unlock();
>   
>   		break;
>   
> 
