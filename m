Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD39118203
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2019 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfLJIRc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Dec 2019 03:17:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:31812 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfLJIRc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2019 03:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575965850;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6BfFBaL7x9fY9oDbUOqYHs7IIfiz+3OW6uXMBFTuijA=;
        b=WfocWTkKX/Ms9rcAKDH8Wciso36XwRXO4j9wMuCVxFCZGAQSOfkDjiu45D8ZrTgNPj
        1SEiiQBYowNEvvGyqAZYXnbMXWbIuj4C3Q0SL+0FDjjKJ5IT7pbbCbn4bFJtjsqzhPy2
        0slHtYF9iRJ7t8Fd6i7dwmIqn0GJuajXGS5fDkZtshaZbV9Y23c8u+nijwrKTHfITLhz
        Hsiq4kvsjhGrh+as2mvyTYLEFSgzp8QfJ1d8tFvDLMG48FNwexKtEDBKOugNvPnwuVm0
        5jfgrSaf4RW0P9xdeFKZ9Rg4h0R/RNuhNxernZotG+bt1T8FeTnrYaMP7DzqwntJ4Mve
        E9ow==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVch5lE1y"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.0.2 DYNA|AUTH)
        with ESMTPSA id 90101evBA8HHNy6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 10 Dec 2019 09:17:17 +0100 (CET)
Subject: Re: [mkl-can:testing 1/1] include/linux/can/dev.h:113: undefined
 reference to `can_skb_headroom_valid'
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-can@vger.kernel.org
References: <201912100437.GUTrZafq%lkp@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <30412963-6133-6114-d76d-6792093267b6@hartkopp.net>
Date:   Tue, 10 Dec 2019 09:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <201912100437.GUTrZafq%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

I built a Linux 5.5 rc1 with your patch without any problems. Any idea 
about this kbuild test failure?

So far vcan.o was not linked to dev.o as we only had the inline 
functions can_dropped_invalid_skb() and can_create_echo_skb() in dev.h.

dev.o contains all the netlink stuff for real CAN hardware which we are 
now linking as a whole.

Should we stay with can_skb_headroom_valid() as an inline function and 
do the clean-up later?

Regards,
Oliver


On 09/12/2019 21.44, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git testing
> head:   c2e15330b56ee5a41ad98c7266de21a3af259647
> commit: c2e15330b56ee5a41ad98c7266de21a3af259647 [1/1] can: ensure an initialized headroom in outgoing CAN sk_buffs
> config: x86_64-randconfig-s0-20191210 (attached as .config)
> compiler: gcc-6 (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
> reproduce:
>          git checkout c2e15330b56ee5a41ad98c7266de21a3af259647
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ld: drivers/net/can/vcan.o: in function `can_dropped_invalid_skb':
>>> include/linux/can/dev.h:113: undefined reference to `can_skb_headroom_valid'
> 
> vim +113 include/linux/can/dev.h
> 
>      95	
>      96	/* Drop a given socketbuffer if it does not contain a valid CAN frame. */
>      97	static inline bool can_dropped_invalid_skb(struct net_device *dev,
>      98						  struct sk_buff *skb)
>      99	{
>     100		const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>     101	
>     102		if (skb->protocol == htons(ETH_P_CAN)) {
>     103			if (unlikely(skb->len != CAN_MTU ||
>     104				     cfd->len > CAN_MAX_DLEN))
>     105				goto inval_skb;
>     106		} else if (skb->protocol == htons(ETH_P_CANFD)) {
>     107			if (unlikely(skb->len != CANFD_MTU ||
>     108				     cfd->len > CANFD_MAX_DLEN))
>     109				goto inval_skb;
>     110		} else
>     111			goto inval_skb;
>     112	
>   > 113		if (!can_skb_headroom_valid(dev, skb))
>     114			goto inval_skb;
>     115	
>     116		return false;
>     117	
>     118	inval_skb:
>     119		kfree_skb(skb);
>     120		dev->stats.tx_dropped++;
>     121		return true;
>     122	}
>     123	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
