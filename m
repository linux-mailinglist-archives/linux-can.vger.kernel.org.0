Return-Path: <linux-can+bounces-3030-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF75A5876F
	for <lists+linux-can@lfdr.de>; Sun,  9 Mar 2025 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11883166283
	for <lists+linux-can@lfdr.de>; Sun,  9 Mar 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F31DEFE4;
	Sun,  9 Mar 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Wmlw7Ope";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kTIEeRCu"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764871DA0E0;
	Sun,  9 Mar 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546771; cv=pass; b=jwG4OTDBkt+bUZI/89EsZz8x/+u1PL34cjmWzmy5Yttfj9jipvR4vYOAftB3PzTMj6Gq9KR1dJUvrJeKj/NOt29ZB7n/LKneorBqqqOsW1dCce6s5RmMPgnR2oNVIedIcvDSPO5/XyyDgHOt0F0uawYAB7mGmLP9525/uVuAEaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546771; c=relaxed/simple;
	bh=+MbBpKKuJKK0Ybn6pjZFnv5ufwznv1SGiyfyOPyeEfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=K8wn1ZBmja9+p/Yc5V7ohLYBMnkl/v96zRxmrLBcu2dV+D9OrVO6e8uPqga14vD40DxsnVCr232mBsYlUNcIpBk/bGTI2DRbPVkTBGxRznoVhDOlQXcWu7Km1HE4u5MaBPWKoFkdJpSTkPqEIs2AbmbYq2SXU4oOSztcMiPmyyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Wmlw7Ope; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kTIEeRCu; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1741546044; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E/n2wBNSGxnWwNiUdp3g9u4bRyHiKKSwFSpI7Xcb74nF5TeI09HuTBPrJRT+4nFeUz
    ksxnVXGIe7exbE5FvXfWLi2CEz+6QPDIU8jvxmfHjERqUc2cYc56wHFbf66iFXRQw3qp
    xXBBdTE0+UORnhUUpDa694df7ZLgOur+XXq+ySNAbVH+TSSpYgJIrYa7Zf+V1ZdlmnQm
    9EXAB7QDGFsoPMQ8YYKl79vpA5CNmH2DoqxXc3fUJzbjs2c6NJqktMBM5HwXhnAbnzMH
    tOkEnyS8mtsNg/Hw7fdPTenYO8QW43kakCqS3AsURFqpPgelWEaGQiQxKOnljhTPAneE
    IGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741546044;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0VIIqdmoRNGEpXgGs6HGzncaolpdEE7DgMVPQ+A3/2I=;
    b=JhPD/xMnXLFsE7TnQrZ2uPpvOOyOT2w6A4NThSQJ53XoQ4tkGHZjreXQZmouJbJWF4
    pgGi4bTzni5KgqkU5hsKziAlsAw+rBGdp+wKfBqtqCOmq0HgkOcfqvtmwzviZpkbh5hY
    03IXvzu6RmT+Jfi80bxxsa0QxxI+yAJoJrcOKhiAfBiwsCgPSsM9lpCSzttIVUpcXVOt
    t1yRnG3YK+FwU9uC8DX5lz/hhXUGwvNE6tFnbTbnFYbdun1s17l/ADJw/9ciSPtCPCaw
    P4/QDBQPxpy5Ru1/b0s4PXsHm3bvSXPljq9ay2navq9pKeRkfDbA1ilP8zVtZtliA1h2
    5d0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741546044;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0VIIqdmoRNGEpXgGs6HGzncaolpdEE7DgMVPQ+A3/2I=;
    b=Wmlw7OpezyliDHMC+Pd0G5+vKz3tzHHAVIaBbdte34TYxZfvKZoreJb2UnvHECvg7h
    wpiM86c60fd9rh7Ur5q0ioHpjyvpSwrd+GokxfYllw1OxXFZ+r+cwsa2fF5tBeACLIUL
    6tS4Npw3MiU7adgjqRYGLne+ByJNUBEmsrmqldEsAhlN+HWlX2vj3Ma/375efx1CDPpT
    Ne5LqG0IqG4ROySdfG9hUr00+jNwdZRZB+wz07VmkEpEyX3TLiEk/ADMjGWlxx44Zx/u
    BmWdSlECgrel8tB/43ESoCLIKJzu1kqQEhTlMP6mfPuyUvIbIUSN+3gdtRjRqcY69Xl0
    qt2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741546044;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=0VIIqdmoRNGEpXgGs6HGzncaolpdEE7DgMVPQ+A3/2I=;
    b=kTIEeRCu3WcWaGHt11BkQsNfYikd0EPLJhld2F4q+w9XJBBkye5AVIMEvaQ775YTU2
    Bxq791RMnxj/Qk5179Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e5129IlOQ9h
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 9 Mar 2025 19:47:24 +0100 (CET)
Message-ID: <c9047828-708a-42d8-97f6-fffb7d806679@hartkopp.net>
Date: Sun, 9 Mar 2025 19:47:17 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] KCSAN: data-race in can_send / can_send (5)
To: mkl@pengutronix.de
References: <67cd717d.050a0220.e1a89.0006.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-can@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <67cd717d.050a0220.e1a89.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

