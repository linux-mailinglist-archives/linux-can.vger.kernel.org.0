Return-Path: <linux-can+bounces-5794-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D4C953B2
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 20:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB7342463
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 19:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A42BE65B;
	Sun, 30 Nov 2025 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OLtF7Q7a";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kgMmZk+2"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7B36D510;
	Sun, 30 Nov 2025 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764529795; cv=pass; b=o6+UH7xL1xyZMJ/SGG5j5uKKCj8e2zFTRBBuKfC8sH5khKj/lXXWMe99wsdu2y57IhePffO3KmqTRU4sWSvfAX7RBmF002NlI6aYg7y4KndAtcRj8/AnZ8vbQki66tfHvoVR+6JbzNFtx3uuykfZjjywsGUdKyc9845kUrZtXWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764529795; c=relaxed/simple;
	bh=UPiA3LE5hC+O2zConxOpW9nBiWBBe92XTpcFFFD+8gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+swYmOdiFfRVM7wrfkDG3lg/7DVSuiL88+vBeJhLu5q7uSs519JU8bBs3iwRTTXUcQQHncT2RA4KbsRwb3f2mkFvP78k8W4ry4nhbiq5UhtuoC26xTth5GJT/Nxep/UGEK+VqHkL5VS3yBzl/2hJTzl4EuNU+1UXHhgfXAHj74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OLtF7Q7a; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kgMmZk+2; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764529789; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ixDL2hvWIhWsizWncy/v7JLtTyzPCuLgggCUoN/efMZ04K+5hd/bfYLsiEvTuwhoVW
    ylUB1h2ylz2L9ZTNMm3/C7PqO8NysTORISKjNrg4PVEf7F5YM2t2zu89GzS5ck/iPFgS
    qGT25eqG3Yu0xK1YAtQFTUviOs4Syo9mG+wLsiTGW8f54IlE0czO1tdOGyn7neDbewB6
    EWxt6Gp/bs87/iA74+eP3DIyQatb1VClkyJ35ZJUzqszRHbrOJv7XdvdRnUGCZ4JsfiA
    UyO8Xo/WjSDKG3JqXJCEtwCFFIxD+OUMWdFq19Ih/F0hyYtBX2lAkGQbX9tq2Q18E8yh
    7Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764529789;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H/U65BYu8VYVK/POJqt3lDI2a7KF/fLhF+u64QoDvLo=;
    b=sB2rqDJjomM+sb92qWVDjalA2L0YHJsKqiibDBlNV1sMru1+4gP1d/t4H6DxQ8w8/b
    9dxYgrEEE/2eSa3ZEfTacyzZVSRVh+J1vBT0OLsn7AS86z2XBjY7mGNA307rLOgd33Zp
    DE1LfsWVsSIq7j6S9ihF0wqNNuikl4Y/4lR0jeQzm/8XlSNmCla55oTdDZp4CjhGiuN7
    DkbUprPFx6XVItTeotzB+QdrIWBZRoL990klGdKqbAJo8mDIlDw0fZo36THwLFDkZ4ro
    xSWVkCcQ596QohpoPFPYIZAnSkKQtCQV5vn9F6Ezit2sI2eieOTHhpBZh0kA2g1AxFmH
    9maA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764529789;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H/U65BYu8VYVK/POJqt3lDI2a7KF/fLhF+u64QoDvLo=;
    b=OLtF7Q7a61bNi32IXljB7S7kl7DmPsETgRdMBuWZ5q422S7DrpFksrCyy/bGe7Frtd
    RQk4hPThhR4uslOKAENmHX4DtiOy+Ptd/wCqtu/BKkIQm+UTW4LewjPXSUEq7VfAajbZ
    s721xAKrwvclNsDSjs+2DwNPnkQw6WFo862Jm97HKmbD+4BOdN5Oe0m4eD4kH/RGx4pU
    ioC5rKXsSMgxFhpe67v2kT3XQHoSy0ZeyCSEt+R+4eOlFS8nOIIH57u9/CqR0/ZFeh7O
    dclor7mmKIsA4QnQvS+ogW6K+/+zHLvDDI6TfIRjv7x74hRtxTHJ2MfnhfQMh//6/09+
    8rGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764529789;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=H/U65BYu8VYVK/POJqt3lDI2a7KF/fLhF+u64QoDvLo=;
    b=kgMmZk+2Hz8J0KGSSNMcf8tJ3Ccwn92rpl69PPNaqSiO6dew0BvkAMWOU5LLxT+5RP
    MSggb39h1SnX8PtPeUDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AUJ9nnJw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 30 Nov 2025 20:09:49 +0100 (CET)
Message-ID: <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
Date: Sun, 30 Nov 2025 20:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about to KMSAN: uninit-value in can_receive
To: Prithvi Tambewagh <activprithvi@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <aSx++4VrGOm8zHDb@inspiron>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Prithvi,

On 30.11.25 18:29, Prithvi Tambewagh wrote:
> On Sun, Nov 30, 2025 at 01:44:32PM +0100, Oliver Hartkopp wrote:

