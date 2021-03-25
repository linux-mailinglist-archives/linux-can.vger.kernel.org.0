Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A476D348C63
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCYJMY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 05:12:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:8686 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCYJMI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 05:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616663517; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SkSteTCnOuaL2bBPjkj2SfIJIBSag/kEbLh0+KWy8Ovnr4m4qld8vnfzTSxuR6//eF
    qT/yposMgnqffAUqglWAJZbIjKfYosJRStVQIwJn3VUneMCpb/Md/ojralAyF9Yg5LYq
    eEf+iSmzH2S+cYB7roefqtaRfj/iQyx2vS+oILO3HLeOpigCZFkcoYgaA1Ma+q8b35pN
    Akl0TS1TvUZbltevQkedq0qST9MP8VPeH9HA0TeoQ8Yb5Sc8y7YsEI2ADcRjdKuCrNRh
    WDVBeSKsoH6bIE2ou9xhHZ4B/D+BjDv9lP70CDbmzxlmdyVlPzmWnQG7EIzpJwgT0YvO
    Zwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616663517;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1OqIDKYi0+0ejLYAGtBbj7lAsT2xFd3v0DJeiRGwoZ0=;
    b=PEsS+Lb4d2l9FOrl5fH/Zm+myURmvFlKWRc248gkTX5uvna5YJjco3txQytuzgEVxm
    6+b2vd6L01H/m4ZbYjOK9LqClbFJYHO0AYnTG+l0wko9KLbHY+xYnxcXsHmK3fAJmhWC
    cWU69TlsWALfEbOGTBwW3se/vWkw6KI5HLpay7D+hPPOUXFAP6Mj2pnumJTuSgAD5UHt
    hahY5k+prf8MkA6N4xAF+kVMh7ymMhYQtrNw6YsDCBypaUNJp0WJ8DcbQpr5QvWni5sr
    GTUpYNFn6fDdACPMRqcNm6LWKDxwCRTpZWL0nAPaRJS7ZnB2jLm54bMyNTu9SITurAji
    T2dQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616663517;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:Cc:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1OqIDKYi0+0ejLYAGtBbj7lAsT2xFd3v0DJeiRGwoZ0=;
    b=PQMHekpftqoZbLHj9eRTqLTt6kXfLLcPGrxXLpDsIPpgwL7XIouWWxop+7kj8iG0/O
    zSrQO2cd9JG19jZnvjVAPNIPTryNwwQjadTlHy0s7YcrApgZAxxN2KdNBiDFZg+srkep
    kyD1URCOcwfY00Y6/+VhL1Me1UO6UEUfSC1rLnzgtqLg3rmk83fuu7QFhkmuXcDHdLEO
    LLoRFCQi59fpKBeRBFMwhATBSMbe0hWuLyM/0NHeMn6uNIlPhwWL1UCpy/nnVnN/kk8S
    DChIYEjvW4dwk5QPxlTx4ODmWSV9jTYM1crAtKVFEeseqfzr/YAv8RN7F2AREEu2AM85
    Xzcg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.22.0 DYNA|AUTH)
    with ESMTPSA id z00fabx2P9Bv3A9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 25 Mar 2021 10:11:57 +0100 (CET)
Subject: Re: [PATCH v2] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210325081326.1652-1-socketcan@hartkopp.net>
 <20210325084714.GE8446@x1.vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <63afa11b-da2f-65ed-f833-392ca625496f@hartkopp.net>
Date:   Thu, 25 Mar 2021 10:11:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325084714.GE8446@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Kurt!

@Marc: Would you suggest to split this patch in two parts (raw, bcm) and 
(isotp) - as it would simplify the stable process?

isotp emerged in 5.10 while the j1939 (and the CAN_REQUIRED_SIZE macro) 
existed since 5.4

Regards,
Oliver