On 09.03.25 11:46, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0f52fd4f67c6 Merge tag 'bcachefs-2025-03-06' of git://evil..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d12a54580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=523b0e2f15224775
> dashboard link: https://syzkaller.appspot.com/bug?extid=78ce4489b812515d5e4d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb0d7b540c67/disk-0f52fd4f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/51c261332ad9/vmlinux-0f52fd4f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/38914a4790c8/bzImage-0f52fd4f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in can_send / can_send
> 
> read-write to 0xffff888117566290 of 8 bytes by interrupt on cpu 0:
>   can_send+0x5a2/0x6d0 net/can/af_can.c:290
>   bcm_can_tx+0x314/0x420 net/can/bcm.c:314
>   bcm_tx_timeout_handler+0xea/0x280
>   __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
>   __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1865
>   hrtimer_run_softirq+0xe4/0x2c0 kernel/time/hrtimer.c:1882
>   handle_softirqs+0xbf/0x280 kernel/softirq.c:561
>   run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
>   smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
>   kthread+0x4ae/0x520 kernel/kthread.c:464
>   ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> read-write to 0xffff888117566290 of 8 bytes by interrupt on cpu 1:
>   can_send+0x5a2/0x6d0 net/can/af_can.c:290
>   bcm_can_tx+0x314/0x420 net/can/bcm.c:314
>   bcm_tx_timeout_handler+0xea/0x280
>   __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
>   __hrtimer_run_queues+0x20d/0x5e0 kernel/time/hrtimer.c:1865
>   hrtimer_run_softirq+0xe4/0x2c0 kernel/time/hrtimer.c:1882
>   handle_softirqs+0xbf/0x280 kernel/softirq.c:561
>   run_ksoftirqd+0x1c/0x30 kernel/softirq.c:950
>   smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
>   kthread+0x4ae/0x520 kernel/kthread.c:464
>   ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> value changed: 0x0000000000002b9d -> 0x0000000000002b9e
> 

Increased by '1' ...

I assume this problem is caused by increasing the per-netdevice statistic in

https://elixir.bootlin.com/linux/v6.13.6/source/net/can/af_can.c#L289

pkg_stats->tx_frames++;
pkg_stats->tx_frames_delta++;

We update the statistics for the device and in this specific case the 
hrtimer fired on two CPUs resulting in a can_send() to the same netdevice.

Do you agree with this quick analysis?

Isn't there some lock-less per-cpu safe statistic handling within netdev 
we might pick for our use-case?

Best regards,
Oliver

> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Tainted: G        W          6.14.0-rc5-syzkaller-00109-g0f52fd4f67c6 #0
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


