Return-Path: <linux-can+bounces-5887-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F2CCD3470
	for <lists+linux-can@lfdr.de>; Sat, 20 Dec 2025 18:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDFFE300E7B6
	for <lists+linux-can@lfdr.de>; Sat, 20 Dec 2025 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7D288537;
	Sat, 20 Dec 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBfi3Rg1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12522157B
	for <linux-can@vger.kernel.org>; Sat, 20 Dec 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766252034; cv=none; b=AZ0pY8stuh1BLv1CDlWFgp6yyZq7tv5Imf7o9FxC9xbEQbp+f7fwNKVAN9+FUDVIIKDadiLyI2rIp1LduDd30xLmbncrJGWKSQEC75ahHuxqc+UydHNz7+Avq4MFat5FA7ZBncG3+HRqWLAK8GIGiCEvzzbX/isr/yeaAT9x8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766252034; c=relaxed/simple;
	bh=FX8ihlPX/eD8B5MbSkDB2q+n0qVFyCDN6zfxgA5ys8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN5/cO/Tky4gND52q3jY9jyo+MKuNq4SAUZDUyJmcfgT6Tg60FlKfULB437tEKiPUIXMidaBvTel83adxaU8NiXWZ8F/I6MaYyEuro3m07rp8tseFx/CDU3QuvCYxTDtUu0kYP3zt9k3KYj6wvdwIR5TyK1ahIAKrpziB/IckoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBfi3Rg1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2206010b3a.0
        for <linux-can@vger.kernel.org>; Sat, 20 Dec 2025 09:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766252031; x=1766856831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+9lABmfAhuLemTkgC/HAISOZL1XVzL6xJ1YIcMmBVM=;
        b=gBfi3Rg17SzxTwhgVLVzdV+avxTrf9rCi64B/LAbdfdK3hC/6W5lmMAXeQzOAo51Gg
         FGE/x7O26i6auWXmgvChOgSIz7HODCMebnn8BMY7OmjjG9bgi5TEAbX26nAlSIgUCyqD
         5Bb3nrx2jtXHdMkXAp55pvp4eFV8mKqN0k/8QbjjS27xlzE3FHDmSYb/mXzY05FHxbDX
         CVd6B0mY91Xqlj3vYUYE3ypzmRjZdYMO8NmN0rppBDZPyWE/Qlhj2k4taPqofG5MNSvh
         b2B8i1ehH/6opE/SbftN1gjA0Thz53JGySg8LuM/cngObEhlVCZGM5GGgmFDNf1wbtlf
         NEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766252031; x=1766856831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+9lABmfAhuLemTkgC/HAISOZL1XVzL6xJ1YIcMmBVM=;
        b=qhxT4KESiL+3wviaJe46rzPLMZepXjndBwImWU0Xqrez5gOhuSunznnnmwL4IdSwe7
         3PsT2Fk/r+xjzQrL2pOf8D51n0U/WjI45eFeuz6fS/CC+Fgko2P/cjSvf53aoQODviNx
         bSF77XYtnEROoT7t4h9hVDfW7B3Te7aW0CPcs0sNB06Lf42vGS39+QQTPiUd0//J0cxj
         rlizPQNIeN0aMnpcrvnnEIh6WWRKSLWvCDjLuYbPT9C0icTcBxA4ZifQqcwmB1FGYNLn
         ikcwsrGKIIhJvrPWtoeLirX7mi1HFgjbaSGRkZEXmqDeJsdfXww8MIiGf7jLyTgHbCJ5
         UnOg==
X-Forwarded-Encrypted: i=1; AJvYcCXw4ZpzxAY65PciilNu9dpkKOga1tk6YdSUOWDtc0SPVS6tnhiIGtfoVgyBBpKElKTamzTBOnN81/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43jO6lnBssfyt1RRmvKpHPeygOUqnDyunDUOowucFWjp/ea72
	6IJKDLuh27ySbluRLZjuo+XNxrPJRkZ6etwOSGrHUxO0oHFQDcy8iucn4PcTC41h
