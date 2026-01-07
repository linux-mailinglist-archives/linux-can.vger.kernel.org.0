Return-Path: <linux-can+bounces-6031-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D1D0061A
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 00:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B38E300DA6F
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A562EC0A6;
	Wed,  7 Jan 2026 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx2FO+rH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJF4l2VS"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248622E7F11
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828117; cv=none; b=b07r3cIj1aLZElS0N84qlfbE1ZPEvewMyWZ5RHYOlN/oTcHGxBJizmOtg8RpjfTf/7HSxvL+oI4ZPuVKHcpxn5oR0sg2GLgCeWDFIIxc676vnObvK3B00xNdwB/ShmCRqO84AFcx0ysc0CNBdA/pzECVLUh4Evc5v9MwAIKE7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828117; c=relaxed/simple;
	bh=WDgni6z1ajqIGM0PP7karFQjqBzAlobqYxuPAPjFXd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KObDtg0/Y+IF8t0a3NJft+BU94eY+s1YCzl1akVvXH5wBwHHLHXssYsUGgh5aq954zua+QvWdxlyQFPTZHlSGdUSHm6kuVLCDi18hUfX6NLvZXtQvaU8b0kUxzQOgt7ANsqWHkbrOBN1RBwB4iFWoyQF1ZP1V+IN2K67o8a/cDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx2FO+rH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJF4l2VS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767828114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEMu0Qq1b2UtZMlo5nERJFqxVgC5aIqVPPAv06mb1Zo=;
	b=Gx2FO+rHMsCiN1LopLBRI+ZFDV2nY5+yr3XiF5labcN44m0XLuuxS9NO3ShMfAuvuObqXJ
	/udyHPYkSbwaiSbHNp6aDMpZSytehD0j3hHTe6n/NCeORH8DiuNOH+Nyaq8cd+8daYk84U
	SbmHXuPhng0OOaJVoelSKHPwHW3SWjg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-KwHd9C4WNp65EmLJevdeQA-1; Wed, 07 Jan 2026 18:21:52 -0500
X-MC-Unique: KwHd9C4WNp65EmLJevdeQA-1
X-Mimecast-MFC-AGG-ID: KwHd9C4WNp65EmLJevdeQA_1767828112
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b844098867cso316206466b.3
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767828111; x=1768432911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEMu0Qq1b2UtZMlo5nERJFqxVgC5aIqVPPAv06mb1Zo=;
        b=IJF4l2VS3bnoeOtdOri7o8ndQTNpKWV70BqJJCZcss1VYWEpuYyx+7XYDwqR1V/T5S
         XO1arg2yLNUjQLhqFsf77ar1w891O7BWLZBbl5e5GQrVNA7dmoJPxfJLefB7pR/qx/mT
         zIxFi4cJxJ4L5BWO7CnWX27LlyXOInIdhoVo7LfA5rKvmfVYFBR5XMFHtcH1J3GLrpm5
         /2xZp4vY3kIqCLWpyOv3760GtpVfCVZxJ9AX5S+BYLwCOg7sLFArJObOLuu2OsfjW1Ca
         nnvggIverI1f4NqwtSrGUkgH6B9+8HLMs/RneK/ZtxbdNhxJm6RNcU7QEjgPMniA8pjP
         uLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828111; x=1768432911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEMu0Qq1b2UtZMlo5nERJFqxVgC5aIqVPPAv06mb1Zo=;
        b=WW+Ixd3fNo1JAMK6RBNchQse52Xfa7RxEm4cfGlika4KyoGvNN10vFLkGgk0AC1NCi
         7Vol4Owbxkzs4q1xboDe5up4dVxwRnomlwfTyBHPKPjz4ud86jPmphYkrScfZHx1bcgT
         aoU9FYYhw+JfZnC4dAWcBIm5uwzqtmwy5PF8aVprmjbK1CRBoE0QLhSMJjLE50lZllBQ
         qPpw11snAgR8hTAxPtlaJyPoBcPgO7aAW086slQUKGeUDmKxPf6mdUEXHhwuTMv8Txqn
         6vCehC6Nh+g+0yYfwKLDElBSrACy1/Mt+ODaBvhZVP2bw67t0Iyf6DVuE1ahksljoHU6
         nLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHVAUZQ6ejqY1h1NRayxe1jN00ZpRuSYZRl+fxiLtPQKNNJ92h4lADDQXJpHyAa8EBVT/cUnv+whU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1K/EXhtXPdbUmLRqHLv5pkx30ujPbopMKMNlUM3HDZRRFpMf
	yzXruREjSrbisbXNF6cLn+bbrwmDkmI1rCdgCFSKlyY7HemnLXdnbwVUYe0FxK1Xi/ihEE4r50b
	XBJpQor+9Wmel2YG9LWFvzhQUqUq6qMKNCVUN819S7qNWmegtksstWwu69npI/YZMaJ1WSj6b7R
	PjG6jitvfnAkhYa1yrj05oK86QsPdPyMxQTq1R
