Return-Path: <linux-can+bounces-3035-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F3CA58FA7
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9414188F8FF
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A522425E;
	Mon, 10 Mar 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJAwBR/4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA8223322;
	Mon, 10 Mar 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598960; cv=none; b=FooSnTJsAcHI/PKR9HbT/VOBh9KTgZ6L9bO3IIOTB2Ne4lEL1UDRS/Ho5ERouC/zvKQJb4+uT4myHYwbDx09goHLDwqN2iNIVUPWyCuq/Y8uDiKCgtjC4CO/sdeZm4L+mN0axYhQB++hZFqtKHHdUFXm0AqDZ+UoAoT2fjyGkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598960; c=relaxed/simple;
	bh=mqYHd6kKBxLoTLKZnz14N6ExdOv3oeS4J9PKVcRzCwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl4N/ZeI9PIb2jxZ9N5UhWmwXpEC6GJvqUNQAtpyKgiQRMaKzZCFC3eu0+iCuhPc9Ez6kXFwJ7lDse17hD5HOjNVqJvfoMr9Dut9Q2FGa8TAxqcla5KCfeoy4ly7SCGZVwpMmn5Zo/Yubd1sEcmc/+2EDQsYfu5azxsRtOYwvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJAwBR/4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so158219566b.0;
        Mon, 10 Mar 2025 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741598957; x=1742203757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHsRnytWl3IqQCm2g0f+U85VrmVTKV9PfLx63CyK3LA=;
        b=iJAwBR/4fwLL8p+s1yIZEuS7ErJDSyGrJcoGHjCFcX1bMaNZolrWx/Rv6eenuYpvIx
         6DZNV71rf4uAA7qFDRI8P/AEO5ddkzNNZ2/vmvdE4vT/AlbwckTKf6nM5n6Qu5SzTI38
         HdTX3U2XRyUwnvanFsexhjBtR1poLsJjrM975rX3ENrUNr28NXRgq6m7r0/xYWQvndTK
         KCYr95AIWQ45LsF1u3JReSH5R7cXMTlfJ5JFKbf3LuRrifUD8HFMbgo24NjeydBP2gNZ
         9xcnFuoDxx4/iHHCnRYWZj4aoBErmjKKH+sUGr4t4ESuyTu/N/f0NseAZAvcZtWwDKMO
         Z/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598957; x=1742203757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHsRnytWl3IqQCm2g0f+U85VrmVTKV9PfLx63CyK3LA=;
        b=uNu01DT/918mGLYJZp55i69TO0Gn/cX219pz8Sr3AcXnL8JCJ1CocTOuuK+AUNlMe4
         yVK31mt5aDCtRlEmzKsG0B7XLFdWw73jZuuB3X8L90RgIjRoYDlPQRx8UWtIByAztqnh
         yenmty/qn3nJCduPmviAlqOdxqhDtlddO0RY05URDNiIjlN3sYEgaVJU38n5eJ0lSv3t
         /q1HuFzAvmmgWxzErb1Wn0c8n1dhsfZa9dH6JGuQDn7PHWnKgc2PZ25QxaPYBZPtlyLu
         5Jeqdrp6ju4GnxivSxqbISVQ192RvqoQEKNd1ENbbvca34PWQaUNhWW2hBiQp+hSOvTG
         Sgmw==
X-Forwarded-Encrypted: i=1; AJvYcCVi3pY8/9SeGuwUv3//xh/6JNb1eLbvOkNetvjaCR84DbvgZ8rqUIjXf7uYfxn7OktSt1/bKJM9PaE/enzq@vger.kernel.org, AJvYcCW6PKzLb4S09Q/AGStMlFiBMBmLgQCKTx3VeYK68j0bodaZxVsmlN2kEcnZVd897mZvvnqD+Zo7nnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznu9U9wxU5vKQOQx1fCEYx7WfvH85HMyKdHJ+pNMGVz6ifrUHm
	BfhPfhk6VVbC2LdHGvJShTG/EYb7inKRgp5UHfGORMNwDsEORcPgjG1a6vhKUx5YBRc2nVt/lik
	69GDWMLZnsdeJWXlGTCOegWxYmmA=