X-Gm-Gg: AY/fxX4eaFAiJ/uJyfw+zGDh7kd6lMLPGufe/uvK+jLnLSiUc7hU6876oF+Vsm+l6bh
	ioWznHhVfdjBhIULMzFrxJ2Id7gzr5HXOutApv3ha93DLgSSgfFPUNLa3OZocGMmMbV7SdGwIOd
	U29m0H6fkAFJOwpgAQy7oJmeLO8+zNFRyReu9/P2I1iGBKWqZNisTxY+7VbnXfBEC9YCSWYNx1J
	Vxl8jSU9cOvVqf2UdzfDg1la96PlxNEBvrhnVoaHbNOSx+Qgol39J378A4onvWvOeSbvPeeXoUu
	Ax13T3Jpwb01IWu1JdzIw+EUl9wdVAXl+LuujTDzOP7QQ+haMf8ZKUQygWlpuJX6rvg4SGB9o3s
	FidpEiblwrDygTJEUWoIB9/6NxwtmZQTy/pKa5g0NscA5vudc7amUBdfVenLlIytVM1g7GmjL3h
	TiAxVGEMZpoVs=
X-Google-Smtp-Source: AGHT+IFmFChrMUIl+iH0Vh5UzTWucVTOFKn7BEudwFKgT+7bsCM1eMRKfyjF2DaLxLfuJ52pGGiW9w==
X-Received: by 2002:a05:6a21:6d9a:b0:35d:2172:5ffb with SMTP id adf61e73a8af0-376a94b9f40mr6676985637.47.1766252031326;
        Sat, 20 Dec 2025 09:33:51 -0800 (PST)
