Return-Path: <linux-can+bounces-5886-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3003ACD2BC6
	for <lists+linux-can@lfdr.de>; Sat, 20 Dec 2025 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12061300E4D4
	for <lists+linux-can@lfdr.de>; Sat, 20 Dec 2025 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154442FBE1C;
	Sat, 20 Dec 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YXonErfA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="31vLvB+9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9392475CF;
	Sat, 20 Dec 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221784; cv=pass; b=E7EXzkpbbLAJceC0JQm1FeqAITgVuB/oFusXYub0Qbr7uKCzSynoR/VFCtUDyGoCuPFF/2Kktxigs1kdpLwGJlTin/gPrPdu4+IMvgOcTgGkic6/8sON2H8CTV5IaIE3sTioFKDjMDv4chKgNZhOvjWDsMUna00pYm6nxb4uXkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221784; c=relaxed/simple;
	bh=+xYqBQHkOyOeI8mNHLontYHjvXCHHIRJ6MH0GfI7FhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rUUrLvFEF208LMwNfVmM+9d0bSQ01Re73POxX0KSxQ4emVBghvAh16CeGgW2dZTacvn13YBUP4fOHFo84Vrtjk8ZTlx5HHo/Sj1s07gN/Z/2YyKyCSpAZoDteGG6XEm9f5DH7T/w/8wzjBWkKr5/wjiSje23OJDodpjTxjrBMmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YXonErfA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=31vLvB+9; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1766220695; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GhJ33Ly58NIHzsLZycMsp7neI86ZNNO+x0PWVmnvf5Bqxvlit07OCfdZdfyh5W9gOk
    aCzyF7E460/tgbXxFE5eKrVJx+xgnO2QEbtrn8LMukLU9wE97lvDYK+8eq80GNSkPPMn
    E8+v1nqP5EfMMBw16045XSC9PIPZsTD3vEeRtmPR2RNVYRCHO+Zf+zvYTxE/tCi5uSnt
    qyWisHfMcfzbiRjkJoO2dNzMOydNZ6g5iv11aQOEyXdhmOmgQouHtWF36gk8lM+c3Anw
    +ND9gugo9/WzYoFKIRERNZdhxqT4oLD+fcY5FTEorvdNSMgyeke3gucSCH+86NHtfDfd
    s7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766220695;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sKbZgoo15K6tCc2NFlCG0/LydYKvQHd139PxdzHvBU8=;
    b=iVnU3d0jj246Hlp3xN612PG6zaTn3StmDGJsEcUdRCmQzLBiL8BFLXnkte8tI9eH6j
    re5u7Q++45WzeiKuFMHpnctlM5mimE3inVGmjkqiZTR1B0IC+zTkyTRc0q2Y7BYZWOKq
    nQD+Z+EQGxR2bp7qLLw6/PgspPTls2IWFP+rJGfEMsyoDwTz4muM4UY4gxA4cmZElBy+
    RVABZIwmNGrp5cKmxY/CoZ3BuVIk//zxL5e3knYXfkzxzbLKg4EkiYpp9j2Y3J7hnitv
    h2ca5kiIWFTDgb7ZA0I5FmfeeHHU0CJYkGPNBoll7+waMs+aXc1WOF+5xtmFmi6UneTb
    aGaA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766220695;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sKbZgoo15K6tCc2NFlCG0/LydYKvQHd139PxdzHvBU8=;
    b=YXonErfAPi80ef4BKlZNZKSX1aGDtNM1YUNm/zOEKLVgTAhnhCjJ6coLIHme29exId
    bn45ns+x/h/uY60vWWXRkyg4rru3new7OldoyreViHZoLt9nKQAam3xMYFqjTN4dYL/0
    DBTxZuBL3o+OQM3mW1vJQB+qx3QX2RoT3A2k+GBgrPMG66IpAdU/U58XlDNUTFVLWcKf
    11LcyR9g9So6drxWjhh1vreS5crg5h1vnDmR99+MjH76AA15wgZfFVMqhZPjOu7uzJ9x
    UCqXPqME8Wpipe4HTPTgCsIBwt6HIlzTtBIkSrBFNjgCriDEHcEF0a3WrBIGQKpvOTM9
    mnHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766220695;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sKbZgoo15K6tCc2NFlCG0/LydYKvQHd139PxdzHvBU8=;
    b=31vLvB+9Fj2WSRLFb3FsoEanbY5GMpVLx8m96/EfmK1e+w856LG/eYdlbrwhQcdxf/
    4vxXaCJERwhiMBr4i8Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b1BK8pYBlr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Dec 2025 09:51:34 +0100 (CET)
Message-ID: <380b9c67-dd42-4d3a-9527-63cad648fe43@hartkopp.net>
Date: Sat, 20 Dec 2025 09:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] INFO: task hung in cangw_pernet_exit_batch (5)
To: syzbot <syzbot+6461a4c663b104fd1169@syzkaller.appspotmail.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <69446029.a70a0220.207337.00f1.GAE@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <69446029.a70a0220.207337.00f1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

the syslog for this issue is full of bluetooth error messages that could 
be related to this recently reverted patch:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/commit/?id=252714f1e8bdd542025b16321c790458014d6880

Therefore I assume the problem not to be related to the CAN subsystem.
Let's see if after the bluetooth fix another syzbot splat shows up.

Best regards,
Oliver

On 18.12.25 21:12, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=175489b4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
> dashboard link: https://syzkaller.appspot.com/bug?extid=6461a4c663b104fd1169
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139e99c2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5fe312c4cf90/disk-8f7aa3d3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c7a1f54ef730/vmlinux-8f7aa3d3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/64a3779458bb/bzImage-8f7aa3d3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6461a4c663b104fd1169@syzkaller.appspotmail.com
> 
> INFO: task syz.0.17:6104 blocked for more than 148 seconds.
>        Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.17        state:D stack:25440 pid:6104  tgid:6104  ppid:5956   task_flags:0x400140 flags:0x00080002
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5256 [inline]
>   __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
>   __schedule_loop kernel/sched/core.c:6945 [inline]
>   schedule+0x165/0x360 kernel/sched/core.c:6960
>   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7017
>   __mutex_lock_common kernel/locking/mutex.c:692 [inline]
>   __mutex_lock+0x7e6/0x1350 kernel/locking/mutex.c:776
>   cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1288
>   ops_exit_list net/core/net_namespace.c:205 [inline]
>   ops_undo_list+0x525/0x990 net/core/net_namespace.c:252
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
> 


