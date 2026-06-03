Return-Path: <linux-can+bounces-7748-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id clnbN+L9H2rEtgAAu9opvQ
	(envelope-from <linux-can+bounces-7748-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:11:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB16366DE
	for <lists+linux-can@lfdr.de>; Wed, 03 Jun 2026 12:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7748-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7748-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92BD930254D1
	for <lists+linux-can@lfdr.de>; Wed,  3 Jun 2026 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457C405869;
	Wed,  3 Jun 2026 10:11:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3144D01C
	for <linux-can@vger.kernel.org>; Wed,  3 Jun 2026 10:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481501; cv=none; b=BUr+5DDZO+2mgjG8ByXTyXSEe5ESyCRTsF2uIm1mkrAJnE9T1lSSRnNogr4yJb1Q57nDL/uj6TdvwvttJgWCzsliTMbNhj2TD1Ojd2SYyx5ldPlUN4xp5Zjqcx5zprziNsp5eFUWc9IslIuyTGrO5Yrb+mt8cvJmBv1yGOxv20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481501; c=relaxed/simple;
	bh=AK2sOznAjkvFHRg8B2fqIFs4SRZU3fGnFtRvrTKezCw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CCgYh57rN/hkXglxXTnPIxEUUqdBPgD7Tvwq5BMLPHYFWCPUq/+omm0asOhUF/2Vd4P80Tsum9EpAs0/WSg/H7Tqysu5vIymtPMjJOKE6NcnnWNLlFlFabQ1EkgHK3szOgO7mF0dp1a2Fko3YnL4NKpv9bZIvA/rcIgkZfaZIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69e1eb09b3aso3339048eaf.2
        for <linux-can@vger.kernel.org>; Wed, 03 Jun 2026 03:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481497; x=1781086297;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whouY7Xep/71JL90/u/R8FWyNq+woOdWY0FRwb1cIXo=;
        b=UXRgbEw0fijZZWYABzHcHvttHUfDsoeUfS82gLYnbt9S9tcqsP1FpGuXJDC4tYu925
         CNm12pMIs0E8kAxIUJTuXXAgQyheALl0ltLrYem6kb9oeYKAhfsB3YB1KMlO1QD78GFU
         zYgUq4jgH7wuhsGCMjlSVUWeJ1CbhGcfdCkfwQkcN1G7kcqfx7O9QcpPPDaq/vsojoyo
         RJaMvoXUNR2nEwAww8GQ957A19VdRkUS2UiaRIlOJDpuHKO/I4925mKQVDzPi1r5lz64
         qPshO+maYGFNuHXM0fTUIqdRVS7+VpbnANrn93AYSAJFDkKIPZa4q+oike6ysHZXyi0H
         THxg==
X-Gm-Message-State: AOJu0YwuY40TIh+NTSmUEjGMlC7Et94Ub82MXhWFdh/gx/iObvZMQv+V
	MmFERK5S7QhETorOlVKqgocxBRiDOe6wcNGSpTPBirGUpGPCUEwRVRTYcuyQpRncukXMnuw1+Do
	gJ7GAZvSj7m8X7GiwxgJtHkYFpQIqLXow/dVHf7MbaGdCCWS7xSGpqzUQUGc2rA==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e594:0:b0:69d:513e:1a41 with SMTP id
 006d021491bc7-69e480c35edmr1224537eaf.50.1780481497694; Wed, 03 Jun 2026
 03:11:37 -0700 (PDT)
Date: Wed, 03 Jun 2026 03:11:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1ffdd9.278b5b03.2bcf39.004b.GAE@google.com>
Subject: [syzbot] [can?] memory leak in can_rx_register
From: syzbot <syzbot+24201717ed2da31b8fae@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7748-lists,linux-can=lfdr.de,24201717ed2da31b8fae];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,vger.kernel.org:from_smtp,goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspotmail.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-can];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52CB16366DE

Hello,

syzbot found the following issue on:

HEAD commit:    af4e9ef3d784 uaccess: Fix scoped_user_read_access() for 'p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a7935a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=24201717ed2da31b8fae
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      [OBSOLETE] https://syzkaller.appspot.com/x/repro.syz?x=14986d5a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70cb2ebe1e6e/disk-af4e9ef3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/945fea3c8a6d/vmlinux-af4e9ef3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa6a6a5cbcc8/bzImage-af4e9ef3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24201717ed2da31b8fae@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888127ebfb40 (size 80):
  comm "syz.5.22", pid 6143, jiffies 4294942019
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 10 8b fd 08 81 88 ff ff  ................
    02 00 00 00 ff 07 00 c0 00 00 00 00 00 00 00 00  ................
  backtrace (crc 976436cd):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4520 [inline]
    slab_alloc_node mm/slub.c:4844 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
    can_rx_register+0xbf/0x220 net/can/af_can.c:461
    isotp_bind+0x470/0x510 net/can/isotp.c:1345
    __sys_bind_socket net/socket.c:1874 [inline]
    __sys_bind_socket net/socket.c:1866 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1905
    __do_sys_bind net/socket.c:1910 [inline]
    __se_sys_bind net/socket.c:1908 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1908
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888127ebfaf0 (size 80):
  comm "syz.5.22", pid 6143, jiffies 4294942019
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 cb fd 08 81 88 ff ff  ................
    00 00 00 80 ff ff ff df 00 00 00 00 00 00 00 00  ................
  backtrace (crc 4af33172):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4520 [inline]
    slab_alloc_node mm/slub.c:4844 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
    can_rx_register+0xbf/0x220 net/can/af_can.c:461
    isotp_bind+0x29f/0x510 net/can/isotp.c:1352
    __sys_bind_socket net/socket.c:1874 [inline]
    __sys_bind_socket net/socket.c:1866 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1905
    __do_sys_bind net/socket.c:1910 [inline]
    __se_sys_bind net/socket.c:1908 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1908
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888127d994b0 (size 80):
  comm "syz.6.23", pid 6176, jiffies 4294942079
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 10 8b a8 13 81 88 ff ff  ................
    02 00 00 00 ff 07 00 c0 00 00 00 00 00 00 00 00  ................
  backtrace (crc 179b079f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4520 [inline]
    slab_alloc_node mm/slub.c:4844 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
    can_rx_register+0xbf/0x220 net/can/af_can.c:461
    isotp_bind+0x470/0x510 net/can/isotp.c:1345
    __sys_bind_socket net/socket.c:1874 [inline]
    __sys_bind_socket net/socket.c:1866 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1905
    __do_sys_bind net/socket.c:1910 [inline]
    __se_sys_bind net/socket.c:1908 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1908
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888127d99460 (size 80):
  comm "syz.6.23", pid 6176, jiffies 4294942079
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 cb a8 13 81 88 ff ff  ................
    00 00 00 80 ff ff ff df 00 00 00 00 00 00 00 00  ................
  backtrace (crc ca0c0020):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4520 [inline]
    slab_alloc_node mm/slub.c:4844 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
    can_rx_register+0xbf/0x220 net/can/af_can.c:461
    isotp_bind+0x29f/0x510 net/can/isotp.c:1352
    __sys_bind_socket net/socket.c:1874 [inline]
    __sys_bind_socket net/socket.c:1866 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1905
    __do_sys_bind net/socket.c:1910 [inline]
    __se_sys_bind net/socket.c:1908 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1908
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