Received: from inspiron ([111.125.231.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7a018eb5sm5424992a12.16.2025.12.20.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 09:33:50 -0800 (PST)
Date: Sat, 20 Dec 2025 23:03:38 +0530
From: Prithvi <activprithvi@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	netdev@vger.kernel.org
Subject: Re: Question about to KMSAN: uninit-value in can_receive
Message-ID: <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>

On Sun, Nov 30, 2025 at 08:09:48PM +0100, Oliver Hartkopp wrote:
> Hi Prithvi,
> 
> On 30.11.25 18:29, Prithvi Tambewagh wrote:
> > On Sun, Nov 30, 2025 at 01:44:32PM +0100, Oliver Hartkopp wrote:
> 
> > > > shall I send this patch upstream and mention your name in
> > > Suggested-by tag?
> > > 
> > > No. Neither of that - as it will not fix the root cause.
> > > 
> > > IMO we need to check who is using the headroom in CAN skbs and for
> > > what reason first. And when we are not able to safely control the
> > > headroom for our struct can_skb_priv content we might need to find
> > > another way to store that content.
> > > E.g. by creating this space behind skb->data or add new attributes
> > > to struct sk_buff.
> > 
> > I will work in this direction. Just to confirm, what you mean is
> > that first it should be checked where the headroom is used while also
> > checking whether the data from region covered by struct can_skb_priv is
> > intact, and if not then we need to ensure that it is intact by other
> > measures, right?
> 
> I have added skb_dump(KERN_WARNING, skb, true) in my local dummy_can.c
> an sent some CAN frames with cansend.
> 
> CAN CC:
> 
> [ 3351.708018] skb len=16 headroom=16 headlen=16 tailroom=288
>                mac=(16,0) mac_len=0 net=(16,0) trans=16
>                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 valid=0
> level=0)
>                hash(0x0 sw=0 l4=0) proto=0x000c pkttype=5 iif=0
>                priority=0x0 mark=0x0 alloc_cpu=5 vlan_all=0x0
>                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [ 3351.708151] dev name=can0 feat=0x0000000000004008
> [ 3351.708159] sk family=29 type=3 proto=0
> [ 3351.708166] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 3351.708173] skb linear:   00000000: 23 01 00 00 04 00 00 00 11 22 33 44
> 00 00 00 00
> 
> (..)
> 
> CAN FD:
> 
> [ 3557.069471] skb len=72 headroom=16 headlen=72 tailroom=232
>                mac=(16,0) mac_len=0 net=(16,0) trans=16
>                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 valid=0
> level=0)
>                hash(0x0 sw=0 l4=0) proto=0x000d pkttype=5 iif=0
>                priority=0x0 mark=0x0 alloc_cpu=6 vlan_all=0x0
>                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [ 3557.069499] dev name=can0 feat=0x0000000000004008
> [ 3557.069507] sk family=29 type=3 proto=0
> [ 3557.069513] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 3557.069520] skb linear:   00000000: 33 03 00 00 10 05 00 00 00 11 22 33
> 44 55 66 77
> [ 3557.069526] skb linear:   00000010: 88 aa bb cc dd ee ff 00 00 00 00 00
> 00 00 00 00
> 
> (..)
> 
> CAN XL:
> 
> [ 5477.498205] skb len=908 headroom=16 headlen=908 tailroom=804
>                mac=(16,0) mac_len=0 net=(16,0) trans=16
>                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 valid=0
> level=0)
>                hash(0x0 sw=0 l4=0) proto=0x000e pkttype=5 iif=0
>                priority=0x0 mark=0x0 alloc_cpu=6 vlan_all=0x0
>                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [ 5477.498236] dev name=can0 feat=0x0000000000004008
> [ 5477.498244] sk family=29 type=3 proto=0
> [ 5477.498251] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 5477.498258] skb linear:   00000000: b0 05 92 00 81 cd 80 03 cd b4 92 58
> 4c a1 f6 0c
> [ 5477.498264] skb linear:   00000010: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 0a
> 4c a1 f6 0c
> [ 5477.498269] skb linear:   00000020: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 0a
> 4c a1 f6 0c
> [ 5477.498275] skb linear:   00000030: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 0a
> 4c a1 f6 0c
> 
> 
> I will also add skb_dump(KERN_WARNING, skb, true) in the CAN receive path to
> see what's going on there.
> 
> My main problem with the KMSAN message
> https://lore.kernel.org/linux-can/68bae75b.050a0220.192772.0190.GAE@google.com/
> is that it uses
> 
> NAPI, XDP and therefore pskb_expand_head():
> 
>  kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
>  pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>  netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5112 [inline]
>  do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
>  __netif_receive_skb_core+0x25c3/0x6f10 net/core/dev.c:5524
>  __netif_receive_skb_one_core net/core/dev.c:5702 [inline]
>  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5817
>  process_backlog+0x4ad/0xa50 net/core/dev.c:6149
>  __napi_poll+0xe7/0x980 net/core/dev.c:6902
>  napi_poll net/core/dev.c:6971 [inline]
> 
> As you can see in
> https://syzkaller.appspot.com/x/log.txt?x=144ece64580000
> 
> [pid  5804] socket(AF_CAN, SOCK_DGRAM, CAN_ISOTP) = 5
> [pid  5804] ioctl(5, SIOCGIFINDEX, {ifr_name="vxcan0", ifr_ifindex=20}) = 0
> 
> they are using the vxcan driver which is mainly derived from vcan.c and
> veth.c (~2017). The veth.c driver supports all those GRO, NAPI and XDP
> features today which vxcan.c still does NOT support.
> 
> Therefore I wonder how the NAPI and XDP code can be used together with
> vxcan. And if this is still the case today, as the syzcaller kernel
> 6.13.0-rc7-syzkaller-00039-gc3812b15000c is already one year old.
> 
> Many questions ...
> 
> Best regards,
> Oliver

Hello Oliver,

I tried investigating further why the XDP path was chosen inspite of using 
vxcan. I tried looking for dummy_can.c in upstream tree but could not find 
it; I might be missing something here - could you please tell where can I 
find it? Meanwhile, I tried using GDB for the analysis.

I observed in the bug's strace log:

[pid  5804] bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_XDP, insn_cnt=3, insns=0x200000c0, license="syzkaller", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_XDP, prog_btf_fd=-1, func_info_rec_size=8, func_info=NULL, func_info_cnt=0, line_info_rec_size=16, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0, fd_array=NULL, ...}, 144) = 3
[pid  5804] socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE) = 4
[pid  5804] sendmsg(4, {msg_name=NULL, msg_namelen=0, msg_iov=[{iov_base="\x34\x00\x00\x00\x10\x00\x01\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x40\x01\x00\x00\x00\x01\x00\x0c\x00\x2b\x80\x08\x00\x01\x00\x03\x00\x00\x00\x08\x00\x1b\x00\x00\x00\x00\x00", iov_len=52}], msg_iovlen=1, msg_controllen=0, msg_flags=MSG_DONTWAIT|MSG_FASTOPEN}, 0) = 52
[pid  5804] socket(AF_CAN, SOCK_DGRAM, CAN_ISOTP) = 5
[pid  5804] ioctl(5, SIOCGIFINDEX, {ifr_name="vxcan0", ifr_ifindex=20}) = 0