X-Gm-Gg: AY/fxX6+GN4991+/9EETVzl0Zn8IJt2BzL5Ocp/VROfHz/0umHViVf5JQFkJXAWZrPB
	MrLGruu5UpbAzE8TH6RMmoGKi4S5tQ3SMb3olN1duzpL5rwz2zkaPmbFzkY9DznSJFDp3JOLbkY
	bnkNtNjUH5cPuScHYhk6xgByRaryGLxfYlrROuZ9pXMcP0ed3mAHJKlXKZsoDbTtdnNmbQ6i0el
	9DqVhP7Jy+5TSnu1uqBe7vT
X-Received: by 2002:a17:907:7283:b0:b83:1327:5f88 with SMTP id a640c23a62f3a-b84451da312mr413767866b.16.1767828111398;
        Wed, 07 Jan 2026 15:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD2HiWiiOKtaHjnkMA5jfb9slYQAsOHb0yCL8JNi9956UPDfM+jmMd01xk08bIRos1+QfexrfIvByxjmWxKQI=
X-Received: by 2002:a17:907:7283:b0:b83:1327:5f88 with SMTP id
 a640c23a62f3a-b84451da312mr413764266b.16.1767828110879; Wed, 07 Jan 2026
 15:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
 <aV6sHofXnZuu84OV@bywater> <aV7lplXiOehmw2iR@bywater>
In-Reply-To: <aV7lplXiOehmw2iR@bywater>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Thu, 8 Jan 2026 00:21:38 +0100
X-Gm-Features: AQt7F2rnDbeOG2B9RyToqXJ0D-JbOha2ohKkCienNCk3aXaGyHr76CrPxJpoqUk
Message-ID: <CAHYGQ0yQ=20eFJN-_=_+uqyk=nRyotQLgf01B-Rb8NVk9N4DpQ@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:01=E2=80=AFAM Francesco Valla <francesco@valla.it=
> wrote:
>
> On Wed, Jan 07, 2026 at 07:55:26PM +0100, Francesco Valla wrote:
> > Hi Matias,
> >
> > On Wed, Jan 07, 2026 at 05:14:25PM +0100, Matias Ezequiel Vara Larsen w=
rote:
> > > On Fri, Dec 26, 2025 at 4:09=E2=80=AFPM Francesco Valla <francesco@va=
lla.it> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > > > > While stress testing this, I noticed that flooding the virtio-can
> > > > > interface with packets leads to an hang of the interface itself.
> > > > > I am seeing this issuing, at host side:
> > > > >
> > > > >       while true; do cansend can0 123#00; done
> > > > >
> > > > > with:
> > > > >
> > > > >  - QEMU: the tip of the master branch plus [2]
> > > > >  - vhost-device: the tip of the main branch
> > > > >
> > > > > and the following QEMU invocation:
> > > > >
> > > > > qemu-system-x86_64 -serial mon:stdio \
> > > > >     -m 2G -smp 2 \
> > > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > > >     -machine memory-backend=3Dpc.ram \
> > > > >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=3D=
/tmp/pc.ram,share=3Don \
> > > > >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> > > > >     -device vhost-user-can-pci,chardev=3Dcan0
> > > > >
> > > > >
> > > > > Restarting the interface (i.e.: ip link set down and the up) does=
 not
