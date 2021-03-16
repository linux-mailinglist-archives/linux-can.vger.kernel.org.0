Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD833CC46
	for <lists+linux-can@lfdr.de>; Tue, 16 Mar 2021 04:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhCPDri (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Mar 2021 23:47:38 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3302 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhCPDr3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Mar 2021 23:47:29 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DzzgF5hL1z145Nb;
        Tue, 16 Mar 2021 11:44:25 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 16 Mar 2021 11:47:25 +0800
Received: from [127.0.0.1] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 16 Mar
 2021 11:47:25 +0800
Subject: Re: [Linuxarm] Re: [RFC v2] net: sched: implement TCQ_F_CAN_BYPASS
 for lockless qdisc
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <olteanv@gmail.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andriin@fb.com>, <edumazet@google.com>,
        <weiwan@google.com>, <cong.wang@bytedance.com>,
        <ap420073@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
References: <1615603667-22568-1-git-send-email-linyunsheng@huawei.com>
 <1615777818-13969-1-git-send-email-linyunsheng@huawei.com>
 <20210315115332.1647e92b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <3838b7c2-c32f-aeda-702a-5cb8f712ec0c@huawei.com>
Message-ID: <3ddec762-19c8-6743-43dd-3e44f91fd113@huawei.com>
Date:   Tue, 16 Mar 2021 11:47:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <3838b7c2-c32f-aeda-702a-5cb8f712ec0c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021/3/16 8:35, Yunsheng Lin wrote:
> On 2021/3/16 2:53, Jakub Kicinski wrote:
>> On Mon, 15 Mar 2021 11:10:18 +0800 Yunsheng Lin wrote:
>>> @@ -606,6 +623,11 @@ static const u8 prio2band[TC_PRIO_MAX + 1] = {
>>>   */
>>>  struct pfifo_fast_priv {
>>>  	struct skb_array q[PFIFO_FAST_BANDS];
>>> +
>>> +	/* protect against data race between enqueue/dequeue and
>>> +	 * qdisc->empty setting
>>> +	 */
>>> +	spinlock_t lock;
>>>  };
>>>  
>>>  static inline struct skb_array *band2list(struct pfifo_fast_priv *priv,
>>> @@ -623,7 +645,10 @@ static int pfifo_fast_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
>>>  	unsigned int pkt_len = qdisc_pkt_len(skb);
>>>  	int err;
>>>  
>>> -	err = skb_array_produce(q, skb);
>>> +	spin_lock(&priv->lock);
>>> +	err = __ptr_ring_produce(&q->ring, skb);
>>> +	WRITE_ONCE(qdisc->empty, false);
>>> +	spin_unlock(&priv->lock);
>>>  
>>>  	if (unlikely(err)) {
>>>  		if (qdisc_is_percpu_stats(qdisc))
>>> @@ -642,6 +667,7 @@ static struct sk_buff *pfifo_fast_dequeue(struct Qdisc *qdisc)
>>>  	struct sk_buff *skb = NULL;
>>>  	int band;
>>>  
>>> +	spin_lock(&priv->lock);
>>>  	for (band = 0; band < PFIFO_FAST_BANDS && !skb; band++) {
>>>  		struct skb_array *q = band2list(priv, band);
>>>  
>>> @@ -655,6 +681,7 @@ static struct sk_buff *pfifo_fast_dequeue(struct Qdisc *qdisc)
>>>  	} else {
>>>  		WRITE_ONCE(qdisc->empty, true);
>>>  	}
>>> +	spin_unlock(&priv->lock);
>>>  
>>>  	return skb;
>>>  }
>>
>> I thought pfifo was supposed to be "lockless" and this change
>> re-introduces a lock between producer and consumer, no?
> 
> Yes, the lock breaks the "lockless" of the lockless qdisc for now
> I do not how to solve the below data race locklessly:
> 
> 	CPU1:					CPU2:
>       dequeue skb				 .
> 	  .				    	 .	
> 	  .				    enqueue skb
> 	  .					 .
> 	  .			 WRITE_ONCE(qdisc->empty, false);
> 	  .					 .
> 	  .					 .
> WRITE_ONCE(qdisc->empty, true);
> 
> If the above happens, the qdisc->empty is true even if the qdisc has some
> skb, which may cuase out of order or packet stuck problem.
> 
> It seems we may need to update ptr_ring' status(empty or not) while
> enqueuing/dequeuing atomically in the ptr_ring implementation.
> 
> Any better idea?

It seems we can use __ptr_ring_empty() within the qdisc->seqlock protection,
because qdisc->seqlock is clearly served as r->consumer_lock.

> 
>>
>> .
>>
> _______________________________________________
> Linuxarm mailing list -- linuxarm@openeuler.org
> To unsubscribe send an email to linuxarm-leave@openeuler.org
> 