Notably, before binding vxcan0 to the CAN socket, a BPF program is loaded. 
I then tried using GDB to check and got the following insights:

(gdb) b vxcan_xmit
Breakpoint 23 at 0xffffffff88ca899e: file drivers/net/can/vxcan.c, line 38.
(gdb) delete 23
(gdb) b __sys_bpf
Breakpoint 24 at 0xffffffff81d2653e: file kernel/bpf/syscall.c, line 5752.
(gdb) b bpf_prog_load
Breakpoint 25 at 0xffffffff81d2cd80: file kernel/bpf/syscall.c, line 2736.
(gdb) b vxcan_xmit if (oskb->dev->name[0]=='v' && ((oskb->dev->name[1]=='x' && oskb->dev->name[2]=='c' && oskb->dev->name[3]=='a' && oskb->dev->name[4]=='n') || (oskb->dev->name[1]=='c' && oskb->dev->name[2]=='a' && oskb->dev->name[3]=='n')))
Breakpoint 26 at 0xffffffff88ca899e: file drivers/net/can/vxcan.c, line 38.
(gdb) b __netif_receive_skb if (skb->dev->name[0]=='v' && ((skb->dev->name[1]=='x' && skb->dev->name[2]=='c' && skb->dev->name[3]=='a' && skb->dev->name[4]=='n') || (skb->dev->name[1]=='c' && skb->dev->name[2]=='a' && skb->dev->name[3]=='n')))
Breakpoint 27 at 0xffffffff8ce3c310: file net/core/dev.c, line 5798.
(gdb) b do_xdp_generic if (pskb->dev->name[0]=='v' && ((pskb->dev->name[1]=='x' && pskb->dev->name[2]=='c' && pskb->dev->name[3]=='a' && pskb->dev->name[4]=='n') || (pskb->dev->name[1]=='c' && pskb->dev->name[2]=='a' && pskb->dev->name[3]=='n')))
Breakpoint 28 at 0xffffffff8cdfccd7: file net/core/dev.c, line 5171.
(gdb) b dev_xdp_attach if (dev->name[0]=='v' && ((dev->name[1]=='x' && dev->name[2]=='c' && dev->name[3]=='a' && dev->name[4]=='n') || (dev->name[1]=='c' && dev->name[2]=='a' && dev->name[3]=='n')))
Breakpoint 29 at 0xffffffff8ce18b4e: file net/core/dev.c, line 9610.