X-Gm-Gg: ASbGncuVQ1WDnSv0NQ2k/1LPRakm3pNILvmm8bWVBVSOgj7563YuNvjJ9J8P9rVVH4J
	7byMjXb49/uSPsQT/sNWSt0UxPH33uvbElDsnVILhHQyrgNeGBIutDZsDfFCvCn/GiwV0cRAKUa
	lH4k3tN9Ubsjp0iTluxgWYtGWQkw==
X-Google-Smtp-Source: AGHT+IFqzRaJCvizbAtt6mkDFSF4hHcpR3dfChzlydkMQedqh0wNQ4VeICb1xuN5+jx9avy9xkuDarz3OWDLAFkdmLc=
X-Received: by 2002:a17:907:2da4:b0:ac2:9aa4:2ce4 with SMTP id
 a640c23a62f3a-ac29aa42dfamr466873066b.53.1741598956401; Mon, 10 Mar 2025
 02:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67cd717d.050a0220.e1a89.0006.GAE@google.com> <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
In-Reply-To: <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Mon, 10 Mar 2025 18:29:04 +0900
X-Gm-Features: AQ5f1Jr1zZ0toyU3Ymmac5u6imzl9amcli6qHCE3tyLm3iNF616jynoKBpnqJYU
Message-ID: <CAMZ6RqKyMreMfNDmYU=tLyaEcReopmGx2VkBWPB12LLzd5o7Pg@mail.gmail.com>
Subject: Re: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, 
	syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon. 10 Mar 2025 at 03:59, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hello Marc,
>
> On 09.03.25 11:46, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0f52fd4f67c6 Merge tag 'bcachefs-2025-03-06' of git://evil..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12d12a54580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=523b0e2f15224775
> > dashboard link: https://syzkaller.appspot.com/bug?extid=78ce4489b812515d5e4d
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/eb0d7b540c67/disk-0f52fd4f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/51c261332ad9/vmlinux-0f52fd4f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/38914a4790c8/bzImage-0f52fd4f.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in can_send / can_send
> >
> > read-write to 0xffff888117566290 of 8 bytes by interrupt on cpu 0:
> >   can_send+0x5a2/0x6d0 net/can/af_can.c:290
> >   bcm_can_tx+0x314/0x420 net/can/bcm.c:314
> >   bcm_tx_timeout_handler+0xea/0x280
> >   __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
> >   __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1865
> >   hrtimer_run_softirq+0xe4/0x2c0 kernel/time/hrtimer.c:1882
> >   handle_softirqs+0xbf/0x280 kernel/softirq.c:561
> >   run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
> >   smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
> >   kthread+0x4ae/0x520 kernel/kthread.c:464
> >   ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > read-write to 0xffff888117566290 of 8 bytes by interrupt on cpu 1:
> >   can_send+0x5a2/0x6d0 net/can/af_can.c:290
> >   bcm_can_tx+0x314/0x420 net/can/bcm.c:314
> >   bcm_tx_timeout_handler+0xea/0x280
> >   __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
> >   __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1865
> >   hrtimer_run_softirq+0xe4/0x2c0 kernel/time/hrtimer.c:1882
> >   handle_softirqs+0xbf/0x280 kernel/softirq.c:561
> >   run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
> >   smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
> >   kthread+0x4ae/0x520 kernel/kthread.c:464
> >   ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > value changed: 0x0000000000002b9d -> 0x0000000000002b9e
> >
>
> Increased by '1' ...
>
> I assume this problem is caused by increasing the per-netdevice statistic in
>
> https://elixir.bootlin.com/linux/v6.13.6/source/net/can/af_can.c#L289
>
> pkg_stats->tx_frames++;
> pkg_stats->tx_frames_delta++;
>
> We update the statistics for the device and in this specific case the
> hrtimer fired on two CPUs resulting in a can_send() to the same netdevice.
>
> Do you agree with this quick analysis?

Ack. Same conclusion here.

> Isn't there some lock-less per-cpu safe statistic handling within netdev
> we might pick for our use-case?

I see two solutions. Either we use lock_sock(skb->sk) and
release_sock(skb->sk) or we can change the types of
can_pkg_stats->tx_frames and can_pkg_stats->tx_frames_delta from long
to atomic_long_t.

The atomic_long_t is the closest solution to a lock-less. But my
preference goes to the lock_sock() which looks more natural in this
context. And look_sock() is just a spinlock which under the hood is
also an atomic, so no big penalty either.


Yours sincerely,
Vincent Mailhol