> > > > > fix the situation.
> > > > >
> > > > > I'll try to do some more testing during the next days.
> > > >
> > > > After a deep dive, I _think_ the problem actually lies in vhost-dev=
ice,
> > > > since it is not there (or al least, it seems so) using an alternati=
ve
> > > > implementation that uses the qemu socketcan support [0] (implementa=
tion
> > > > which builds on top of the work done by Harald and Mikhail):
> > > >
> > > > qemu-system-x86_64 -serial mon:stdio \
> > > >     -m 2G -smp 2 -enable-kvm \
> > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > >     -object can-bus,id=3Dcanbus0 -object can-host-socketcan,id=3Dca=
nhost0,if=3Dvcan0,canbus=3Dcanbus0 \
> > > >     -device virtio-can-pci,canbus=3Dcanbus0
> > > >
> > > > Unfortunately, my Rust knoweledge is not sufficient to understand t=
he
> > > > vhost-device implementation [1]; the issue seems to be related to t=
he
> > > > host->guest vring becoming empty and not refilling anymore.
> > > >
> > >
> > > Can you try with
> > > https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?
> >
> > I'll stress test it during the night, but this seems to fix it. Before
> > it was reproducible in a consistent manner after mere seconds, while i
> > now in a bunch of runs I never reproduced it.
> >
> > I also agree with your analysis on the commit.
> >
>
> Quick update, unfortunately not good: the RX issue is solved, but now I
> have a different one: if I send a single message either from the guset
> or the host (e.g.: cansend can0 111#00) I get:
>
> [   16.496923] irq 11: nobody cared (try booting with the "irqpoll" optio=
n)
> [   16.511875] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-00=
002-gded0a4b9da5a #29 PREEMPT(voluntary)
> [   16.511883] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   16.511887] Call Trace:
> [   16.511933]  <IRQ>
> [   16.511938]  dump_stack_lvl+0x4d/0x70
> [   16.511973]  __report_bad_irq+0x30/0xb7
> [   16.511986]  note_interrupt.cold+0x28/0x66
> [   16.511988]  handle_irq_event+0x6d/0x70
> [   16.512004]  handle_fasteoi_irq+0xd5/0x1f0
> [   16.512011]  __common_interrupt+0x3f/0xd0
> [   16.512023]  ? tick_nohz_irq_exit+0x2e/0x60
> [   16.512035]  common_interrupt+0x3b/0x90
> [   16.512057]  asm_common_interrupt+0x26/0x40
> [   16.512073] RIP: 0010:handle_softirqs+0x6d/0x270
> [   16.512081] Code: 02 00 01 00 00 89 5c 24 14 48 89 6c 24 08 c7 44 24 1=
0 0a 00 00 00 89 7c 24 04 31 c0 65 66 89 05 01 ce 3e 02 fb bb ff ff ff ff <=
49> c7 c2 c0 80 a0 a2 44 89 ed 41 0f bc dd 83 c3 01 74 76 8d 43 ff
> [   16.512082] RSP: 0018:ffffb22480003f98 EFLAGS: 00000246
> [   16.512086] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 000000000=
0000838
> [   16.512087] RDX: 0000000000000000 RSI: ffffffffa2a0e940 RDI: 000000000=
0000000
> [   16.512088] RBP: 00000000fffbac3e R08: 0000000000000001 R09: 000000000=
0000000
> [   16.512088] R10: ffffa2d57da249d0 R11: ffffb22480003ff8 R12: 000000000=
0000000
> [   16.512091] R13: 0000000000000082 R14: 0000000000000000 R15: 000000000=
0000000
> [   16.512097]  irq_exit_rcu+0x89/0xb0
> [   16.512099]  sysvec_apic_timer_interrupt+0x6b/0x80
> [   16.512103]  </IRQ>
> [   16.512104]  <TASK>
> [   16.512104]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   16.512105] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [   16.512107] Code: 2c 81 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 05 cf 18 00 fb f4 <=
c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> [   16.512109] RSP: 0018:ffffffffa2a03e80 EFLAGS: 00000212
> [   16.512110] RAX: ffffa2d5da523000 RBX: ffffffffa2a0e940 RCX: 000000000=
0000838
> [   16.512111] RDX: 4000000000000000 RSI: 0000000000000087 RDI: 000000000=
00a722c
> [   16.512111] RBP: 0000000000000000 R08: 00000000000a722c R09: ffffa2d57=
da249d0
> [   16.512112] R10: ffffa2d57da1bac0 R11: 0000000000000001 R12: 000000000=
0000000
> [   16.512112] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0014770
> [   16.512113]  default_idle+0x9/0x10
> [   16.512117]  default_idle_call+0x2a/0xf0
> [   16.512119]  do_idle+0x1cb/0x230
> [   16.512129]  cpu_startup_entry+0x24/0x30
> [   16.512130]  rest_init+0xbc/0xc0
> [   16.512133]  start_kernel+0x6d7/0x6e0
> [   16.512164]  x86_64_start_reservations+0x24/0x30
> [   16.512172]  x86_64_start_kernel+0xc8/0xd0
> [   16.512173]  common_startup_64+0x13e/0x148
> [   16.512181]  </TASK>
> [   16.512181] handlers:
> [   16.513166] [<00000000b61218c7>] vp_interrupt
> [   16.515096] Disabling IRQ #11
>
> with IRQ#11 being:
>
> # cat /proc/interrupts
>            CPU0       CPU1
>  11:     102218          0  IO-APIC  11-fasteoi   virtio0
>
>
> This cannot be reproduced with the old version of vhost-device. I think
> it is due to the removal of the req_rx_buf variable and associated
> logic: a vq kick is now being performed at every cycle of the event
> loop, even if no processing happened. At guest side, this results in a
> IRQ not cared for.
>

Thanks Francesco! right, I made a mistake. process_rx_queue() is only
invoking signal_used_queue() when req_rx_buf is true, i.e., the device
has actually added something to the used ring. I'll fix that.

Matias