Thread 2 hit Breakpoint 24, __sys_bpf (cmd=cmd@entry=BPF_PROG_LOAD, uattr=..., size=size@entry=144) at kernel/bpf/syscall.c:5752
5752    {
(gdb) c
Continuing.

Thread 2 hit Breakpoint 25, bpf_prog_load (attr=attr@entry=0xffff88811c987d60, uattr=..., uattr_size=144) at kernel/bpf/syscall.c:2736
2736    {
(gdb) c
Continuing.
[Switching to Thread 1.1]

Thread 1 hit Breakpoint 29, dev_xdp_attach (dev=dev@entry=0xffff888124e78000, extack=extack@entry=0xffff88811c987858, link=link@entry=0x0 <fixed_percpu_data>, new_prog=new_prog@entry=0xffffc9000a516000, old_prog=old_prog@entry=0x0 <fixed_percpu_data>, flags=flags@entry=0) at net/core/dev.c:9610
9610    {
(gdb) p dev->name
$104 = "vcan0\000\000\000\000\000\000\000\000\000\000"
(gdb) p dev->xdp_prog
$105 = (struct bpf_prog *) 0x0 <fixed_percpu_data>
(gdb) c
Continuing.

Thread 1 hit Breakpoint 29, dev_xdp_attach (dev=dev@entry=0xffff88818e918000, extack=extack@entry=0xffff88811c987858, link=link@entry=0x0 <fixed_percpu_data>, new_prog=new_prog@entry=0xffffc9000a516000, old_prog=old_prog@entry=0x0 <fixed_percpu_data>, flags=flags@entry=0) at net/core/dev.c:9610
9610    {
(gdb) p dev->name
$106 = "vxcan0\000\000\000\000\000\000\000\000\000"
(gdb) p dev->xdp_prog
$107 = (struct bpf_prog *) 0x0 <fixed_percpu_data>
(gdb) c
Continuing.

Thread 1 hit Breakpoint 29, dev_xdp_attach (dev=dev@entry=0xffff88818e910000, extack=extack@entry=0xffff88811c987858, link=link@entry=0x0 <fixed_percpu_data>, new_prog=new_prog@entry=0xffffc9000a516000, old_prog=old_prog@entry=0x0 <fixed_percpu_data>, flags=flags@entry=0) at net/core/dev.c:9610
9610    {
(gdb) p dev->name
$108 = "vxcan1\000\000\000\000\000\000\000\000\000"
(gdb) p dev->xdp_prog
$109 = (struct bpf_prog *) 0x0 <fixed_percpu_data>
(gdb) c
Continuing.
[Switching to Thread 1.2]

Here, it is attempted to attach the eariler BPF program to each of the CAN 
devices present (I checked only for CAN devices since we are dealing with 
effect of XDP in CAN networing stack). Earlier they didn't seem to have any 
BPF program attached due to which  XDP wasn't attempted for these CAN devices
earlier.

Thread 2 hit Breakpoint 26, vxcan_xmit (oskb=0xffff888115d8a400, dev=0xffff88818e918000) at drivers/net/can/vxcan.c:38
38      {
(gdb) p oskb->dev->name
$110 = "vxcan0\000\000\000\000\000\000\000\000\000"
(gdb) p oskb->dev->xdp_prog
$111 = (struct bpf_prog *) 0xffffc9000a516000
(gdb) c
Continuing.

Thread 2 hit Breakpoint 27, __netif_receive_skb (skb=skb@entry=0xffff888115d8ab00) at net/core/dev.c:5798
5798    {
(gdb) p skb->dev->name
$112 = "vxcan1\000\000\000\000\000\000\000\000\000"
(gdb) p skb->dev->xdp_prog
$113 = (struct bpf_prog *) 0xffffc9000a516000
(gdb) c
Continuing.

Thread 2 hit Breakpoint 28, do_xdp_generic (xdp_prog=0xffffc9000a516000, pskb=0xffff88843fc05af8) at net/core/dev.c:5171
5171    {
(gdb) p pskb->dev->name
$114 = "vxcan1\000\000\000\000\000\000\000\000\000"
(gdb) p pskb->dev->xdp_prog
$115 = (struct bpf_prog *) 0xffffc9000a516000
(gdb) c
Continuing.

After this, the KMSAN bug is triggered. Hence, we can conclude that due to the
BPF program loaded earlier, the CAN device undertakes generic XDP path during RX, 
which is accessible even if vxcan doesn't support XDP by itself.

It seems that the way CAN devices use the headroom for storing private skb related
data might be incompatible for XPD path, due to which the generic networking stack 
at RX requires to expand the head, and it is done in such a way that the yet 
uninitialized expanded headroom is accesssed by can_skb_prv() using skb->head.

So, I think we can solve this bug in the following ways:

1. As you suggested earlier, access struct can_skb_priv using: 
struct can_skb_priv *)(skb->data - sizeof(struct can_skb_priv)
This method ensures that the remaining CAN networking stack, which expects can_skb_priv
just before skb->data, as well as maintain compatibility with headroom expamnsion during
generic XDP.

2. Try to find some way so that XDP pathway is rejected by CAN devices at the beginning 
itself, like for example in function dev_xdp_attach():

/* don't call drivers if the effective program didn't change */
if (new_prog != cur_prog) {
	bpf_op = dev_xdp_bpf_op(dev, mode);
	if (!bpf_op) {
		NL_SET_ERR_MSG(extack, "Underlying driver does not support XDP in native mode");
		return -EOPNOTSUPP;
	}

	err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
	if (err)
		return err;
}

or in some other appropriate way.

What do you think what should be done ahead?

Best Regards,
Prithvi