On 25.03.21 09:47, Kurt Van Dijck wrote:
> Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> 
> On Thu, 25 Mar 2021 09:13:26 +0100, Oliver Hartkopp wrote:
>> Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
>> members") the sockaddr_can has been extended in size and a new
>> CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
>> specific needed size.
>>
>> The ABI for the msg_name and msg_namelen has not been adapted to the
>> new CAN_REQUIRED_SIZE macro for the other CAN protocols which leads
>> to a problem when an existing binary reads the (increased)
>> struct sockaddr_can in msg_name.
>>
>> Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
>> Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
>> Reported-by: Richard Weinberger <richard@nod.at>
>> Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   net/can/bcm.c   | 10 ++++++----
>>   net/can/isotp.c | 11 +++++++----
>>   net/can/raw.c   | 14 ++++++++------
>>   3 files changed, 21 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 0e5c37be4a2b..909b9e684e04 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -84,10 +84,12 @@
>>   MODULE_DESCRIPTION("PF_CAN broadcast manager protocol");
>>   MODULE_LICENSE("Dual BSD/GPL");
>>   MODULE_AUTHOR("Oliver Hartkopp <oliver.hartkopp@volkswagen.de>");
>>   MODULE_ALIAS("can-proto-2");
>>   
>> +#define BCM_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
>> +
>>   /*
>>    * easy access to the first 64 bit of can(fd)_frame payload. cp->data is
>>    * 64 bit aligned so the offset has to be multiples of 8 which is ensured
>>    * by the only callers in bcm_rx_cmp_to_index() bcm_rx_handler().
>>    */
>> @@ -1290,11 +1292,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   
>>   	if (!ifindex && msg->msg_name) {
>>   		/* no bound device as default => check msg_name */
>>   		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>>   
>> -		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>> +		if (msg->msg_namelen < BCM_MIN_NAMELEN)
>>   			return -EINVAL;
>>   
>>   		if (addr->can_family != AF_CAN)
>>   			return -EINVAL;
>>   
>> @@ -1532,11 +1534,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr *uaddr, int len,
>>   	struct sock *sk = sock->sk;
>>   	struct bcm_sock *bo = bcm_sk(sk);
>>   	struct net *net = sock_net(sk);
>>   	int ret = 0;
>>   
>> -	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>> +	if (len < BCM_MIN_NAMELEN)
>>   		return -EINVAL;
>>   
>>   	lock_sock(sk);
>>   
>>   	if (bo->bound) {
>> @@ -1614,12 +1616,12 @@ static int bcm_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>>   	}
>>   
>>   	sock_recv_ts_and_drops(msg, sk, skb);
>>   
>>   	if (msg->msg_name) {
>> -		__sockaddr_check_size(sizeof(struct sockaddr_can));
>> -		msg->msg_namelen = sizeof(struct sockaddr_can);
>> +		__sockaddr_check_size(BCM_MIN_NAMELEN);
>> +		msg->msg_namelen = BCM_MIN_NAMELEN;
>>   		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>>   	}
>>   
>>   	skb_free_datagram(sk, skb);
>>   
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 3ef7f78e553b..86945dbb6c76 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -75,10 +75,12 @@
>>   MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
>>   MODULE_LICENSE("Dual BSD/GPL");
>>   MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
>>   MODULE_ALIAS("can-proto-6");
>>   
>> +#define ISOTP_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp)
>> +
>>   #define SINGLE_MASK(id) (((id) & CAN_EFF_FLAG) ? \
>>   			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
>>   			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
>>   
>>   /* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
>> @@ -987,11 +989,12 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>>   	}
>>   
>>   	sock_recv_timestamp(msg, sk, skb);
>>   
>>   	if (msg->msg_name) {
>> -		msg->msg_namelen = sizeof(struct sockaddr_can);
>> +		__sockaddr_check_size(ISOTP_MIN_NAMELEN);
>> +		msg->msg_namelen = ISOTP_MIN_NAMELEN;
>>   		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>>   	}
>>   
>>   	skb_free_datagram(sk, skb);
>>   
>> @@ -1057,11 +1060,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>   	struct net_device *dev;
>>   	int err = 0;
>>   	int notify_enetdown = 0;
>>   	int do_rx_reg = 1;
>>   
>> -	if (len < CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp))
>> +	if (len < ISOTP_MIN_NAMELEN)
>>   		return -EINVAL;
>>   
>>   	/* do not register frame reception for functional addressing */
>>   	if (so->opt.flags & CAN_ISOTP_SF_BROADCAST)
>>   		do_rx_reg = 0;
>> @@ -1153,17 +1156,17 @@ static int isotp_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
>>   	struct isotp_sock *so = isotp_sk(sk);
>>   
>>   	if (peer)
>>   		return -EOPNOTSUPP;
>>   
>> -	memset(addr, 0, sizeof(*addr));
>> +	memset(addr, 0, ISOTP_MIN_NAMELEN);
>>   	addr->can_family = AF_CAN;
>>   	addr->can_ifindex = so->ifindex;
>>   	addr->can_addr.tp.rx_id = so->rxid;
>>   	addr->can_addr.tp.tx_id = so->txid;
>>   
>> -	return sizeof(*addr);
>> +	return ISOTP_MIN_NAMELEN;
>>   }
>>   
>>   static int isotp_setsockopt(struct socket *sock, int level, int optname,
>>   			    sockptr_t optval, unsigned int optlen)
>>   {
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 37b47a39a3ed..139d9471ddcf 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -58,10 +58,12 @@
>>   MODULE_DESCRIPTION("PF_CAN raw protocol");
>>   MODULE_LICENSE("Dual BSD/GPL");
>>   MODULE_AUTHOR("Urs Thuermann <urs.thuermann@volkswagen.de>");
>>   MODULE_ALIAS("can-proto-1");
>>   
>> +#define RAW_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_ifindex)
>> +
>>   #define MASK_ALL 0
>>   
>>   /* A raw socket has a list of can_filters attached to it, each receiving
>>    * the CAN frames matching that filter.  If the filter list is empty,
>>    * no CAN frames will be received by the socket.  The default after
>> @@ -392,11 +394,11 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>   	struct raw_sock *ro = raw_sk(sk);
>>   	int ifindex;
>>   	int err = 0;
>>   	int notify_enetdown = 0;
>>   
>> -	if (len < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>> +	if (len < RAW_MIN_NAMELEN)
>>   		return -EINVAL;
>>   	if (addr->can_family != AF_CAN)
>>   		return -EINVAL;
>>   
>>   	lock_sock(sk);
>> @@ -473,15 +475,15 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
>>   	struct raw_sock *ro = raw_sk(sk);
>>   
>>   	if (peer)
>>   		return -EOPNOTSUPP;
>>   
>> -	memset(addr, 0, sizeof(*addr));
>> +	memset(addr, 0, RAW_MIN_NAMELEN);
>>   	addr->can_family  = AF_CAN;
>>   	addr->can_ifindex = ro->ifindex;
>>   
>> -	return sizeof(*addr);
>> +	return RAW_MIN_NAMELEN;
>>   }
>>   
>>   static int raw_setsockopt(struct socket *sock, int level, int optname,
>>   			  sockptr_t optval, unsigned int optlen)
>>   {
>> @@ -737,11 +739,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	int err;
>>   
>>   	if (msg->msg_name) {
>>   		DECLARE_SOCKADDR(struct sockaddr_can *, addr, msg->msg_name);
>>   
>> -		if (msg->msg_namelen < CAN_REQUIRED_SIZE(*addr, can_ifindex))
>> +		if (msg->msg_namelen < RAW_MIN_NAMELEN)
>>   			return -EINVAL;
>>   
>>   		if (addr->can_family != AF_CAN)
>>   			return -EINVAL;
>>   
>> @@ -830,12 +832,12 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>>   	}
>>   
>>   	sock_recv_ts_and_drops(msg, sk, skb);
>>   
>>   	if (msg->msg_name) {
>> -		__sockaddr_check_size(sizeof(struct sockaddr_can));
>> -		msg->msg_namelen = sizeof(struct sockaddr_can);
>> +		__sockaddr_check_size(RAW_MIN_NAMELEN);
>> +		msg->msg_namelen = RAW_MIN_NAMELEN;
>>   		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>>   	}
>>   
>>   	/* assign the flags that have been recorded in raw_rcv() */
>>   	msg->msg_flags |= *(raw_flags(skb));
>> -- 
>> 2.30.2
>>