>>> shall I send this patch upstream and mention your name in 
>> Suggested-by tag?
>>
>> No. Neither of that - as it will not fix the root cause.
>>
>> IMO we need to check who is using the headroom in CAN skbs and for 
>> what reason first. And when we are not able to safely control the 
>> headroom for our struct can_skb_priv content we might need to find 
>> another way to store that content.
>> E.g. by creating this space behind skb->data or add new attributes to 
>> struct sk_buff.
> 
> I will work in this direction. Just to confirm, what you mean is
> that first it should be checked where the headroom is used while also
> checking whether the data from region covered by struct can_skb_priv is 
> intact, and if not then we need to ensure that it is intact by other 
> measures, right?

I have added skb_dump(KERN_WARNING, skb, true) in my local dummy_can.c
an sent some CAN frames with cansend.

CAN CC:

[ 3351.708018] skb len=16 headroom=16 headlen=16 tailroom=288
                mac=(16,0) mac_len=0 net=(16,0) trans=16
                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 
valid=0 level=0)
                hash(0x0 sw=0 l4=0) proto=0x000c pkttype=5 iif=0
                priority=0x0 mark=0x0 alloc_cpu=5 vlan_all=0x0
                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[ 3351.708151] dev name=can0 feat=0x0000000000004008
[ 3351.708159] sk family=29 type=3 proto=0
[ 3351.708166] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[ 3351.708173] skb linear:   00000000: 23 01 00 00 04 00 00 00 11 22 33 
44 00 00 00 00

(..)

CAN FD:

[ 3557.069471] skb len=72 headroom=16 headlen=72 tailroom=232
                mac=(16,0) mac_len=0 net=(16,0) trans=16
                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 
valid=0 level=0)
                hash(0x0 sw=0 l4=0) proto=0x000d pkttype=5 iif=0
                priority=0x0 mark=0x0 alloc_cpu=6 vlan_all=0x0
                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[ 3557.069499] dev name=can0 feat=0x0000000000004008
[ 3557.069507] sk family=29 type=3 proto=0
[ 3557.069513] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[ 3557.069520] skb linear:   00000000: 33 03 00 00 10 05 00 00 00 11 22 
33 44 55 66 77
[ 3557.069526] skb linear:   00000010: 88 aa bb cc dd ee ff 00 00 00 00 
00 00 00 00 00

(..)

CAN XL:

[ 5477.498205] skb len=908 headroom=16 headlen=908 tailroom=804
                mac=(16,0) mac_len=0 net=(16,0) trans=16
                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 
valid=0 level=0)
                hash(0x0 sw=0 l4=0) proto=0x000e pkttype=5 iif=0
                priority=0x0 mark=0x0 alloc_cpu=6 vlan_all=0x0
                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
[ 5477.498236] dev name=can0 feat=0x0000000000004008
[ 5477.498244] sk family=29 type=3 proto=0
[ 5477.498251] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00
[ 5477.498258] skb linear:   00000000: b0 05 92 00 81 cd 80 03 cd b4 92 
58 4c a1 f6 0c
[ 5477.498264] skb linear:   00000010: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 
0a 4c a1 f6 0c
[ 5477.498269] skb linear:   00000020: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 
0a 4c a1 f6 0c
[ 5477.498275] skb linear:   00000030: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 
0a 4c a1 f6 0c


I will also add skb_dump(KERN_WARNING, skb, true) in the CAN receive 
path to see what's going on there.

My main problem with the KMSAN message
https://lore.kernel.org/linux-can/68bae75b.050a0220.192772.0190.GAE@google.com/
is that it uses

NAPI, XDP and therefore pskb_expand_head():

  kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
  pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
  netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
  netif_receive_generic_xdp net/core/dev.c:5112 [inline]
  do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
  __netif_receive_skb_core+0x25c3/0x6f10 net/core/dev.c:5524
  __netif_receive_skb_one_core net/core/dev.c:5702 [inline]
  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5817
  process_backlog+0x4ad/0xa50 net/core/dev.c:6149
  __napi_poll+0xe7/0x980 net/core/dev.c:6902
  napi_poll net/core/dev.c:6971 [inline]

As you can see in
https://syzkaller.appspot.com/x/log.txt?x=144ece64580000

[pid  5804] socket(AF_CAN, SOCK_DGRAM, CAN_ISOTP) = 5
[pid  5804] ioctl(5, SIOCGIFINDEX, {ifr_name="vxcan0", ifr_ifindex=20}) = 0

they are using the vxcan driver which is mainly derived from vcan.c and 
veth.c (~2017). The veth.c driver supports all those GRO, NAPI and XDP 
features today which vxcan.c still does NOT support.

Therefore I wonder how the NAPI and XDP code can be used together with 
vxcan. And if this is still the case today, as the syzcaller kernel 
6.13.0-rc7-syzkaller-00039-gc3812b15000c is already one year old.

Many questions ...

Best regards,
Oliver

